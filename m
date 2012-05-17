From: Sage Weil <sage@inktank.com>
Subject: Re: global_init_daemonize: BUG: there are 1 child threads already
 started that will now die!
Date: Thu, 17 May 2012 09:02:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205170902090.7019@cobra.newdream.net>
References: <12500703.xTHoDB74aK@mranderson>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2020904051-1337270565=:7019"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35339 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760102Ab2EQQCt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 12:02:49 -0400
In-Reply-To: <12500703.xTHoDB74aK@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2020904051-1337270565=:7019
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 May 2012, Sz=E9kelyi Szabolcs wrote:
> Hello,
>=20
> I get the $subject message when starting Ceph with the init script. I hav=
e to=20
> try it 15-20 times until the start suceeds. I've seen this message emitte=
d by=20
> the monitor and MDS daemons, but never by OSDs. Is this really a bug as t=
he=20
> message says? I have two theoretically identical clusters, and only one o=
f=20
> them produces this error, so something might be wrong on my side, but wha=
t?

This is just a broken/racy check.  There's a patch in the stable branch=20
that removes it.  It'll also be fixed in 0.47, out tomorrow most likely.

sage
--557981400-2020904051-1337270565=:7019--
