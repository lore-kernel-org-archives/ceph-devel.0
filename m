From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Stupid allocator assert during replay
Date: Wed, 14 Sep 2016 18:52:47 +0000
Message-ID: <BL2PR02MB2115C7BABE4EED4F6F8C8A18F4F10@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam01on0074.outbound.protection.outlook.com ([104.47.34.74]:15232
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932913AbcINSwu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Sep 2016 14:52:50 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
Regarding the replay assert I posted yesterday , it seems it is happening o=
nly with Stupid and *not* with bitmap allocator.


Thread 1 "ceph-osd" received signal SIGABRT, Aborted.
0x00007ffff47fd418 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/s=
ysv/linux/raise.c:54
54      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  0x00007ffff47fd418 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/un=
ix/sysv/linux/raise.c:54
#1  0x00007ffff47ff01a in __GI_abort () at abort.c:89
#2  0x0000555555fa114b in ceph::__ceph_assert_fail (assertion=3Dassertion@e=
ntry=3D0x5555562460ed "rm.empty()",
    file=3Dfile@entry=3D0x555556245fd8 "/root/ceph-master/src/os/bluestore/=
StupidAllocator.cc", line=3Dline@entry=3D305,
    func=3Dfunc@entry=3D0x5555562462c0 <StupidAllocator::init_rm_free(unsig=
ned long, unsigned long)::__PRETTY_FUNCTION__> "virtual void StupidAllocato=
r::init_rm_free(uint64_t, uint64_t)") at /root/ceph-master/src/common/asser=
t.cc:78
#3  0x0000555555df6d5c in StupidAllocator::init_rm_free (this=3D0x55555f06f=
7a0, offset=3D<optimized out>, length=3D<optimized out>)
    at /root/ceph-master/src/os/bluestore/StupidAllocator.cc:305
#4  0x0000555555dd33aa in BlueFS::mount (this=3D0x55555f266580) at /root/ce=
ph-master/src/os/bluestore/BlueFS.cc:366
#5  0x0000555555d017e5 in BlueStore::_open_db (this=3Dthis@entry=3D0x55555f=
162000, create=3Dcreate@entry=3Dfalse) at /root/ceph-master/src/os/bluestor=
e/BlueStore.cc:3008
#6  0x0000555555d1c02d in BlueStore::mount (this=3D0x55555f162000) at /root=
/ceph-master/src/os/bluestore/BlueStore.cc:3659
#7  0x0000555555924ef3 in OSD::init (this=3D0x55555f14a000) at /root/ceph-m=
aster/src/osd/OSD.cc:2025
#8  0x00005555558838ff in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>) at /root/ceph-master/src/ceph_osd.cc:609


Debugging further and printing some extra log , I found this..

    -9> 2016-09-14 14:33:41.581325 7fbfde2608c0 10 stupidalloc init_rm_free=
 45120225280~2097152
    -8> 2016-09-14 14:33:41.581326 7fbfde2608c0 20 stupidalloc init_rm_free=
 bin 9 rm [45120225280~2097152]
    -7> 2016-09-14 14:33:41.581327 7fbfde2608c0 30 stupidalloc init_rm_free=
 rm =3D []
    -6> 2016-09-14 14:33:41.581328 7fbfde2608c0 10 stupidalloc init_rm_free=
 45123371008~2097152
    -5> 2016-09-14 14:33:41.581329 7fbfde2608c0 20 stupidalloc init_rm_free=
 bin 9 rm [45123371008~2097152]
    -4> 2016-09-14 14:33:41.581330 7fbfde2608c0 30 stupidalloc init_rm_free=
 rm =3D []
    -3> 2016-09-14 14:33:41.581331 7fbfde2608c0 30 bluefs mount noting allo=
c for file(ino 0 size 0x1000 mtime 2016-09-14 14:16:10.853017 bdev 0 extent=
s [1:0x15500000+100000])
    -2> 2016-09-14 14:33:41.581332 7fbfde2608c0 10 stupidalloc init_rm_free=
 357564416~1048576
    -1> 2016-09-14 14:33:41.581333 7fbfde2608c0 30 stupidalloc init_rm_free=
 rm =3D [357564416~1048576]
     0> 2016-09-14 14:33:41.583530 7fbfde2608c0 -1 /root/ceph-master/src/os=
/bluestore/StupidAllocator.cc: In function 'virtual void StupidAllocator::i=
nit_rm_free(uint64_t, uint64_t)' thread 7fbfde2608c0 time 2016-09-14 14:33:=
41.581339
/root/ceph-master/src/os/bluestore/StupidAllocator.cc: 306: FAILED assert(r=
m.empty())


So, for inode 0 it is not entering in the following loop from where rm is f=
reed.

  for (unsigned i =3D 0; i < free.size() && !rm.empty(); ++i) {

So, it seems free.size is 0 at this point , not sure why though ?

I have full verbose log , let me know if you need that.

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
