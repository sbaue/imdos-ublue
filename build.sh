#!/bin/bash

RPM_OL=$(cat /tmp/rpm_overlay | egrep -v "(^#.*|^$)")
RPM_IN=$(cat /tmp/rpm_install | egrep -v "(^#.*|^$)")

echo "-- Applying overlay as defined in rpm_overlay --"
for pkg in $(echo -e "$RPM_OL"); do \
    echo "Removing: ${pkg}" && \
    rpm-ostree override remove $pkg; \
done

echo "---"

echo "-- Applying layering as defined in rpm_install --"
for pkg in $(echo -e "$RPM_IN"); do \
    echo "Installing: ${pkg}" && \
    rpm-ostree install $pkg; \
done
echo "---"
