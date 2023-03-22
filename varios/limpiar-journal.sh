#!/bin/bash

# comprueba log y sistema
journalctl --verify

#limpia archivos mayores a 50 megas
journalctl --vacuum-size=50M