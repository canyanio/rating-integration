import os

from click.testing import CliRunner
from canyantester import canyantester


TARGET = os.environ.get('TARGET', 'kamailio:5060')
API_URL = os.environ.get('API_URL', 'http://rating-api:8000')


def test_kamailio_authorized():
    base_dir = os.path.dirname(__file__)
    scenario_file = os.path.join(base_dir, 'scenarios', 'test_kamailio_authorized.yaml')
    result = CliRunner().invoke(canyantester, ['-a', API_URL, '-t', TARGET, scenario_file])
    assert result.exit_code == 0