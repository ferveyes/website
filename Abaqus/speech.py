from browser import window


try:
    ios_kyoko = [voice for voice in window.speechSynthesis.getVoices()
                 if voice.name.lower() == 'kyoko'][0]
except IndexError:
    ios_kyoko = None


def say(text, *args, onend=None, lang="ja-JP", voice=ios_kyoko):
    ut = window.SpeechSynthesisUtterance.new(str(text).format(*args));
    if callable(onend):
        ut.onend = onend
    if lang:
        ut.lang = lang
    if voice:
        ut.voice = voice;

    window.speechSynthesis.speak(ut);
