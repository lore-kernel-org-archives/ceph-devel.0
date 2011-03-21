From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: a problem about installion ceph on Centos 5.5
Date: Mon, 21 Mar 2011 08:21:15 -0700
Message-ID: <AANLkTi=O9PR9fxkkzKEbRp0Er32WN6J4-sv-FisxMf6a@mail.gmail.com>
References: <AANLkTimhLyAWkFJV8wZvNmQ+_fzb9fhkL6rFmLaa2oBL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43200 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab1CUPVR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 11:21:17 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id E4E69C068
	for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 08:21:16 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 950AAC066
	for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 08:21:16 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1544298ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 08:21:15 -0700 (PDT)
In-Reply-To: <AANLkTimhLyAWkFJV8wZvNmQ+_fzb9fhkL6rFmLaa2oBL@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Qian Wei <hzqianwei@gmail.com>
Cc: ceph-devel@vger.kernel.org

You need to include the port to connect to. By default this will be 678=
9:
[root@ceph86 /]# mount -t ceph 10.65.1.86:6789:/ /mnt/ceph
That is a pretty terrible error message though; I'll put a note in the =
tracker!

It's also possible you have other issues based on that libceph error
(did you accidentally set an option to enable cephx, but not
distribute the keys to your client?), but try fixing your mount
options and see if that deals with it.
-Greg

On Mon, Mar 21, 2011 at 12:25 AM, Qian Wei <hzqianwei@gmail.com> wrote:
> recently ,I install everyting about ceph on one centos-5.5 machine
> meet a problem:
>
> [root@ceph86 /]# mount -t ceph 10.65.1.86:/ /mnt/ceph
> mount: wrong fs type, bad option, bad superblock on 10.65.1.86:/,
> =A0 =A0 =A0 missing codepage or other error
> =A0 =A0 =A0 In some cases useful info is found in syslog - try
> =A0 =A0 =A0 dmesg | tail =A0or so
>
> [root@ceph86 /]# dmesg -c
> libceph: no secret set (for auth_x protocol)
> libceph: error -22 on auth protocol 2 init
>
>
> about software version:
>
> linux kernel is 2.6.37 , I choose build in btrfs and ceph in kernel
> btrfs-progs-0.19.tar.gz
> ceph-0.24
> operation system is i386
>
> Can you help me ?
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
