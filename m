From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rbd - input/output error
Date: Mon, 14 Nov 2011 14:05:42 -0800
Message-ID: <CAORUGqAvxApfP660yFpLUdqXbQ6SYy-iMfkOGt_RB-AotHdR8A@mail.gmail.com>
References: <4EBF98B5.7040706@b1-systems.de> <Pine.LNX.4.64.1111141148220.29742@cobra.newdream.net>
 <4EC18864.4010308@b1-systems.de> <Pine.LNX.4.64.1111141338160.3717@cobra.newdream.net>
 <4EC18F46.70102@b1-systems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36999 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab1KNWGF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 17:06:05 -0500
Received: by wyh15 with SMTP id 15so6405519wyh.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 14:06:03 -0800 (PST)
In-Reply-To: <4EC18F46.70102@b1-systems.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linde@b1-systems.de
Cc: ceph-devel@vger.kernel.org

On Mon, Nov 14, 2011 at 13:59, Mario van der Linde <linde@b1-systems.de=
> wrote:
> At first, on all Systems this file exists, but in /usr/lib64, not /us=
r/lib:
>> ceph5:~ # for f in `seq 1 5`; do ssh ceph${f} ls -l /usr/lib64/rados=
-classes; done | grep ' libcls_rbd.so '
>> lrwxrwxrwx 1 root root =C2=A0 =C2=A019 Nov 10 10:15 libcls_rbd.so ->=
 libcls_rbd.so.1.0.0
>> lrwxrwxrwx 1 root root =C2=A0 =C2=A019 Nov 10 10:15 libcls_rbd.so ->=
 libcls_rbd.so.1.0.0
>> lrwxrwxrwx 1 root root =C2=A0 =C2=A019 Nov 10 10:16 libcls_rbd.so ->=
 libcls_rbd.so.1.0.0
>> lrwxrwxrwx 1 root root =C2=A0 =C2=A019 Nov 10 10:16 libcls_rbd.so ->=
 libcls_rbd.so.1.0.0
>> lrwxrwxrwx 1 root root =C2=A0 =C2=A019 Nov 10 10:16 libcls_rbd.so ->=
 libcls_rbd.so.1.0.0
>
> Seems to be the right place in an x86_64 system.
>
> In ceph.conf there is no setting regarding to lib path.

Ah, new-style multi-arch. We haven't tested with an environment like th=
at yet.

You should be able to put this in ceph.conf and work around it:

[global]
osd class dir =3D /usr/lib64/rados-classes

> Is ceph-radosgw needed for rbd? I think not, while radosgw is AFAIK t=
he
> REST interface...
> This package is not installed (due to a not resolveable cgi dependenc=
y).

No, it is not.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
