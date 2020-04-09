import os

from click.testing import CliRunner
from canyantester import canyantester


TARGET = os.environ.get('TARGET_KAMAILIO', 'kamailio:5060')
API_URL = os.environ.get('API_URL', 'http://rating-api:8000')


def test_kamailio_unauthorized_too_many_transactions():
    base_dir = os.path.dirname(__file__)
    scenario_file = os.path.join(base_dir, 'scenarios', 'test_unauthorized_too_many_transactions.yaml')
    result = CliRunner().invoke(canyantester, ['-a', API_URL, '-t', TARGET, scenario_file])
    assert result.exit_code == 0
