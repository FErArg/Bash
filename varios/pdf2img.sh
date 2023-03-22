#!/bin/bash
$pdf=$1

convert -density 300 -trim $pdf -quality 100 $pdf.png