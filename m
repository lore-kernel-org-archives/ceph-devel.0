From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Stable/Master debian/rules not stripping all packages
Date: Wed, 4 Jul 2012 08:41:13 +0200
Message-ID: <201207040841.14683.a.ott@m-privacy.de>
References: <201207031358.20801.a.ott@m-privacy.de> <Pine.LNX.4.64.1207030854560.28638@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:42581 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793Ab2GDGlX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 02:41:23 -0400
In-Reply-To: <Pine.LNX.4.64.1207030854560.28638@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday 03 July 2012 wrote Sage Weil:
> On Tue, 3 Jul 2012, Amon Ott wrote:
> > just found out that some Debian binary packages do not get stripped=
 - a
> > 53MB ceph-mds does look a bit weird.
> >
> > Identified packages ceph-mds and gceph and added these lines:
> >         dh_strip -pceph-mds --dbg-package=3Dceph-mds-dbg
> >         dh_strip -pgceph --dbg-package=3Dgceph-dbg
>
> I added stripping for ceph-mds, but gceph has been removed... I'm
> curious which you're looking at that has both ceph-mds and gceph?

My fault, found that later when building again. I still had some old gc=
eph-dbg=20
package in my repository, deleted that now.

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
