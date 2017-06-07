import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
try:
    import cv2
except Exception as e:
    pass
import skimage.io
import skimage.color
import skimage.transform
import skimage.data
import skimage.feature

import os
import sys
import subprocess
import shutil

import re
import codecs
import datetime
import time

import logging

logging.basicConfig(
    format='[%(asctime)s %(name)s %(levelname)s] - %(message)s',
    datefmt='%Y/%m/%d %H:%M:%S',
    level=logging.DEBUG)

logging.getLogger('PIL').setLevel(logging.WARNING)
logging.getLogger('requests').setLevel(logging.WARNING)
logging.getLogger('sklearn').setLevel(logging.WARNING)
logging.getLogger('gensim').setLevel(logging.WARNING)
