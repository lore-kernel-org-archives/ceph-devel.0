From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: BUG at fs/inode.c
Date: Sat, 5 Nov 2011 18:06:51 +0100
Message-ID: <201111051806.52907.a.ott@m-privacy.de>
References: <201110241239.13157.a.ott@m-privacy.de> <201111020953.45095.a.ott@m-privacy.de> <Pine.LNX.4.64.1111020713070.2549@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:54371 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878Ab1KERHH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Nov 2011 13:07:07 -0400
In-Reply-To: <Pine.LNX.4.64.1111020713070.2549@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wednesday 02 November 2011 you wrote:
> On Wed, 2 Nov 2011, Amon Ott wrote:
> > On Tuesday 01 November 2011 wrote Sage Weil:
> > > Can you capture a larger log segment?  The hope is to catch the f=
irst
> > > use-after-free, and not the subsequent side-effects.
> >
> > I still have the full kern.log here from boot till BUG, cleaned it =
up a
> > bit (no firewall lines, RSBAC stuff) and uploaded to
> > https://download.m-privacy.de/kern-full.log.bz2
> >
> > Full ceph logging had been enabled as soon as possible, after boot =
and
> > before mounting ceph fs.
> >
> > > Also, the below patch may help us parse the output with multiple
> > > threads.
>
> The following would also help: 4f9ea86237b8d0005f5467fe817b4f1f095507=
2c,
> or wip-debug-inode-refs in ceph-client.git.

The bug had been a lot harder to trigger with all that debugging slowin=
g down=20
the systems, but now I have something. I hope it helps tracking that be=
ast=20
down. 282K compressed size, so I uploaded the full log there:

https://download.m-privacy.de/kern.log2.bz2

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
