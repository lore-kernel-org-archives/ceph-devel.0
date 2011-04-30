From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Object size
Date: Fri, 29 Apr 2011 17:04:09 -0700
Message-ID: <BANLkTimZc2-m0QUKZt85isp016xC03+Tpg@mail.gmail.com>
References: <4DB9B74A.10806@provocation.net>
	<1C8C3185A0EB4376832E44733D45DD77@gmail.com>
	<4DB9FE83.4090102@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46751 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757516Ab1D3AEL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2011 20:04:11 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3EC0BC069
	for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2011 17:04:11 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id E2EC3C066
	for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2011 17:04:10 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1285175eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2011 17:04:09 -0700 (PDT)
In-Reply-To: <4DB9FE83.4090102@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 28, 2011 at 4:55 PM, Zenon Panoussis <oracle@provocation.ne=
t> wrote:
> On 04/28/2011 10:02 PM, Gregory Farnum wrote:
>> 1) You have 9791 MB of data in the filesystem.
>> 2) You have (12222MB - 9791 MB=3D) 2431MB of metadata maintaining th=
e Ceph tree.
>> 3) RADOS is using 24444MB of disk space amongst all your OSDs to sto=
re this.
>> 4) Your nodes have other stuff installed to the tune of (29135MB/2=3D=
)14567MB or (29135/3=3D)9711MB per OSD.
>
> 1 and 3 are correct. 2 is presumably correct; it makes perfect sense =
and
> there's no reason to question it. 4 is not correct:
>
> # df -m
> [...]
> /dev/mapper/sda6 =A0 =A0 =A0 =A0232003 =A0 =A0 26913 =A0 =A0191832 =A0=
13% /mnt/osd
>
> # grep /mnt/osd /etc/ceph/ceph.conf
> =A0 =A0 =A0 =A0osd data =3D /mnt/osd
>
> # ls -a /mnt/osd/
> . =A0.. =A0ceph_fsid =A0current =A0fsid =A0lost+found =A0magic =A0who=
ami
>
> So the OSD lives in its own exclusive partition and nothing else uses=
 that
> partition. The other node is done the same way. The "53579 MB used" r=
eported
> by ceph matches the aggregated "Used" output of df -m on both nodes. =
And
> I checked, lost+found is empty on both. Something here is trying to b=
e elusive
> (and is succeeding).

Hmmm, that's unexpected. Is there anything in the lost+found dir?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
