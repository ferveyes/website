from browser import window


def say(text, *args, onend=None, lang=None):
    ut = window.SpeechSynthesisUtterance.new(str(text).format(*args));
    if callable(onend):
        ut.onend = onend
    if lang:
        tu.lang = lang
    window.speechSynthesis.speak(ut);
