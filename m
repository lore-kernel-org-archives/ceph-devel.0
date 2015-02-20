From: James Page <james.page@ubuntu.com>
Subject: Re: Memstore performance improvements v0.90 vs v0.87
Date: Fri, 20 Feb 2015 09:07:55 +0000
Message-ID: <54E6F96B.9080202@ubuntu.com>
References: <3649A15A2562B54294DE14BCE5AC79120AB30A5D@FMSMSX106.amr.corp.intel.com> <3649A15A2562B54294DE14BCE5AC79120AB30EEA@FMSMSX106.amr.corp.intel.com> <54B6F103.9000708@redhat.com> <3649A15A2562B54294DE14BCE5AC79120AB31012@FMSMSX106.amr.corp.intel.com> <54C7FD1C.40406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44180 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbbBTJID (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Feb 2015 04:08:03 -0500
In-Reply-To: <54C7FD1C.40406@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: mnelson@redhat.com, "Blinick, Stephen L" <stephen.l.blinick@intel.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Colin Ian King <colin.king@canonical.com>, Patricia Gaughen <patricia.gaughen@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi All

The Ubuntu Kernel team have spent the last few weeks investigating the
apparent performance disparity between RHEL 7 and Ubuntu 14.04; we've
focussed efforts in a few ways (see below).

All testing has been done using the latest Firefly release.

1) Base network latency

Jay Vosburgh looked at the base network latencies between RHEL 7 and
Ubuntu 14.04; under default install, RHEL actually had slightly worse
latency than Ubuntu due to the default enablement of a firewall;
disabling this brought latency back inline between the two distribution=
s:

OS                      rtt min/avg/max/mdev
Ubuntu 14.04 (3.13)     0.013/0.016/0.018/0.005 ms
RHEL7 (3.10)            0.010/0.018/0.025/0.005 ms

=2E..base network latency is pretty much the same.

This testing was performed on a matched pair of Dell Poweredge R610's,
configured with a single 4 core CPU and 8G of RAM.

2) Latency and performance in Ceph using Rados bench

Colin King spent a number of days testing and analysing results using
rados bench against a single node ceph deployment, configured with a
single memory backed OSD, to see if we could reproduce the disparities
reported.

He ran 120 second OSD benchmarks on RHEL 7 as well as Ubuntu 14.04 LTS
with a selection of kernels including 3.10 vanilla, 3.13.0-44 (release
kernel), 3.16.0-30 (utopic HWE kernel), 3.18.0-12 (vivid HWE kernel)
and 3.19-rc6 with 1, 16 and 128 client threads.  The data collected is
available at [0].

Each round of tests consisted of 15 runs, from which we computed
average latency, latency deviation and latency distribution:

> 120 second x 1 thread

Results all seem to cluster around 0.04->0.05ms, with RHEL 7 averaging
at 0.044 and recent Ubuntu kernels at 0.036-0.037ms.  The older 3.10
kernel in RHEL 7 does have some slightly higher average latency.

> 120 second x 16 threads

Results all seem to cluster around 0.6-0.7ms.  3.19.0-rc6 had a couple
of 1.4ms outliers which pushed it out to be worse than RHEL 7. On the
whole Ubuntu 3.10-3.18 kernels are better than RHEL 7 by ~0.1ms.  RHEL
shows a far higher standard deviation, due to the bimodal latency
distribution, which from the casual observer may appear to be more
"jittery".

> 120 second x 128 threads

Later kernels show up to have less standard deviation than RHEL 7, so
that shows perhaps less jitter in the stats than RHEL 7's 3.10 kernel.
With this many threads pounding the test, we get a wider spread of
latencies and it is hard to tell any kind of latency distribution
patterns with just 15 rounds because of the large amount of latency
jitter.  All systems show a latency of ~ 5ms.  Taking into
consideration the amount of jitter, we think these results do not make
much sense unless we repeat these tests with say 100 samples.

3) Conclusion

We=92ve have not been able to show any major anomalies in Ceph on Ubunt=
u
compared to RHEL 7 when using memstore.  Our current hypothesis is that
one needs to run the OSD bench stressor many times to get a fair captur=
e
of system latency stats.  The reason for this is:

* Latencies are very low with memstore, so any small jitter in
scheduling etc will show up as a large distortion (as shown by the larg=
e
standard deviations in the samples).

* When memstore is heavily utilized, memory pressure causes the system
to page heavily and so we are subject to the nature of perhaps delays o=
n
paging that cause some latency jitters.  Latency differences may be jus=
t
down to where a random page is in memory or in swap, and with memstore
these may cause the large perturbations we see when running just a
single test.

* We needed to make *many* tens of measurements to get a typical idea o=
f
average latency and the latency distributions. Don't trust the results
from just one test

* We ran the tests with a pool configured to 100 pgs and 100 pgps [1].
One can get different results with different placement group configs.

I've CC'ed both Colin and Jay on this mail - so if anyone has any
specific questions about the testing they can chime in with responses.

Regards

James

[0] http://kernel.ubuntu.com/~cking/.ceph/ceph-benchmarks.ods
[1] http://ceph.com/docs/master/rados/configuration/pool-pg-config-ref/

- --=20
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJU5vlrAAoJEL/srsug59jDMvAQAIhSR4GFTXNc4RLpHtLT6h/X
K5uyauKZGtL+wqtPKRfsXqbbUw9I5AZDifQuOEJ0APccLIPbgqxEN3d2uht/qygH
G8q2Ax+M8OyZz07yqTitnD4JV3RmL8wNHUveWPLV0gs2TzBBYwP1ywExbRPed3PY
cfDrszgkQszA/JwT5W5YNf1LZc+5VpOEFrTiLIaRzUDoxg7mm6Hwr3XT8OFjZhjm
LSenKREHtrKKWoBh+OKTvuCUnHzEemK+CiwwRbNQ8l7xbp71wLyS08NpSB5C1y70
7uft+kP6XOGE9AKLvsdEL1PIXHfeKNonBEN5mO6nsXIW+MQzou01zHgDtne7AxDA
5OebQJfJtArmKt78WHuVg7h8gPcIRTRSW43LqJiADnIHL8fnZxj2v5yDiUQj7isw
nYWXEJ3rR7mlVgydN34KQ7gpVWmGjhrVb8N01+zYOMAaTBnekldHdueEAXR07eU0
PXiP9aOZiAxbEnDiJmreehjCuNFTagQqNeECRIHssSacfQXPxVljaImvuSfrxf8i
myQLzftiObINTIHSN4TVDKMyveYrU2hILCKfYuxnSJh29j35wsRSeftjntOEyHai
RDnrLD3fCPk4h3hCY6l60nqu9MQfbgdSB/FItvhiBGYqXvGb4+wuBeU9RT9SwG8N
XPih7nLNvqDNw38IkkDN
=3DqcvG
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
