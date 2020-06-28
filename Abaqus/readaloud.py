from random import randint


def concat(func):
    def inner(*args, **kwargs):
        return "".join(func(*args, **kwargs))
    return inner


class ReadAloud:
    def __init__(self, say,
                 units=10, digits=2, loop=4,
                 subtraction=True, onend=None):
        self.say = say
        self.units = units
        self.digits = digits
        self.loop = loop
        self.subtraction = subtraction
        self.onend = onend

        self.count = 0

    @concat
    def unit(self, num):
        yield "{}ばん。ねがいましてわ。".format(num)

        ans = 0
        prev = 0
        for loop in reversed(range(self.loop)):
            N = 0
            while not N:
                n = 10 ** self.digits - 1
                if self.subtraction:
                    N = randint(-n, n)
                else:
                    N = randint(1, n)
            ans += N
            if N < 0:
                prefix = prev >= 0 and "ひいてわ" or ""
            else:
                prefix = prev < 0 and "くわえてわ" or ""
            if loop:
                yield "{}{}えんなり。".format(prefix, abs(N))
            else:
                yield "{}{}えんでわ。".format(prefix, abs(N))
            prev = N

        yield "っ。っ。"
        yield "その答えは{}{}円です。".format(ans < 0 and "マイナス" or "", abs(ans))

    def start(self, evt):
        if self.count == self.units:
            callable(self.onend) and self.onend(evt)
        else:
            self.say(self.unit(self.count + 1), onend=self.start, lang="ja-JP")
            self.count += 1
