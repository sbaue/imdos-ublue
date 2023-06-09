#!/bin/bash

RPM_OL=$(cat /tmp/rpm_overlay | egrep -v "(^#.*|^$)")
RPM_IN=$(cat /tmp/rpm_install | egrep -v "(^#.*|^$)")

echo "---"

echo "-- Applying overlay as defined in rpm_overlay --"
echo "Removing: $RPM_OL" 
rpm-ostree override remove $RPM_OL


echo "-- Applying layering as defined in rpm_install --"
echo "Installing: $RPM_IN"
rpm-ostree install $RPM_IN

echo "---"