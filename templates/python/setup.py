# Copyright 2023 Robert Bosch GmbH
#
# SPDX-License-Identifier: Apache-2.0

import os
from setuptools import setup, find_namespace_packages


__INSTALL_REQUIRES__ = [
    'flatbuffers==2.0',
]

__CONSOLE_SCRIPTS__ = []


__NAME__            = 'dse.schemas'
__VERSION__         = os.getenv('PACKAGE_VERSION', 'none')
__URL__             = 'https://github.com/boschglobal/dse.schemas.git'
__LICENSE__         = 'Apache-2.0'
__AUTHOR__          = 'Timothy Rule'
__AUTHOR_EMAIL__    = 'Timothy.Rule@de.bosch.com'
__PYTHON_MIN_VER__  = '3.8'
__NAMESPACE__       = 'dse'
__KEYWORDS__        = ('dse', 'simbus', 'fsil')
__DESCRIPTION__     = 'DSE Schemas'

__DESCRIPTION_LONG__ = """
DSE Schemas
===========

Schemas of the Dynamic Simulation Environment (DSE) Core Platform.

"""


setup(
    name = __NAME__,
    version = __VERSION__,
    author = __AUTHOR__,
    author_email = __AUTHOR_EMAIL__,
    license = __LICENSE__,
    description = __DESCRIPTION__,
    long_description = __DESCRIPTION_LONG__,
    long_description_content_type = 'text/markdown',
    url = __URL__,
    keywords = ' '.join(__KEYWORDS__),
    packages = find_namespace_packages(include=[f'{__NAMESPACE__}.*']),
    python_requires = f'>={__PYTHON_MIN_VER__}',
    install_requires = __INSTALL_REQUIRES__,
    setup_requires = [],
    include_package_data = True,
    zip_safe = False,

    entry_points = {
        'console_scripts' : __CONSOLE_SCRIPTS__,
    },

    classifiers=[
        'License :: Other/Proprietary License',
        f'License :: {__LICENSE__}',
        'Natural Language :: English',
        'Operating System :: POSIX :: Linux',
        f'Programming Language :: Python :: {__PYTHON_MIN_VER__}',
        "Topic :: Software Development :: Simulation",
    ],
)
