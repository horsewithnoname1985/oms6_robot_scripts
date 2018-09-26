from SeleniumLibrary import SeleniumLibrary
from robot.libraries.BuiltIn import BuiltIn
from SeleniumLibrary.keywords.javascript import JavaScriptKeywords
from robot.api.deco import keyword

ROBOT_CONTINUE_ON_FAILURE = True

# python -m robot.libdoc ./Libraries/MyExtendedSeleniumLibrary.py ./Libraries/MyExtendedSeleniumLibrary_doc.html


class MyExtendedSeleniumLibrary:
    """
    The _MyExtendedSeleniumLibrary_ is, as the name says, an extension to the
    existing SeleniumLibrary
    (https://github.com/robotframework/SeleniumLibrary/) and comprises of
    methods, that are useful but not found in the original library.\n
    Please also refer to the
    [http://robotframework.org/SeleniumLibrary/SeleniumLibrary.html|
    SeleniumLibrary documentation] for a detailed explanation of how web
    element interaction is applied in general.
    """

    ROBOT_LIBRARY_TEST_DOC_FORMAT = 'ROBOT'
    __version__ = '0.1'

    def __init__(self):
        pass

    @keyword
    def scroll_to_element(self, locator):
        """
        Click element ``locator`` (scrolls into view automatically)

        Examples:
        | =Setting=             | =Value=           | =Comment=                         |
        | `Scroll To Element`   | _${element_id}_   | Scrolls element with id into view |
        """
        seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
        javascriptkeywordlib = JavaScriptKeywords(ctx=seleniumlib)

        element = SeleniumLibrary.find_element(seleniumlib, locator)
        script = "return arguments[0].scrollIntoView();"

        JavaScriptKeywords.execute_javascript(
            javascriptkeywordlib,
            script, "ARGUMENTS", element)
