From: Jim Curtis <jicurtis@redhat.com>
Subject: How to leverage ceph udev rules for containerized ceph
Date: Mon, 14 Mar 2016 11:34:25 -0700
Message-ID: <CAGEA57c3e1mSZE6869GQzA5DFZ5ZqdLO1beasUgg8Lzak+0xxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:32910 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcCNSee (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2016 14:34:34 -0400
Received: by mail-io0-f169.google.com with SMTP id n190so233645412iof.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2016 11:34:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Greeting ceph-devel,

We are working on a ceph containerization project within Red Hat.  We
have recently released our RHEL-based ceph container docker image and
now we are moving on to handling a feature limitation with that image.

Specifically, the issue is that on our Atomic host, there is no ceph
installed, so there are no ceph udev rules to trigger dynamic
configuration of OSDs when a disk is plugged into the host.

What we would like to do is install our own set of ceph udev rules
that would trigger the startup of our ceph docker container.  We would
like to leverage the current implementation of the ceph udev rules to
do this.

Also, since ceph-disk and Ceph's udev rules are tightly coupled and
ceph-disk creates systemd or upstart rules for OSD daemons, does it
make sense to add hooks in ceph-disk to start up a containerized OSD
daemons either in systemd or upstart?

Can somebody in this community help us with this?

Thanks,

Jim C.
