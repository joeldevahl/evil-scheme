settings = NewSettings()
settings.cc.includes:Add("src")
src = Collect("src/*.c")
obj = Compile(settings, src)
bin = Link(settings, "run", obj)