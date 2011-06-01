From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: File only read, can't write, problem
Date: Wed, 1 Jun 2011 09:22:46 -0700
Message-ID: <BANLkTi=H4H3EJ0=NjAr43eyYyVNu-U35sg@mail.gmail.com>
References: <BANLkTi=2KDBCNxyrr9Nnhx=FBH0yrPY7XQ@mail.gmail.com>
	<BANLkTinzTcnxHAFUeTe2KTbdjMSRuQdJhw@mail.gmail.com>
	<BANLkTi=8-u4Rn0LBdvQa_+bFpzkedCNZ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38737 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab1FAQWt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 12:22:49 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id C6378C4A9
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jun 2011 09:22:48 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 76352C499
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jun 2011 09:22:48 -0700 (PDT)
Received: by eyx24 with SMTP id 24so2080402eyx.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jun 2011 09:22:46 -0700 (PDT)
In-Reply-To: <BANLkTi=8-u4Rn0LBdvQa_+bFpzkedCNZ=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: ceph-devel@vger.kernel.org

Can you ls -la on the mounted directory and send us the output? FUSE
can be funny with permissions and usually they're set to root on
mount, but yours might be set to a special FUSE user or something...
(in which case you just need to chmod the mountpoint)
-Greg

2011/5/31 biyan chen <riby.chen@gmail.com>:
> I have mount on ceph file system, but, after entering directory canno=
t
> read documents.
>
>
> [root@ceph_client 1]# df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda1            472658192  20199408 428449108   5% /
> tmpfs                  1984548         0   1984548   0% /dev/shm
> /dev/loop0             3351190   3351190         0 100% /mnt/cdrom
> 192.168.0.211:6789:/ 158047232     81920 155843584   1% /1
> [root@ceph_client 1]# echo "1">>1.txt
> -bash: 1.txt: Permission denied
> [root@ceph_client 1]# ll
> total 0
> [root@ceph_client 1]# cd /
> [root@ceph_client /]# ll
> total 112
> drwxr-xr-x.   1 root root     0 Jun  1 20:05 1
>
>
> I to execute the command :
> mount -o remount, rw /1
>
> Still hint without permission
>
>
> 2011/5/27 Gregory Farnum <gregf@hq.newdream.net>:
>> I'm not quite sure what you're saying here -- can you give a more
>> precise description of the problem?
>>
>> On Tue, May 24, 2011 at 12:44 AM, biyan chen <riby.chen@gmail.com> w=
rote:
>>> mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs -k
>>> /usr/local/etc/ceph/keyring.bin
>>> /etc/init.d/ceph -a start
>>>
>>> Startup ceph
>>>
>>>
>>>
>>> mount -t ceph 192.168.0.211:6789:/ /1 -vv
>>>
>>> This command  File only read, can't write!!
>>>
>>> cfuse -m  ceph_mon0:6789 /1 -c /usr/local/etc/ceph/ceph.conf
>>> Can read could write
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>
>
>
> --
> name:Riby
> mobile:+86 15280267642
> company: =B0=D9=B4=F3=C1=FA=D2=BB
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
