From: Sage Weil <sweil@redhat.com>
Subject: Re: RBD readahead strategies
Date: Thu, 11 Sep 2014 20:05:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409112000310.513@cobra.newdream.net>
References: <CAFu9Dv0A6wdHCFMP-9pwoPa=C2wWGcWJ2sN+TEayHz2dY3kdKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34351 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbaILDFk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 23:05:40 -0400
In-Reply-To: <CAFu9Dv0A6wdHCFMP-9pwoPa=C2wWGcWJ2sN+TEayHz2dY3kdKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Crume <adamcrume@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 10 Sep 2014, Adam Crume wrote:
> I've been testing a few strategies for RBD readahead and wanted to
> share my results as well as ask for input.
> 
> I have four sample workloads that I replayed at maximum speed with
> rbd-replay.  boot-ide and boot-virtio are captured from booting a VM
> with the image on the IDE and virtio buses, respectively.  Likewise,
> grep-ide and grep-virtio are captured from a large grep run.  (I'm not
> entirely sure why the IDE and virtio workloads are different, but part
> of it is the number of pending requests allowed.)
> 
> The readahead strategies are:
> - none: No readahead.
> - plain: My initial implementation.  The readahead window doubles for
> each readahead request, up to a limit, and resets when a random
> request is detected.
> - aligned: Same as above, but readahead requests are aligned with
> object boundaries, when possible.
> - eager: When activated, read to the end of the object.
> 
> For all of these, 10 sequential requests trigger readahead, the
> maximum readahead size is 4 MB, and "rbd readahead disable after
> bytes" is disabled (meaning that readahead is enabled for the entire
> workload).  The object size is the default 4 MB, and data is striped
> over a single object.  (Alignment with stripes or object sets is
> ignored for now.)
> 
> Here's the data:
> 
> workload      strategy   time (seconds)   RA ops   RA MB   read ops   read MB
> boot-ide      none       46.22 +/- 0.41        0       0      57516       407
> boot-ide      plain      11.42 +/- 0.25      281     203      57516       407
> boot-ide      aligned    11.46 +/- 0.13      276     201      57516       407
> boot-ide      eager      12.48 +/- 0.61      111     303      57516       407
> boot-virtio   none        9.05 +/- 0.25        0       0      11851       393
> boot-virtio   plain       8.05 +/- 0.38      451     221      11851       393
> boot-virtio   aligned     7.86 +/- 0.27      452     213      11851       393
> boot-virtio   eager       9.17 +/- 0.34      249     600      11851       393
> grep-ide      none      138.55 +/- 1.67        0       0     130104      3044
> grep-ide      plain     136.07 +/- 1.57      397     867     130104      3044
> grep-ide      aligned   137.30 +/- 1.77      379     844     130104      3044
> grep-ide      eager     138.77 +/- 1.52      346     993     130104      3044
> grep-virtio   none      120.73 +/- 1.33        0       0     130061      2820
> grep-virtio   plain     121.29 +/- 1.28     1186    1485     130061      2820
> grep-virtio   aligned   123.32 +/- 1.29     1139    1409     130061      2820
> grep-virtio   eager     127.75 +/- 1.32      842    2218     130061      2820
> 
> (The time is the mean wall-clock time +/- the margin of error with
> 99.7% confidence.  RA=readahead.)
> 
> Right off the bat, readahead is a huge improvement for the boot-ide
> workload, which is no surprise because it issues 50,000 sequential,
> single-sector reads.  (Why the early boot process is so inefficient is
> open for speculation, but that's a real, natural workload.)
> boot-virtio also sees an improvement, although not nearly so dramatic.
> The grep workloads show no statistically significant improvement.
> 
> One conclusion I draw is that 'eager' is, well, too eager.  'aligned'
> shows no statistically significant difference from 'plain', and
> 'plain' is no worse than 'none' (at statistically significant levels)
> and sometimes better.
> 
> Should the readahead strategy be configurable, or should we just stick
> with whichever seems the best one?  Is there anything big I'm missing?

Aligned seems like, even if it is no faster fromthe client's perspective, 
will result in fewer IOs on teh backend, right?  That makes me think we 
should go with that if we have to choose one.

Have you looked at what it might take to put the readahead logic in 
ObjectCacher somewhere, or in some other piece of shared code that would 
allow us to subsume the Client.cc readahead code as well?  Perhaps simply 
wrapping the readahead logic in a single class such that the calling code 
is super simple (just feeds in current offset and conditionally issues a 
readahead IO) would work as well.

sage
