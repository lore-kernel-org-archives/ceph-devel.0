From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: BUG at fs/inode.c
Date: Wed, 2 Nov 2011 09:53:44 +0100
Message-ID: <201111020953.45095.a.ott@m-privacy.de>
References: <201110241239.13157.a.ott@m-privacy.de> <201111010923.18074.a.ott@m-privacy.de> <Pine.LNX.4.64.1111010907470.30839@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.138.176]:39614 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755050Ab1KBIxy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Nov 2011 04:53:54 -0400
In-Reply-To: <Pine.LNX.4.64.1111010907470.30839@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tuesday 01 November 2011 wrote Sage Weil:
> Can you capture a larger log segment?  The hope is to catch the first
> use-after-free, and not the subsequent side-effects.

I still have the full kern.log here from boot till BUG, cleaned it up a=
 bit=20
(no firewall lines, RSBAC stuff) and uploaded to=20
https://download.m-privacy.de/kern-full.log.bz2

=46ull ceph logging had been enabled as soon as possible, after boot an=
d before=20
mounting ceph fs.

> Also, the below patch may help us parse the output with multiple thre=
ads.

Put in the patch, new kernel packages building now.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=C3=B6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=C3=A4ftsf=C3=BChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
