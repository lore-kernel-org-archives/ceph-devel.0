From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Integration work
Date: Wed, 29 Aug 2012 09:06:47 +0200
Message-ID: <201208290906.48788.a.ott@m-privacy.de>
References: <503D0A00.2080905@inktank.com> <20120828185116.GC9872@oder.mch.fsc.net> <CANLRBoyP6TmjA8BPgXR4DE1O6ux_U+AAoU3i2jFW6yjU415KyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:42437 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726Ab2H2HQc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 03:16:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id C4FFC63C17
	for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 09:06:52 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 28965-07 for <ceph-devel@vger.kernel.org>;
 Wed, 29 Aug 2012 09:06:46 +0200 (CEST)
Received: from gw.compuniverse.de (unknown [85.183.4.97])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id F1D9663C16
	for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 09:06:45 +0200 (CEST)
Received: from tgham.compuniverse.de (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw.compuniverse.de (Postfix) with ESMTPS id E0C7A20F2F
	for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 09:06:49 +0200 (CEST)
In-Reply-To: <CANLRBoyP6TmjA8BPgXR4DE1O6ux_U+AAoU3i2jFW6yjU415KyA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Tuesday 28 August 2012 you wrote:
> On Tue, Aug 28, 2012 at 11:51 AM, Dieter Kasper <d.kasper@kabelmail.d=
e>=20
wrote:
> > Hi Ross,
> >
> > focusing on core stability and feature expansion for RBD was the ri=
ght
> > appoach in the past and I feel you have reached an adequate maturit=
y
> > level here.
> >
> > Performance enhancements - especially to reduce the latency of a si=
ngle
> > IO / increase IOPS - and a stronger engagement on the CephFS client=
 would
> > be very much appreciated. A stable and fast CephFS client would all=
ow an
> > efficient integration with - (clustered) NFS (v3 and v4)
> > - (clustered) Samba v4
>
> +1 to CephFS being worked on. Things like the multi-mds being improve=
d
> upon would be amazing.

Stable CephFS is what we need, too - many concurrent write accesses fro=
m=20
multiple clients with a real file system underneath. However, most stab=
ility=20
problems we have had so far were crashes in the daemons, not the Linux=20
kernel. Great for me would be some solution to what we call the Domino=20
effect - one daemon crashes, the next takes over, crashes at the same p=
lace=20
(same data...), until the whole cluster is down. There will always be b=
ugs,=20
but they should not kill the whole cluster.

In our tests, single MDS was no real bottleneck, it was only lacking=20
stability. I have not tested the newest releases, so it might be better=
 now.=20
Improved performance with many small files being written concurrently w=
ould=20
be great, but CephFS has been getting significantly faster over the las=
t year=20
and performance is being worked on all the time.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 99296856
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
