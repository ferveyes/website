from browser import document


class Buttons:
    def __init__(self):
        self.buttons = []

    def add(self, ident):
        self.buttons.append(document[ident])

    def enable(self, *_):
       for button in self.buttons:
            button.disabled = False

    def disable(self):
        for button in self.buttons:
            button.disabled = True
