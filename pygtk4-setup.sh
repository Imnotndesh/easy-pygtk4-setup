#!/bin/bash
# Make sure to exxecute this inside a directory of your choice
# This script is intended for use with debian based systems but has only been tested with ubuntu
# Big thanks to Taiko2k for the amazing work with his pyGtk4 tutorial...Saved me alot 😂😂😂
# His worked is linked in the app by clicking on the documentation button on the app

# Getting updates first 
sudo apt update

# Necessary dependancies for pyGTK4
sudo apt-get -qq install python3 python3-gi python3-gi-cairo gir1.2-gtk-4.0 gir1.2-adw-1 python3-venv -y

# Setting up venv in directory
python3 -m venv appPyContainer

# Switching to the venv interprator
source ./appPyContainer/bin/activate

# Updating pip
python3 -m pip install --upgrade pip

# Insalling necessary pip packages
pip install pyCairo PyGObject

echo "Finished setting up dev environment"
echo "Checking if works!"
# Testing if it works

# Sample PyGTK4 app code
main_code="""
import gi
import sys
import webbrowser

gi.require_version('Gtk', '4.0')
gi.require_version('Adw', '1')
from gi.repository import Gtk, Adw


class MainWindow(Gtk.ApplicationWindow):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.set_default_size(480, 200)
        self.set_title('Sample App')
        self.box1 = Gtk.Box(orientation = Gtk.Orientation.VERTICAL)
        self.box1.set_margin_top(10)
        self.box1.set_margin_bottom(10)
        self.box1.set_margin_start(10)
        self.box1.set_margin_end(10)
        self.set_child(self.box1)

        self.label = Gtk.Label(label='Installation successful')
        self.box1.append(self.label)
        self.box1.set_spacing(10)

        self.button = Gtk.Button(label='View documentation')
        self.button.connect('clicked',self.docsOpener)
        self.box1.append(self.button)
    def docsOpener(self, button):
        link = 'https://github.com/Taiko2k/GTK4PythonTutorial'
        webbrowser.open(link)
class MyApp(Adw.Application):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.connect('activate', self.on_activate)

    def on_activate(self, app):
        self.win = MainWindow(application=app)
        self.win.present()

app = MyApp(application_id='com.example.WorkingGUI')
app.run(sys.argv)
"""

# Writing a sample gtk applcation to python file 
echo "$main_code" > main.py

# Running the python file
python main.py

# Done
