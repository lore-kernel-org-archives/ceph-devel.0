From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Re: Empty directory size greater than zero and can't remove
Date: Wed, 19 Dec 2012 09:44:14 +0800
Message-ID: <CAJiejCQWQK2RKvMJ-08WW+3Y+23oaghFYTWQ+u7-37grF+Liug@mail.gmail.com>
References: <CAJiejCRi8QOfQB5Y0rN5vQz-xiTeA1SKdku=8Xa_+3CZAjysLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:57255 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab2LSBtq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Dec 2012 20:49:46 -0500
Received: by mail-qa0-f50.google.com with SMTP id cr7so1137044qab.2
        for <ceph-devel@vger.kernel.org>; Tue, 18 Dec 2012 17:49:45 -0800 (PST)
In-Reply-To: <CAJiejCRi8QOfQB5Y0rN5vQz-xiTeA1SKdku=8Xa_+3CZAjysLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: maillist-linux <ceph-devel@vger.kernel.org>

2012/12/16 Drunkard Zhang <gongfan193@gmail.com>:
> I couldn't rm files in ceph, which was backuped files of one osd. It
> reports direcory not empty, but there's nothing under that directory,
> just the directory itself held some spaces. How could I shoot down th=
e
> problem ?
>
> log30 /mnt/bc # ls -aR osd.28/
> osd.28/:
> .  ..  osd.28
>
> osd.28/osd.28:
> .  ..  current
>
> osd.28/osd.28/current:
> .  ..  0.537_head
>
> osd.28/osd.28/current/0.537_head:
> .  ..
> log30 /mnt/bc # ls -lhd osd.28/osd.28/current/0.537_head
> drwxr-xr-x 1 root root 119M Dec 14 19:22 osd.28/osd.28/current/0.537_=
head
> log30 /mnt/bc #
> log30 /mnt/bc # rm -rf osd.28/
> rm: cannot remove =E2=80=98osd.28/osd.28/current/0.537_head=E2=80=99:=
 Directory not empty
> log30 /mnt/bc # rm -rf osd.28/osd.28/current/0.537_head
> rm: cannot remove =E2=80=98osd.28/osd.28/current/0.537_head=E2=80=99:=
 Directory not empty
>
> The cluster seems health:
> log3 ~ # ceph -s
>    health HEALTH_OK
>    monmap e1: 3 mons at
> {log21=3D10.205.118.21:6789/0,log3=3D10.205.119.2:6789/0,squid86-log1=
2=3D150.164.100.218:6789/0},
> election epoch 640, quorum 0,1,2 log21,log3,squid86-log12
>    osdmap e1864: 45 osds: 45 up, 45 in
>     pgmap v163907: 9224 pgs: 9224 active+clean; 3168 GB data, 9565 GB
> used, 111 TB / 120 TB avail
>    mdsmap e134: 1/1/1 up {0=3Dlog14=3Dup:active}, 1 up:standby
>
After mds restart, I got this error message:
2012-12-19 09:16:24.837045 mds.0 [ERR] unmatched fragstat size on
single dirfrag 100000006c7, inode has f(v6 m2012-11-24 23:18:34.947266
1773=3D1773+0), dirfrag has f(v6 m2012-12-17 12:43:52.203358
2038=3D2038+0)

How can I fix this?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
