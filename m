From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: BUG at fs/inode.c
Date: Tue, 1 Nov 2011 09:23:17 +0100
Message-ID: <201111010923.18074.a.ott@m-privacy.de>
References: <201110241239.13157.a.ott@m-privacy.de> <201110251038.06482.a.ott@m-privacy.de> <201110251635.11474.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:49196 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303Ab1KAIX2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2011 04:23:28 -0400
In-Reply-To: <201110251635.11474.a.ott@m-privacy.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tuesday 25 October 2011 wrote Amon Ott:
> On Tuesday 25 October 2011 wrote Amon Ott:
> > On Monday 24 October 2011 wrote Yehuda Sadeh Weinraub:
> > > Also, the client logs could help shedding a light on the issue. Y=
ou
> > > should have dynamic debugging turned on (CONFIG_DYNAMIC_DEBUG), a=
nd
> > > something along the lines of:
> > >
> > > # mount -t debugfs none /sys/kernel/debug
> > > # echo 'module ceph +p' > /sys/kernel/debug/dynamic_debug/control
> > > # echo 'module libceph +p' > /sys/kernel/debug/dynamic_debug/cont=
rol
> >
> > New kernels are building right now. Upgraded to 3.0.8, put in new
> > ceph-client master fix 8ba1683acc83aee4bcab304844f8e60330e5ef1f and=
 added
> > CONFIG_DYNAMIC_DEBUG. This kernel will go into two big servers this=
 time
> > to give it some real load. Let's see whether I can reproduce there,=
 too.
> > If so, I will provide debug output as requested.
>
> Finally, I could reproduce with debugging on and keep the system aliv=
e long
> enough to copy the kernel log. Attached are two examples of the BUG
> happening with surrounding Ceph logs. Before and after these extracts=
 are
> some seconds without logging, so I assume they are complete.

Any news on this bug? Do you need more info? I would really like to go =
on=20
testing, but this bug is a show stopper for me.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
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
