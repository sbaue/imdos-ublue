#!/bin/bash

echo "-- Applying overlay as defined in rpm_overlay --"
rpm_overlay=$(cat rpm_overlay | egrep -v "(^#.*|^$)")
for pkg in $(echo -e "$rpm_overlay"); do \
    echo "Installing: ${pkg}" && \
    rpm-ostree override remove $pkg; \
done
echo "---"

echo "-- Applying layering as defined in rpm_install --"
rpm_install=$(cat rpm_install | egrep -v "(^#.*|^$)")
for pkg in $(echo -e "$rpm_install"); do \
    echo "Installing: ${pkg}" && \
    rpm-ostree install $pkg; \
done
echo "---"