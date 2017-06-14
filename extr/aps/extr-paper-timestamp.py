# parse paper-timestamp from JSON files

import json
import sys

def main(files):
    print 'citing_doi,ts'
    for f in files:
        json_str = open(f).read()
        paper = json.loads(json_str)
        print paper.get('id') + ',' + paper.get('date')

if __name__ == '__main__':
    # init
    main(sys.argv[1:])
