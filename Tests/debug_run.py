import subprocess
import sys

if __name__ == '__main__':

    run_args = ''
    for args in sys.argv:
        run_args += args

    subprocess.call('robot' + args)