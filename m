From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Object size
Date: Mon, 2 May 2011 09:09:36 -0700
Message-ID: <BANLkTimJVO281ou=G3y-SR7CHW54qH4iyQ@mail.gmail.com>
References: <4DB9B74A.10806@provocation.net>
	<1C8C3185A0EB4376832E44733D45DD77@gmail.com>
	<4DB9FE83.4090102@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43876 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab1EBQJi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2011 12:09:38 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 596A3C065
	for <ceph-devel@vger.kernel.org>; Mon,  2 May 2011 09:09:38 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 08723C063
	for <ceph-devel@vger.kernel.org>; Mon,  2 May 2011 09:09:37 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1800347ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 May 2011 09:09:36 -0700 (PDT)
In-Reply-To: <4DB9FE83.4090102@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 28, 2011 at 4:55 PM, Zenon Panoussis <oracle@provocation.ne=
t> wrote:
>
> On 04/28/2011 10:02 PM, Gregory Farnum wrote:
>
> [various explanations]
>
> Thanks Greg, that's very helpful towards graspings ceph's workings. I=
'll
> put it in the wiki.
>
>> The relation between these reports and your data can be a bit fuzzy,
>> though. When looking at the disk space used the OSD is just relying =
on
>> a df for the mount it's on -- if it's sharing that mount with anythi=
ng
>> else (eg, the node OS) then it's not distinguishing between OSD data=
,
>> and data on the disk. Something like that must be going on if you've
>> got a 4.4x ratio. (An example is below. [1]) Based on what you're gi=
ving
>> us here:
>
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

All right, a few other things.
1) Are you using snapshots? And what's the backing filesystem?
2) Can you run 'ceph pg dump -o -' and give us the output? That's
where the numbers are collated from, so hopefully we can see something
useful in there.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
