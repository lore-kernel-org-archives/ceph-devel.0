From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: read and write speed.
Date: Tue, 31 May 2011 07:51:16 -0700
Message-ID: <BANLkTimPzWufFvxQ_AiyHoJrE7b-+3an3w@mail.gmail.com>
References: <4DE41F34.8020504@ufm.su>
	<4DE4BC76.1080906@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36621 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1EaOvS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 10:51:18 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 5A4A3C2D3
	for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 07:51:18 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 09114C0AD
	for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 07:51:17 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1681943eyx.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 07:51:16 -0700 (PDT)
In-Reply-To: <4DE4BC76.1080906@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Sage created an issue to track this:
http://tracker.newdream.net/issues/1122

Based on the differences between the FUSE and kernel clients, it's
probably just readahead settings. :)
-Greg

On Tue, May 31, 2011 at 3:01 AM, Fyodor Ustinov <ufm@ufm.su> wrote:
> On 05/31/2011 01:50 AM, Fyodor Ustinov wrote:
>>
>> Hi!
>>
>> Fresh 0.28.2 cluster.
>>
>> Why reading two times slower than the writing by dd, but rados show
>> different.
>> (Second question - why rados bench crash on read test?)
>>
>>
>> root@gate0:/mnt# dd if=3D/dev/zero of=3Daaa bs=3D1024000 count=3D100=
00
>> 10000+0 records in
>> 10000+0 records out
>> 10240000000 bytes (10 GB) copied, 64.5598 s, 159 MB/s
>>
>> root@gate0:/mnt# dd if=3Daaa of=3D/dev/null bs=3D1024000
>> 10000+0 records in
>> 10000+0 records out
>> 10240000000 bytes (10 GB) copied, 122.513 s, 83.6 MB/s
>> root@gate0:/mnt#
>
> Additional. fuse vs kernel mount
>
> fuse:
>
> root@gate0:/mnt# dd if=3D/dev/zero of=3Dbbb bs=3D1024000 count=3D1000=
0
> conv=3Dfdatasync
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 75.7654 s, 135 MB/s
>
> root@gate0:/mnt# dd if=3Dbbb of=3D/dev/null bs=3D1024000
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 101.613 s, 101 MB/s
>
>
> kernel:
>
> root@gate0:/mnt# rm bbb
> root@gate0:/mnt# dd if=3D/dev/zero of=3Dbbb bs=3D1024000 count=3D1000=
0
> conv=3Dfdatasync
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 73.143 s, 140 MB/s
>
> root@gate0:/mnt# dd if=3Dbbb of=3D/dev/null bs=3D1024000
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 150.84 s, 67.9 MB/s
> root@gate0:/mnt#
>
> What? Ok. reboot. After reboot:
>
> root@gate0:/mnt# rm bbb
> root@gate0:/mnt# dd if=3D/dev/zero of=3Dbbb bs=3D1024000 count=3D1000=
0
> conv=3Dfdatasync
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 68.9618 s, 148 MB/s
>
> root@gate0:/mnt# dd if=3Dbbb of=3D/dev/null bs=3D1024000
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 165.564 s, 61.8 MB/s
> root@gate0:/mnt#
>
>
> Hmm... =A0unmount kernel and mount fuse...
>
> root@gate0:/mnt# cd
> root@gate0:~# umount /mnt
> root@gate0:~# cfuse -m 10.5.51.230:/ /mnt
> =A0** WARNING: Ceph is still under development. =A0Any feedback can b=
e directed
> =A0**
> =A0** =A0 =A0 =A0 =A0 =A0at ceph-devel@vger.kernel.org or http://ceph=
=2Enewdream.net/.
> **
> cfuse[1102]: starting ceph client
> cfuse[1102]: starting fuse
> root@gate0:~# cd /mnt/
> root@gate0:/mnt# dd if=3Dbbb of=3D/dev/null bs=3D1024000
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 93.076 s, 110 MB/s
> root@gate0:/mnt#
>
>
> What the hell?
>
>
>
> WBR,
> =A0 =A0Fyodor.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
