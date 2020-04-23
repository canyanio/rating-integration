import os

from canyantester import run_tester


TARGET = os.environ.get('TARGET_KAMAILIO', 'kamailio:5060')
API_URL = os.environ.get('API_URL', 'http://rating-api:8000')


def test_kamailio_authorized():
    base_dir = os.path.dirname(__file__)
    scenario_file = os.path.join(base_dir, 'scenarios', 'test_authorized.yaml')
    run_tester(config=scenario_file, apiurl=API_URL, target=TARGET)
