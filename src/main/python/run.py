# repo.archive(open(join(rw_dir, 'archived_file.zip'), 'wb'))
# repo = Repo('path to the directory which has .git folder')

import sys
while True:
    s = raw_input("Enter command: ")
    print "You entered: {}".format(s)
    sys.stdout.flush()


from threading import Thread
from Queue import Queue, Empty

class NonBlockingStreamReader:

    def __init__(self, stream):
        '''
        stream: the stream to read from.
                Usually a process' stdout or stderr.
        '''

        self._s = stream
        self._q = Queue()

        def _populateQueue(stream, queue):
            '''
            Collect lines from 'stream' and put them in 'quque'.
            '''

            while True:
                line = stream.readline()
                if line:
                    queue.put(line)
                else:
                    raise UnexpectedEndOfStream

        self._t = Thread(target = _populateQueue,
                         args = (self._s, self._q))
        self._t.daemon = True
        self._t.start() #start collecting lines from the stream

    def readline(self, timeout = None):
        try:
            return self._q.get(block = timeout is not None,
                               timeout = timeout)
        except Empty:
            return None

class UnexpectedEndOfStream(Exception): pass


from subprocess import Popen, PIPE
from time import sleep
from nbstreamreader import NonBlockingStreamReader as NBSR

# run the shell as a subprocess:
p = Popen(['python', 'shell.py'],
          stdin = PIPE, stdout = PIPE, stderr = PIPE, shell = False)
# wrap p.stdout with a NonBlockingStreamReader object:
nbsr = NBSR(p.stdout)
# issue command:
p.stdin.write('command\n')
# get the output
i = 0
while True:
    output = nbsr.readline(0.1)
    # 0.1 secs to let the shell output the result
    if not output:
        print "time out the response took to long..."
        #do nothing, retry reading..
        continue
    if "Enter command:" in output:
        p.stdin.write('try it again' + str(i) + '\n')
        i += 1
    print output