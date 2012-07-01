From: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Subject: Ceph status for Wheezy
Date: Sun, 01 Jul 2012 05:56:50 +0000
Message-ID: <1341122210.10000.46.camel@julia>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:59954 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2GAF5A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Jul 2012 01:57:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

As previously noted, using leveldb caused some trouble with Ceph could
be included in Wheezy or not.
I've proposed that the supported architectures should be limited in Ceph
and leveldb to the ones the latter supports. I got a release critical
bugreport[1] that it should be reversed. Alessio Treglia, the leveldb
maintainer in Debian wrote the following:
"I'm going to test leveldb on powerpc and then I'll report my results
to upstream.
Hence I cannot promise it will be ready in time for Wheezy, of course
I'll upload a patch as soon as a fix becomes available.".

Upstream was asked[2], noted that it fails on big-endian architectures,
but no answer until now.

Then, as it was previously announced, the freeze of Wheezy started some
hours ago[3].

Soon, after that Julien Cristau, one of our Release Assistant noted
about Ceph doesn't build on all architectures due to leveldb:
"Unless this gets fixed we'll have to remove ceph from wheezy.  Which
means qemu and qemu-kvm need to drop their build-deps on ceph packages.
They can always be re-added if/when leveldb/ceph are fixed.".

It seems everything is up to leveldb upstream/maintainer now. It is
fixed in time on big-endian machines or the package will be limited to
little-endian machines as I wanted to do with Ceph.

But please look into the reason why Ceph fails to build on ia64[4].
Also, how 0.48 goes? Will it contain big differences to 0.47.2? As you
can read, even 0.47.2 is in question for Wheezy. But would you propose
0.48 for inclusion when it's released?

Fingers crossed. Regards,
Laszlo/GCS
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=677626
[2] http://code.google.com/p/leveldb/issues/detail?id=84
[3] https://lists.debian.org/debian-devel-announce/2012/06/msg00009.html
[4] https://buildd.debian.org/status/fetch.php?pkg=ceph&arch=ia64&ver=0.47.2-1&stamp=1340802492

