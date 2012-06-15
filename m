From: Stefan Majer <stefan.majer@gmail.com>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Fri, 15 Jun 2012 14:14:29 +0200
Message-ID: <CADdPHGu0s=rjqRZiFn4K8+fVFc4JG0bOpd3r-HStk1S3nM69BQ@mail.gmail.com>
References: <21601270.dfB0BsVfyn@pc10>
	<25761303.PmWYZprmzc@pc10>
	<Pine.LNX.4.64.1206110920150.10557@cobra.newdream.net>
	<1815615.qFFlAnfNF8@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50005 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706Ab2FOMOa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 08:14:30 -0400
Received: by yenl2 with SMTP id l2so1776019yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 05:14:29 -0700 (PDT)
In-Reply-To: <1815615.qFFlAnfNF8@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: Sage Weil <sage@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

Hi,

We had today a catastrophic fs corruption in one of our virtual
machines, after fsck ~100MB was inside lost+found :-(
So is think we hit the same bug (ceph-0.45.2, sparse rbd images)

Is there any progress on this topic, or any hint how to help on this
would be helpful.

Greetings
Stefan Majer

On Tue, Jun 12, 2012 at 2:31 PM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Am Montag, 11. Juni 2012, 09:30:42 schrieb Sage Weil:
>> If you can reproduce it with 'debug filestore =3D 20' too, that will=
 be
>> better, as it will tell us what the FIEMAP ioctl is returning.
>
> I ran another testrun with 'debug filestore =3D 20'.
>
>> Also, if
>> you can attach/post the contents of the object itself (rados -p rbd =
get
>> rb.0.1.0000000002a0 /tmp/foo) we can make sure the object has the ri=
ght
>> data (and the sparse-read operation that librbd is doing is the culp=
rit).
>
> I tried that, with the block name that the steps further below gave m=
e:
>
> rados -p rbd get rb.0.13.00000000045a block
>
> When I looked into the block, it looked like a bunch of temp files fr=
om the
> portage system with padding in between, although it should be random =
data... I
> think I got the wrong block after all...
>
> Here's what I did:
> Run the iotester again:
> testserver-rbd11 iotester # date ; ./iotester /var/iotest ; date
> Tue Jun 12 13:51:58 CEST 2012
> Wrote 100 MiB of data in 2004 milliseconds
> [snip lots of irrelevant lines]
> Wrote 100 MiB of data in 2537 milliseconds
> Read 100 MiB of data in 3794 milliseconds
> Read 100 MiB of data in 10150 milliseconds
> Digest wrong for file "/var/iotest/4299a48eca63c75d6773bec3565190aa3b=
33c46e"
> Tue Jun 12 13:55:00 CEST 2012
>
> Run the fiemap tool on that file:
>
> testserver-rbd11 ~ # ./fiemap
> /var/iotest/4299a48eca63c75d6773bec3565190aa3b33c46e
> File /var/iotest/4299a48eca63c75d6773bec3565190aa3b33c46e has 1 exten=
ts:
> # =A0 =A0 =A0 Logical =A0 =A0 =A0 =A0 =A0Physical =A0 =A0 =A0 =A0 Len=
gth =A0 =A0 =A0 =A0 =A0 Flags
> 0: =A0 =A0 =A00000000000000000 0000000116900000 0000000000100000 0001
>
>> As for the log:
>>
>> First, map the offset to an rbd block. =A0For example, taking the 'P=
hysical'
>> value of 00000000a8200000 from above:
>>
>> $ printf "%012x\n" $((0x00000000a8200000 / (4096*1024) ))
>> 0000000002a0
>
> That gave me
>
> =A0$ printf "%012x\n" $((0x0000000116900000 / (4096*1024) ))
> 00000000045a
>
>> Then figure out what the object name prefix is:
>>
>> $ rbd info <imagename> | grep prefix
>> =A0 =A0 =A0 =A0 block_name_prefix: rb.0.1
>
> Result: block_name_prefix: rb.0.13
>
>> Then add the block number, 0000000002a0 to that, e.g. rb.0.1.0000000=
002a0.
>
> Result: rb.0.13.00000000045a
>
>> Then map that back to an osd with
>>
>> $ ceph osd map rbd rb.0.1.0000000002a0
>> osdmap e19 pool 'rbd' (2) object 'rb.0.1.0000000002a0' -> pg 2.a2e06=
f65
>> (2.5) -> up [0,2] acting [0,2]
>
> That gives me
> [root@storage1 ~]# ceph osd map rbd rb.0.13.00000000045a 2> /dev/null
> osdmap e101 pool 'rbd' (2) object 'rb.0.13.00000000045a' -> pg 2.80b0=
39fb
> (2.7b) -> up [2,1] acting [2,1]
>
>> You'll see the osd ids listed in brackets after 'active'. =A0We want=
 the
>> first one, 0 in my example. =A0The log from that OSD is what we need=
=2E
>
> Okay, i'm attaching the compressed log for osd.2 and the compressed b=
lock to
> the issue report in the redmine.
>
> =A0 =A0 =A0 =A0Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Stefan Majer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
