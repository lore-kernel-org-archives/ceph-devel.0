From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: To upgrade the ceph version(v0.26)
Date: Mon, 11 Apr 2011 08:27:11 -0700
Message-ID: <BANLkTinaXFoHmdYaMr8iH-RgSqyFv=jz0A@mail.gmail.com>
References: <BANLkTin3Cqw0=_yy2EQjNgk41_GAT6KQZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34845 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab1DKP1N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 11:27:13 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id B7FFCC06A
	for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 08:27:13 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 67A41C067
	for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 08:27:13 -0700 (PDT)
Received: by eyx24 with SMTP id 24so1745450eyx.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2011 08:27:11 -0700 (PDT)
In-Reply-To: <BANLkTin3Cqw0=_yy2EQjNgk41_GAT6KQZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "doki74216@gmail.com" <doki74216@gmail.com>
Cc: Ceph <ceph-devel@vger.kernel.org>

On Thu, Apr 7, 2011 at 7:16 PM, doki74216@gmail.com <doki74216@gmail.co=
m> wrote:
> Hi,
>
> MY current version is v0.24.3, I want to upgrade version to v 0.26.
> And my =A0Linux OS is Fedora 14.
>
> I want to know my step is correctly or not?
> Here is my upgraded steps:
> 1) We stop the current system (v0.24.3)by "/etc/init.d/ceph -a stop "
> 2) We start to download the newest version(v0.26) and install it.
> 3) Then we mkcephfs (by "mkcephfs -c /etc/ceph/ceph.conf --allhosts -=
-mkbtrfs
> -k keyring.bin") and start it(by " /etc/init.d/init-ceph -a -c
> /etc/ceph/ceph.conf start").
>
> But there's a problem I met when I was started the Ceph.
> The system stops running and it shows the error messages as shown bel=
ow:
>
>
> =3D=3D=3D mds.0 =3D=3D=3D
> Starting Ceph mds0 on host4...
> =A0** WARNING: Ceph is still under heavy development, and is only sui=
table for **
> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with =
important data. =A0 =A0 =A0 **
> terminate called after throwing an instance of 'ceph::buffer::end_of_=
buffer'
> =A0what(): =A0buffer::end_of_buffer
> bash: line 1: 24409 Segmentation fault =A0 =A0 =A0(core dumped)
> /usr/local/bin/cmds -i 0 -c /tmp/ceph.conf.5135
> failed: 'ssh host4 =A0/usr/local/bin/cmds -i 0 -c /tmp/ceph.conf.5135=
 '

Hmm. That's not something I'd expect to see on startup, especially
with a fresh filesystem. Can you get the backtrace from gdb?

> The second question is when we upgrate the ceph successfully.
> Is there any tool to transfer the existing data (which from the old
> ceph system) to the newest system?
> Because we thought the data in the older version(eg. 0.24.3) is
> slightly different from the newer version(eg. 0.26)?
> I want to know the data will be still correctly?
The on-disk format doesn't change too often and we try and keep it
backwards compatible -- you should be able to start up new daemons on
old data and in the worst case they will slowly upgrade it. If this
doesn't work then there's a bug somewhere.
So, no, you should not lose your data.

However, in the list of steps you took, you ran mkcephfs, and that did
kill all your data (I thought there were several warnings about this
when using the tool?). Running mkcephfs is only necessary when
creating the filesystem, not when upgrading it!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
