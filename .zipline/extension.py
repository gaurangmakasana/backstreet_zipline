import pandas as pd
from zipline.data.bundles import register
from zipline.data.bundles.csvdir import csvdir_equities

# Set the start and end dates of the bars, should also align with the Trading Calendar
start_session = pd.Timestamp('2005-1-3', tz='utc')
end_session = pd.Timestamp('2020-10-26', tz='utc')


register(
    'custom-bundle',   # What to call the new bundle
    csvdir_equities(
        ['daily'],  # Are these daily or minute bars
        '/home/backstreet/use_zipline/prepare_custom_bundle/data/csvs',  # Directory where the formatted bar data is
    ),
    calendar_name='NYSE', # US equities default
    start_session=start_session,
    end_session=end_session
)


"""
Some commandline reference code on ingesting and cleaning up data bundles
zipline bundles
zipline clean -b custom-csvdir-bundle --keep-last 1
zipline clean -b custom-csvdir-bundle --after 2020-10-1
zipline ingest -b test-csvdir
"""
