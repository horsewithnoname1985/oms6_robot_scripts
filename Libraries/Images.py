#! python
# Images.py - Covers all image files actions

import cv2
from robot.api import logger
from skimage.measure import compare_ssim as ssim

# ROBOT_LIBRARY_SCOPE = "Oms6 Client Restart"

# http://www.pyimagesearch.com/2014/09/15/python-compare-two-images/


def read_image(image_path):
    image = cv2.imread(image_path)


def compare_images(ref_path, sample_path, minimum_ssim):
    # Read image files
    reference = cv2.imread(ref_path)
    sample = cv2.imread(sample_path)

    # compare image files
    s = ssim(reference, sample, multichannel=True)
    if s > float(minimum_ssim):
        logger.info("The images are equal")
        logger.info(str(s) + " > " + str(float(minimum_ssim)))
        return True
    else:
        logger.warn("The images are not equal")
        logger.info(str(s) + " < " + str(float(minimum_ssim)))
        return False
