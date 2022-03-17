import requests
import pandas as pd
import click
import os


def timestamped(fname):
    """ Create a timestamped filename """
    import datetime
    import pytz
    timestamp = datetime.datetime.utcnow().replace(microsecond=0, tzinfo=datetime.timezone.utc)
    return '{}__{}'.format(timestamp.isoformat(), fname)


@click.command()
@click.argument('out_dir', type=click.Path())
@click.option('--station', type=int, required=True)
@click.option('--lookahead', type=int, default=30)
def dump_departures(out_dir, station, lookahead):

    raw = pd.DataFrame(requests.get(f'https://start.vag.de/dm/api/v1/abfahrten/VGN/{station}?timespan={lookahead}').json()['Abfahrten'])

    raw.to_csv(
        os.path.join(out_dir, timestamped(f'departures-{station}.csv')), 
        index=False
    )


if __name__ == '__main__':
    dump_departures()
