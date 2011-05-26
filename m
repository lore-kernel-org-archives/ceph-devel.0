From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: File only read, can't write, problem
Date: Thu, 26 May 2011 13:39:08 -0400
Message-ID: <BANLkTinzTcnxHAFUeTe2KTbdjMSRuQdJhw@mail.gmail.com>
References: <BANLkTi=2KDBCNxyrr9Nnhx=FBH0yrPY7XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51578 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758160Ab1EZRjK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2011 13:39:10 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id C0AD7C403
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:39:10 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6FB90C094
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:39:10 -0700 (PDT)
Received: by eyx24 with SMTP id 24so372192eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:39:09 -0700 (PDT)
In-Reply-To: <BANLkTi=2KDBCNxyrr9Nnhx=FBH0yrPY7XQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: ceph-devel@vger.kernel.org

I'm not quite sure what you're saying here -- can you give a more
precise description of the problem?

On Tue, May 24, 2011 at 12:44 AM, biyan chen <riby.chen@gmail.com> wrot=
e:
> mkcephfs -c /usr/local/etc/ceph/ceph.conf --allhosts --mkbtrfs -k
> /usr/local/etc/ceph/keyring.bin
> /etc/init.d/ceph -a start
>
> Startup ceph
>
>
>
> mount -t ceph 192.168.0.211:6789:/ /1 -vv
>
> This command =A0File only read, can't write!!
>
> cfuse -m =A0ceph_mon0:6789 /1 -c /usr/local/etc/ceph/ceph.conf
> Can read could write
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
