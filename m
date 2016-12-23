From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Bluestore performance bottleneck
Date: Fri, 23 Dec 2016 19:33:15 +0000
Message-ID: <EB02EE10422E4A40A1EE787A4AC27FBE0467BA@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
References: <5E3E05AED7F0F044904275810D0CB46504C290@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.11.1612220018390.10615@piezo.novalocal>
 <5E3E05AED7F0F044904275810D0CB46504C301@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <5E3E05AED7F0F044904275810D0CB46504C315@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.11.1612220129050.10615@piezo.novalocal>
 <5E3E05AED7F0F044904275810D0CB46504C355@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <62d79c2e-bf7b-9c09-883d-615fedf152b8@redhat.com>
 <alpine.DEB.2.11.1612222226210.10615@piezo.novalocal>
 <aa787f6c-1b0c-fefe-5f82-b749fd0a4ae3@redhat.com>
 <64caf3cd-5717-dfe1-214f-eb391bb72071@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0061.outbound.protection.outlook.com ([104.47.32.61]:36032
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936667AbcLWTdX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 23 Dec 2016 14:33:23 -0500
In-Reply-To: <64caf3cd-5717-dfe1-214f-eb391bb72071@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

The two data points you mention (4K / 16K MinAlloc) yield interesting numbe=
rs. For 4K, you're seeing 22.5K IOPS at 1300% CPU or 1.7K IOPS / core. Yet =
for 16K you're seeing 25K IOPS at 1000% CPU or 2.5 K IOPS/Core.  Yet, we kn=
ow that in the main I/O path that the 16K is doing more work (since it's do=
uble-writing the data), but is yielding better CPU usage overall. We do kno=
w that there will be a reduction of compaction for the 16K case which will =
save SOME CPU, but I wouldn't have thought that this would be substantial s=
ince the data is all processed sequentially in rather large blocks (i.e., t=
he CPU cost of compaction seems to be larger than expected).=20

Do we know that you're actually capturing a few compaction cycles with the =
16K test? If not, that might explain some of the difference.


Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Friday, December 23, 2016 9:09 AM
> To: Sage Weil <sweil@redhat.com>
> Cc: Somnath Roy <Somnath.Roy@sandisk.com>; ceph-devel <ceph-
> devel@vger.kernel.org>
> Subject: Re: Bluestore performance bottleneck
>=20
> >> Try this?
> >>     https://github.com/ceph/ceph/pull/12634
> >
> > Looks like this is most likely reducing the memory usage and
> > increasing performance quite a bit with smaller shard target/max
> > values.  With
> > 25/50 I'm seeing more like 2.6GB RSS memory usage and around 13K iops
> > typically with some (likely rocksdb) stalls.  I'll run through the
> > tests again.
> >
> > Mark
> >
>=20
> Ok, Ran through tests with both 4k and 16k min_alloc/max_alloc/blob sizes
> using master+12629+12634:
>=20
> https://drive.google.com/uc?export=3Ddownload&id=3D0B2gTBZrkrnpZQzdRU3B
> 1SGZUbDQ
>=20
> Performance is up in all tests and memory consumption is down (especially=
 in
> the smaller target/max tests).  It looks like 100/200 is probably the cur=
rent
> optimal configuration on my test setup.  4K min_alloc tests hover around
> 22.5K IOPS with ~1300% CPU usage, and 16K min_alloc tests hover around
> 25K IOPs with ~1000% CPU usage.  I think it will be worth spending some t=
ime
> looking at locking in the bitmap allocator given the perf traces.  Beyond=
 that,
> I'm seeing rocksdb show up quite a bit in the top CPU consuming functions
> now, especially CRC32.
>=20
> Mark
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
