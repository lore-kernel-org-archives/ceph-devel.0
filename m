From: Kostis Fardelas <dante1234@gmail.com>
Subject: Re: Jewel + kernel 4.4 Massive performance regression (-50%)
Date: Thu, 16 Feb 2017 17:51:18 +0200
Message-ID: <CAN3wisVj7BAjJtDd4mEa4XOOcViz-qs5j71na2e=2c3SCO_HeA@mail.gmail.com>
References: <14aea50c-f708-1d99-8d61-c79bec2029e0@epfl.ch> <CAFonxSwyGOC9OGjEwBOmewhvtH_vBRKxT4eyoTkdFAxJmg6jZw@mail.gmail.com>
 <29443c6d-1a13-477a-6844-6f1b31e86d2d@epfl.ch> <CAFonxSzvPTpPsxLvcWame4vLwnJMcbxqsYHXXuO3--Dibt2t-Q@mail.gmail.com>
 <48d7fe00-88cd-4187-e56b-aea73ce6aaf1@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36835 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932423AbdBPPvV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 10:51:21 -0500
Received: by mail-wr0-f169.google.com with SMTP id 89so9993388wrr.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 07:51:20 -0800 (PST)
In-Reply-To: <48d7fe00-88cd-4187-e56b-aea73ce6aaf1@epfl.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yoann Moulin <yoann.moulin@epfl.ch>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hello,
we are on Debian Jessie and Hammer 0.94.9 and recently we decided to
upgrade our kernel from 3.16 to 4.9 (jessie-backports). We experience
the same regression but with some shiny points
-- ceph tell osd average across the cluster --
3.16.39-1: 204MB/s
4.9.0-0    : 158MB/s

-- 1 rados bench client 4K 2048 threads avg IOPS --
3.16.39-1: 1604
4.9.0-0    : 451

-- 1 rados bench client 64K 512 threads avg BW MB/s--
3.16.39-1: 78
4.9.0-0    : 31

The shiny points are on the following tests:
1 rados bench client 4K 512 threads avg IOPS
1 rados bench client 64K 2048 threads avg BW MB/s

where machines with kernel 4.9 seem to perform slightly better. The
overall impression though is that there is a serious regression or
something that should be tuned to get the same performance out of the
cluster.

Our demo cluster is 4 nodes X 12 OSDs, separate journal on SSD,
firefly tunables and everything else default considering our Ceph
installation and Debian OS. Each rados bench run 5 times to get an
average and caches were dropped before each test.

I wonder if anyone has discovered the culprit so far? Any hints from
others to focus our investigation on?

Best regards,
Kostis

On 19 December 2016 at 17:17, Yoann Moulin <yoann.moulin@epfl.ch> wrote:
> Hello,
>
> Finally, I found time to do some new benchmarks with the latest jewel rel=
ease (10.2.5) on 4 nodes. Each node has 10 OSDs.
>
> I ran 2 times "ceph tell osd.* bench" over 40 OSDs, here the average spee=
d :
>
> 4.2.0-42-generic      97.45 MB/s
> 4.4.0-53-generic      55.73 MB/s
> 4.8.15-040815-generic 62.41 MB/s
> 4.9.0-040900-generic  60.88 MB/s
>
> I have the same behaviour with at least 35 to 40% performance drop betwee=
n kernel 4.2 and kernel > 4.4
>
> I can do further benches if needed.
>
> Yoann
>
> Le 26/07/2016 =C3=A0 09:09, Lomayani S. Laizer a =C3=A9crit :
>> Hello,
>> do you have journal on disk too ?
>>
>> Yes am having journal on same hard disk.
>>
>> ok and could you do bench with kernel 4.2 ? just to see if you have bett=
er
>> throughput. Thanks
>>
>> In ubuntu 14 I was running 4.2 kernel. the throughput was the same aroun=
d 80-90MB/s per osd. I cant tell the difference because each test gives
>> the speeds on same range. I did not test kernel 4.4 in ubuntu 14
>>
>>
>> --
>> Lomayani
>>
>> On Tue, Jul 26, 2016 at 9:39 AM, Yoann Moulin <yoann.moulin@epfl.ch <mai=
lto:yoann.moulin@epfl.ch>> wrote:
>>
>>     Hello,
>>
>>     > Am running ubuntu 16 with kernel 4.4-0.31-generic and my speed are=
 similar.
>>
>>     do you have journal on disk too ?
>>
>>     > I did tests on ubuntu 14 and Ubuntu 16 and the speed is similar. I=
 have around
>>     > 80-90MB/s of OSD speeds in both operating systems
>>
>>     ok and could you do bench with kernel 4.2 ? just to see if you have =
better
>>     throughput. Thanks
>>
>>     > Only issue am observing now with ubuntu 16 is sometime osd fails o=
n rebooting
>>     > until i start them manually or adding starting commands in rc.loca=
l.
>>
>>     in my case, it's a test environment, so I don't have notice those be=
haviours
>>
>>     --
>>     Yoann
>>
>>     > On Mon, Jul 25, 2016 at 6:45 PM, Yoann Moulin <yoann.moulin@epfl.c=
h <mailto:yoann.moulin@epfl.ch>
>>     > <mailto:yoann.moulin@epfl.ch <mailto:yoann.moulin@epfl.ch>>> wrote=
:
>>     >
>>     >     Hello,
>>     >
>>     >     (this is a repost, my previous message seems to be slipping un=
der the radar)
>>     >
>>     >     Does anyone get a similar behaviour to the one described below=
 ?
>>     >
>>     >     I found a big performance drop between kernel 3.13.0-88 (defau=
lt kernel on
>>     >     Ubuntu Trusty 14.04) or kernel 4.2.0 and kernel 4.4.0.24.14 (d=
efault kernel on
>>     >     Ubuntu Xenial 16.04)
>>     >
>>     >     - ceph version is Jewel (10.2.2).
>>     >     - All tests have been done under Ubuntu 14.04 on
>>     >     - Each cluster has 5 nodes strictly identical.
>>     >     - Each node has 10 OSDs.
>>     >     - Journals are on the disk.
>>     >
>>     >     Kernel 4.4 has a drop of more than 50% compared to 4.2
>>     >     Kernel 4.4 has a drop of 40% compared to 3.13
>>     >
>>     >     details below :
>>     >
>>     >     With the 3 kernel I have the same performance on disks :
>>     >
>>     >     Raw benchmark:
>>     >     dd if=3D/dev/zero of=3D/dev/sdX bs=3D1M count=3D1024 oflag=3Dd=
irect    =3D> average ~230MB/s
>>     >     dd if=3D/dev/zero of=3D/dev/sdX bs=3D1G count=3D1 oflag=3Ddire=
ct       =3D> average ~220MB/s
>>     >
>>     >     Filesystem mounted benchmark:
>>     >     dd if=3D/dev/zero of=3D/sdX1/test.img bs=3D1G count=3D1       =
       =3D> average ~205MB/s
>>     >     dd if=3D/dev/zero of=3D/sdX1/test.img bs=3D1G count=3D1 oflag=
=3Ddirect =3D> average ~214MB/s
>>     >     dd if=3D/dev/zero of=3D/sdX1/test.img bs=3D1G count=3D1 oflag=
=3Dsync   =3D> average ~190MB/s
>>     >
>>     >     Ceph osd Benchmark:
>>     >     Kernel 3.13.0-88-generic : ceph tell osd.ID bench =3D> average=
  ~81MB/s
>>     >     Kernel 4.2.0-38-generic  : ceph tell osd.ID bench =3D> average=
 ~109MB/s
>>     >     Kernel 4.4.0-24-generic  : ceph tell osd.ID bench =3D> average=
  ~50MB/s
>>     >
>>     >     I did new benchmarks then on 3 new fresh clusters.
>>     >
>>     >     - Each cluster has 3 nodes strictly identical.
>>     >     - Each node has 10 OSDs.
>>     >     - Journals are on the disk.
>>     >
>>     >     bench5 : Ubuntu 14.04 / Ceph Infernalis
>>     >     bench6 : Ubuntu 14.04 / Ceph Jewel
>>     >     bench7 : Ubuntu 16.04 / Ceph jewel
>>     >
>>     >     this is the average of 2 runs of "ceph tell osd.* bench" on ea=
ch cluster (2 x 30
>>     >     OSDs)
>>     >
>>     >     bench5 / 14.04 / Infernalis / kernel 3.13 :  54.35 MB/s
>>     >     bench6 / 14.04 / Jewel      / kernel 3.13 :  86.47 MB/s
>>     >
>>     >     bench5 / 14.04 / Infernalis / kernel 4.2  :  63.38 MB/s
>>     >     bench6 / 14.04 / Jewel      / kernel 4.2  : 107.75 MB/s
>>     >     bench7 / 16.04 / Jewel      / kernel 4.2  : 101.54 MB/s
>>     >
>>     >     bench5 / 14.04 / Infernalis / kernel 4.4  :  53.61 MB/s
>>     >     bench6 / 14.04 / Jewel      / kernel 4.4  :  65.82 MB/s
>>     >     bench7 / 16.04 / Jewel      / kernel 4.4  :  61.57 MB/s
>>     >
>>     >     If needed, I have the raw output of "ceph tell osd.* bench"
>>     >
>>     >     Best regards
>>
>>
>
>
> --
> Yoann Moulin
> EPFL IC-IT
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
