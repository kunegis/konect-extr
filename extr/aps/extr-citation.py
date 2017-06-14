# extract the APS citation network with timestamp

import sys
import pandas as pd

def main(f1, f2):
    sys.stdout.write('%')

    df_ci = pd.read_csv(f1)
    df_ts = pd.read_csv(f2)

    df_merged = pd.merge(df_ci, df_ts, on='citing_doi')
    df_merged.to_csv(sys.stdout, index=False, sep=' ')

if __name__ == '__main__':
    # init
    # argv[1]: citation network
    # argv[2]: paper-timestamp data
    main(sys.argv[1], sys.argv[2])
