from browser import window


def say(text, *args, onend=None):
    ut = window.SpeechSynthesisUtterance.new(str(text).format(*args));
    if callable(onend):
        ut.onend = onend
    window.speechSynthesis.speak(ut);
