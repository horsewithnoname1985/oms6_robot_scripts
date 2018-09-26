import configparser
from configparser import NoOptionError, NoSectionError


def __get_ini_file_content(ini_file_path):

    """Returns the content of ini files as an OrderedDict"""

    config = configparser.ConfigParser()
    config.read(ini_file_path)

    return config


def get_ini_value(ini_file_path, section_name, parameter_key):

    content = __get_ini_file_content(ini_file_path)

    try:
        value = content.get(section_name, parameter_key)
        return value
    except NoOptionError:
        raise NoOptionError(str(parameter_key), str(section_name))
    except NoSectionError:
        raise NoSectionError(str(section_name))
