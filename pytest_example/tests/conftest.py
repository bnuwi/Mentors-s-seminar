import pytest
import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from calculator import Calculator

@pytest.fixture
def calc():
    return Calculator()