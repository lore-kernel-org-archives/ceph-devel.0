From: Adam Crume <adamcrume@gmail.com>
Subject: RBD readahead strategies
Date: Wed, 10 Sep 2014 15:36:08 -0700
Message-ID: <CAFu9Dv0A6wdHCFMP-9pwoPa=C2wWGcWJ2sN+TEayHz2dY3kdKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:42987 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbaIJWgJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 18:36:09 -0400
Received: by mail-ob0-f182.google.com with SMTP id m8so814737obr.27
        for <ceph-devel@vger.kernel.org>; Wed, 10 Sep 2014 15:36:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've been testing a few strategies for RBD readahead and wanted to
share my results as well as ask for input.

I have four sample workloads that I replayed at maximum speed with
rbd-replay.  boot-ide and boot-virtio are captured from booting a VM
with the image on the IDE and virtio buses, respectively.  Likewise,
grep-ide and grep-virtio are captured from a large grep run.  (I'm not
entirely sure why the IDE and virtio workloads are different, but part
of it is the number of pending requests allowed.)

The readahead strategies are:
- none: No readahead.
- plain: My initial implementation.  The readahead window doubles for
each readahead request, up to a limit, and resets when a random
request is detected.
- aligned: Same as above, but readahead requests are aligned with
object boundaries, when possible.
- eager: When activated, read to the end of the object.

For all of these, 10 sequential requests trigger readahead, the
maximum readahead size is 4 MB, and "rbd readahead disable after
bytes" is disabled (meaning that readahead is enabled for the entire
workload).  The object size is the default 4 MB, and data is striped
over a single object.  (Alignment with stripes or object sets is
ignored for now.)

Here's the data:

workload      strategy   time (seconds)   RA ops   RA MB   read ops   read MB
boot-ide      none       46.22 +/- 0.41        0       0      57516       407
boot-ide      plain      11.42 +/- 0.25      281     203      57516       407
boot-ide      aligned    11.46 +/- 0.13      276     201      57516       407
boot-ide      eager      12.48 +/- 0.61      111     303      57516       407
boot-virtio   none        9.05 +/- 0.25        0       0      11851       393
boot-virtio   plain       8.05 +/- 0.38      451     221      11851       393
boot-virtio   aligned     7.86 +/- 0.27      452     213      11851       393
boot-virtio   eager       9.17 +/- 0.34      249     600      11851       393
grep-ide      none      138.55 +/- 1.67        0       0     130104      3044
grep-ide      plain     136.07 +/- 1.57      397     867     130104      3044
grep-ide      aligned   137.30 +/- 1.77      379     844     130104      3044
grep-ide      eager     138.77 +/- 1.52      346     993     130104      3044
grep-virtio   none      120.73 +/- 1.33        0       0     130061      2820
grep-virtio   plain     121.29 +/- 1.28     1186    1485     130061      2820
grep-virtio   aligned   123.32 +/- 1.29     1139    1409     130061      2820
grep-virtio   eager     127.75 +/- 1.32      842    2218     130061      2820

(The time is the mean wall-clock time +/- the margin of error with
99.7% confidence.  RA=readahead.)

Right off the bat, readahead is a huge improvement for the boot-ide
workload, which is no surprise because it issues 50,000 sequential,
single-sector reads.  (Why the early boot process is so inefficient is
open for speculation, but that's a real, natural workload.)
boot-virtio also sees an improvement, although not nearly so dramatic.
The grep workloads show no statistically significant improvement.

One conclusion I draw is that 'eager' is, well, too eager.  'aligned'
shows no statistically significant difference from 'plain', and
'plain' is no worse than 'none' (at statistically significant levels)
and sometimes better.

Should the readahead strategy be configurable, or should we just stick
with whichever seems the best one?  Is there anything big I'm missing?

Adam
