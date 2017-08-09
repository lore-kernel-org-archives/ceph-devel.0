From: John Spray <jspray@redhat.com>
Subject: Prometheus: associating disk+nic metrics with OSDs
Date: Wed, 9 Aug 2017 15:10:12 +0100
Message-ID: <CALe9h7dNvBQ5F7=ie-GM-6kTG2+thX1rJdNd8V+gJYk1F0CipQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36192 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbdHIOKe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Aug 2017 10:10:34 -0400
Received: by mail-oi0-f51.google.com with SMTP id g131so62017547oic.3
        for <ceph-devel@vger.kernel.org>; Wed, 09 Aug 2017 07:10:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Jan Fajerski <jfajerski@suse.com>, Paul Cuzner <pcuzner@redhat.com>

Hi folks,

So after much poking around with rules etc, I think I've realised how
one is meant to do this kind of thing.

Prometheus queries have a powerful join-like capability, that can be
used for things like selecting instances running a particular version
of software, without putting the version as a label on everything you
want to filter:
https://www.robustperception.io/exposing-the-software-version-to-prometheus/

We can use that to establish a connection between disks and OSDs by
emitting special metrics like this:
ceph_disk_occupation{instance="mynode456", device="sdc",osd="123"}

Then someone writing a dashboard can get the metrics for the disk for
a known OSD ID with a query like this:
node_disk_bytes_written and on (device,instance) ceph_disk_occupation{osd="123"}

One can also conveniently a metric for all disks that are in use by
any Ceph OSD (but not all disks in the system), by leaving off the
osd=123 part.  I think we can also add rack= labels (or arbitrary
crush ancestry) to these nodes, so that a UI can query their
disk/network stats by crush hierarchy.

There is a constraint that we need the instance= labels to match up
between the metrics describing the OSD disk/nic usage, and the metrics
that come from node_exporter.  By default the instance labels are the
IP/host:port of an exporter, so one has to override them in the
prometheus config to be just the hostname.  That seems to be something
that some people do anyway to have cleaner instance labels in UIs.

I'm going to extend the ceph-mgr prometheus module to emit these
metrics -- to do the same trick for network cards as for disks, we
need the OSDs to tell us their interface names, so I have a PR for
doing that: https://github.com/ceph/ceph/pull/16941

Cheers,
John
