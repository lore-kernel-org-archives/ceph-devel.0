From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Stale NFS file handle
Date: Thu, 23 Feb 2012 10:43:02 -0800
Message-ID: <CAORUGqBO2Y7XMLbHb1z0s3b-H0H_Tpb1gwQwf2mpi+mgQ5EObA@mail.gmail.com>
References: <7386587.xNpCPNsyj0@mranderson> <4477620.YaFairnoV9@mranderson>
 <Pine.LNX.4.64.1202131553310.32014@cobra.newdream.net> <2047170.AK8tFQQFuI@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42534 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab2BWSnX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 13:43:23 -0500
Received: by wgbdt10 with SMTP id dt10so1364391wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2012 10:43:22 -0800 (PST)
In-Reply-To: <2047170.AK8tFQQFuI@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Sz=C3=A9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

2012/2/13 Sz=C3=A9kelyi Szabolcs <szekelyi@niif.hu>:
>> Okay, that sounds like a bug then. =C2=A0The two interesting things =
would be a
>> ceph-fuse log (--debug-client 10 --debug-ms 1 --log-file /path/to/lo=
g) and
>> an mds log (debug mds =3D 20, debug ms =3D 1 in [mds] section of cep=
h.conf).
>
> Thanks, I've set it up, now waiting for it to break. ;)

Anything new here? Did you manage to capture logs of the problem?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
