From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: ceph mkfs failed
Date: Fri, 8 Feb 2013 11:53:55 -0600
Message-ID: <CAB7xdikofu0xVBk1C6sAVtqePyAuaQ4yhp2EmmMYbTwXy9H-aA@mail.gmail.com>
References: <CAB7xdi=5q-e7FEXjrf524as4FPW-pM4z9wDrCm7boPVTr7sVLg@mail.gmail.com>
	<51140CFF.8000207@inktank.com>
	<CAB7xdimctzpk8qeRLJqxxeNRJEFpc2EpVHd37qj0E-OCeBP13A@mail.gmail.com>
	<CAPYLRzjeNZn+aYwtcij0YddYX=Fpd=xY5+QrveaNNMXCL4bLUw@mail.gmail.com>
	<CAB7xdin+Ow_KE1EgNSK6PG4EDSKgO=DSjFJBpBVKjL-Rd5wehA@mail.gmail.com>
	<511428FA.3040209@inktank.com>
	<CAB7xdikEyH0_4TsFiabRmQXRkTs=vtJe1njtc4QpWq1sMANAHQ@mail.gmail.com>
	<CAB7xdi=tnmU3jWVfmLjxSFa_kdNrPbcd=3uePUaJ0k-S5gyMfQ@mail.gmail.com>
	<alpine.DEB.2.00.1302080902030.18035@cobra.newdream.net>
	<CAB7xdinp4=R6AXnoGwxLP+O9=_fSbhNgJQCN8b+ywn=pFk7Eow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54834 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946833Ab3BHRx6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 12:53:58 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so5383666iea.33
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 09:53:56 -0800 (PST)
In-Reply-To: <CAB7xdinp4=R6AXnoGwxLP+O9=_fSbhNgJQCN8b+ywn=pFk7Eow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

i think it's not related with my local FS. i build a ext4 on a ramdisk
and used it as OSD.
when i run the iozone or fio on the mounted client point, it  shows
the same info as before:

2013-02-08 11:45:06.803915 7f28ec7c4700  0 -- 165.91.215.237:6801/7101
>> 165.91.215.237:0/1990103183 pipe(0x2ded240 sd=803 :6801 pgs=0 cs=0
l=0).accept peer addr is really 165.91.215.237:0/1990103183 (socket is
165.91.215.237:60553/0)
2013-02-08 11:45:06.879009 7f28f7add700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f28f7add700

the ceph -s shows, also the same as using my own local FS:

  health HEALTH_WARN 384 pgs degraded; 384 pgs stuck unclean; recovery
21/42 degraded (50.000%)
   monmap e1: 1 mons at {0=165.91.215.237:6789/0}, election epoch 2, quorum 0 0
   osdmap e3: 1 osds: 1 up, 1 in
    pgmap v7: 384 pgs: 384 active+degraded; 21003 bytes data, 276 MB
used, 3484 MB / 3961 MB avail; 21/42 degraded (50.000%)
   mdsmap e4: 1/1/1 up {0=0=up:active}

dmesg shows:

[  656.799209] libceph: client4099 fsid da0fe76d-8506-4bf8-8b49-172fd8bc6d1f
[  656.800657] libceph: mon0 165.91.215.237:6789 session established
[  683.789954] libceph: osd0 165.91.215.237:6801 socket closed (con state OPEN)
[  683.790007] libceph: osd0 165.91.215.237:6801 socket error on write
[  684.909095] libceph: osd0 165.91.215.237:6801 socket error on write
[  685.903425] libceph: osd0 165.91.215.237:6801 socket error on write
[  687.903937] libceph: osd0 165.91.215.237:6801 socket error on write
[  691.897037] libceph: osd0 165.91.215.237:6801 socket error on write
[  699.899197] libceph: osd0 165.91.215.237:6801 socket error on write
[  715.903415] libceph: osd0 165.91.215.237:6801 socket error on write
[  747.912122] libceph: osd0 165.91.215.237:6801 socket error on write
[  811.929323] libceph: osd0 165.91.215.237:6801 socket error on write

Thanks,
Sheng


On Fri, Feb 8, 2013 at 11:07 AM, sheng qiu <herbert1984106@gmail.com> wrote:
> Hi Sage,
>
> it's a memory based fs similar to pramfs.
>
> Thanks,
> Sheng
>
> On Fri, Feb 8, 2013 at 11:02 AM, Sage Weil <sage@inktank.com> wrote:
>> Hi Sheng-
>>
>> On Fri, 8 Feb 2013, sheng qiu wrote:
>>> least pass through the init-ceph script). i made a minor change on
>>> ceph code, i changed the link_object() in LFNIndex.cc, basically i
>>> changed the hard link call ::link() to symlink(), as my local fs does
>>> not support hard link (the directory entry stores together with the
>>> related inodes).
>>
>> Unrelated question: which local fs are you using?
>>
>> sage
>
>
>
> --
> Sheng Qiu
> Texas A & M University
> Room 332B Wisenbaker
> email: herbert1984106@gmail.com
> College Station, TX 77843-3259



-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
