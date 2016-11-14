#!/bin/bash

: "${PROJECT_ROOT?Need to set PROJECT_ROOT}"

ripper-tags -R ${PROJECT_ROOT} `bundle show --paths`
