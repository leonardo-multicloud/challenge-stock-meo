import pytest
from api_backend.main import app

API_KEY = "123"

@pytest.fixture
def client():
    app.config['TESTING'] = True
    client = app.test_client()
    return client

def test_health_endpoint(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json == {"status": "ok"}

def test_get_available_currencies_unauthorized(client):
    response = client.get("/price/available")
    assert response.status_code == 401
    assert response.json == {"error": "Unauthorized"}

def test_get_currency_status_unauthorized(client):
    response = client.get("/price/stats/USD")
    assert response.status_code == 401
    assert response.json == {"error": "Unauthorized"}

def test_get_available_currencies_mocked(mocker, client):
    mock_response = mocker.Mock()
    mock_response.status_code = 200
    mock_response.content = b"<root><USD>Dollar</USD><EUR>Euro</EUR></root>"
    
    mocker.patch("requests.get", return_value=mock_response)

    response = client.get("/price/available", headers={"X-API-KEY": API_KEY})
    assert response.status_code == 200
    assert response.json == {"USD": "Dollar", "EUR": "Euro"}

def test_get_currency_status_mocked(mocker, client):
    mock_response = mocker.Mock()
    mock_response.status_code = 200
    mock_response.json.return_value = {"USDBRL": {"bid": "5.50"}}
    
    mocker.patch("requests.get", return_value=mock_response)

    response = client.get("/price/stats/USD", headers={"X-API-KEY": API_KEY})
    assert response.status_code == 200
    assert response.json == {"USDBRL": {"bid": "5.50"}}
