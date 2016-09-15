From: Sage Weil <sweil@redhat.com>
Subject: RE: wip-denc
Date: Thu, 15 Sep 2016 00:39:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609150038380.19761@piezo.us.to>
References: <alpine.DEB.2.11.1609132104590.19761@piezo.us.to> <a89da24e-7791-ef4a-acce-9f653eaac08e@redhat.com> <BL2PR02MB2115A35131A2704721503480F4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756504AbcIOAkO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 20:40:14 -0400
In-Reply-To: <BL2PR02MB2115A35131A2704721503480F4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 14 Sep 2016, Somnath Roy wrote:
> Another point, probably, not related to leak fix, but, in the latest master (+ your 1st 5 commits) I am hitting the following assert after OSD restart. If I run IO for some time..
> 
> Thread 1 "ceph-osd" received signal SIGABRT, Aborted.
> 0x00007ffff47fd418 in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:54
> 54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff47fd418 in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:54
> #1  0x00007ffff47ff01a in __GI_abort () at abort.c:89
> #2  0x0000555555fa114b in ceph::__ceph_assert_fail (assertion=assertion@entry=0x5555562460ed "rm.empty()",
>     file=file@entry=0x555556245fd8 "/root/ceph-master/src/os/bluestore/StupidAllocator.cc", line=line@entry=305,
>     func=func@entry=0x5555562462c0 <StupidAllocator::init_rm_free(unsigned long, unsigned long)::__PRETTY_FUNCTION__> "virtual void StupidAllocator::init_rm_free(uint64_t, uint64_t)") at /root/ceph-master/src/common/assert.cc:78
> #3  0x0000555555df6d5c in StupidAllocator::init_rm_free (this=0x55555f06f7a0, offset=<optimized out>, length=<optimized out>)
>     at /root/ceph-master/src/os/bluestore/StupidAllocator.cc:305
> #4  0x0000555555dd33aa in BlueFS::mount (this=0x55555f266580) at /root/ceph-master/src/os/bluestore/BlueFS.cc:366
> #5  0x0000555555d017e5 in BlueStore::_open_db (this=this@entry=0x55555f162000, create=create@entry=false) at /root/ceph-master/src/os/bluestore/BlueStore.cc:3008
> #6  0x0000555555d1c02d in BlueStore::mount (this=0x55555f162000) at /root/ceph-master/src/os/bluestore/BlueStore.cc:3659
> #7  0x0000555555924ef3 in OSD::init (this=0x55555f14a000) at /root/ceph-master/src/osd/OSD.cc:2025
> #8  0x00005555558838ff in main (argc=<optimized out>, argv=<optimized out>) at /root/ceph-master/src/ceph_osd.cc:609

I hit this one this afternoon. Fix is included in

	https://github.com/ceph/ceph/pull/11087

sage
