From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Stale NFS file handle
Date: Mon, 13 Feb 2012 17:04:27 -0800
Message-ID: <CAORUGqDdHPGkBZUV1Hpt5on2hdoYw0z=fFVRcuFb9Mk5CW-KWA@mail.gmail.com>
References: <7386587.xNpCPNsyj0@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61639 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2BNBEs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 20:04:48 -0500
Received: by wgbdt10 with SMTP id dt10so5401604wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2012 17:04:47 -0800 (PST)
In-Reply-To: <7386587.xNpCPNsyj0@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Sz=C3=A9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

2012/2/13 Sz=C3=A9kelyi Szabolcs <szekelyi@niif.hu>:
> I'm using Ceph 0.41 with the FUSE client. After a while I get stale N=
=46S file
> errors when trying to read a file or list a directory. Logs and scrub=
bing
> doesn't show any errors or suspicious entries. After remounting the f=
ilesystem
> either by restarting the cluster thus forcing the clients to reconnec=
t or
> umount+mount, files and directories either show up again or seem lost=
 forever.
>
> Can you give me any hint on what to check?

Is this on a 32-bit machine, by any chance?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
