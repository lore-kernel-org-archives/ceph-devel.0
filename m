From: Sage Weil <sage@newdream.net>
Subject: RE: rocksdb related build error
Date: Tue, 3 May 2016 15:03:53 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605031503210.26967@cpach.fuggernut.com>
References: <CAF1ivSbg-n6o2_mHzCS_Y9rDZTD+ySess8TqOto-ox7MV012bA@mail.gmail.com> <alpine.DEB.2.11.1605030824500.26967@cpach.fuggernut.com> <3F3468645DC82146857A5E1C91E23F4B1B2A0A73@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38838 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933896AbcECTDp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 15:03:45 -0400
In-Reply-To: <3F3468645DC82146857A5E1C91E23F4B1B2A0A73@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jianjian Huo-SSI <jianjian.huo@ssi.samsung.com>
Cc: Ming Lin <minggr@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, John Spray <john.spray@redhat.com>

On Tue, 3 May 2016, Jianjian Huo-SSI wrote:
> Hi Sage,
> 
> When we are going to pull in latest RocksDB release? We are still using code base from last year.
> RocksDB stops working with Bluestore after 6 hours writes, maybe it's related to old RocksDB code or recycled log files?
> http://tracker.ceph.com/issues/15600

Hmm, I was about to blame bluefs, but it looks you had it turned off.
I'll do a refresh.

sage


> 
> Jianjian
> 
> On Tue, May 3, 2016 at 5:26 AM, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 3 May 2016, Ming Lin wrote:
> >> Hi John,
> >>
> >> I got rocksdb related build error (commit bb7d9c15).
> >> Any hint to fix it?
> >>
> >> It's OK if I build in the ceph source tree.
> >
> > Out of tree builds don't work currently with autotools.
> >
> > sage
> >
> >
> >> mlin@ssi:~/ceph$ ./autogen.sh
> >> ...
> >>
> >> mlin@ssi:~/ceph-build$ ../ceph/configure
> >> ...
> >>
> >> mlin@ssi:~/ceph-build$ make -j8
> >> ...
> >> make[3]: Entering directory `/home/mlin/ceph-build/src'
> >> cd rocksdb && CC="gcc" CXX="g++" EXTRA_CXXFLAGS=-fPIC PORTABLE=1 make
> >> -j8 static_lib
> >> /bin/bash: line 0: cd: rocksdb: No such file or directory
> >> make[3]: *** [rocksdb/librocksdb.a] Error 1
> >> make[3]: *** Waiting for unfinished jobs....
> >> make[3]: Leaving directory `/home/mlin/ceph-build/src'
> >> make[2]: *** [all-recursive] Error 1
> >> make[2]: Leaving directory `/home/mlin/ceph-build/src'
> >> make[1]: *** [all] Error 2
> >> make[1]: Leaving directory `/home/mlin/ceph-build/src'
> >> make: *** [all-recursive] Error 1
> >>
> >>
> >> mlin@ssi:~/ceph-build$ ls src/
> >> acconfig.h  client      crush         java             kv
> >>  log       mount     os        rbd_fuse    test
> >> arch        cls         erasure-code  journal          librados
> >>  Makefile  msg       osd       rbd_replay  tools
> >> auth        common      global        json_spirit      libradosstriper
> >>  mds       objclass  osdc      rgw         tracing
> >> civetweb    compressor  gmock         key_value_store  librbd
> >>  mon       ocf       perfglue  stamp-h1    xxHash
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
