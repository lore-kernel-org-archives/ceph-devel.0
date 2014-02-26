From: Sage Weil <sage@inktank.com>
Subject: New upstream of libedit + UTF8 (fwd)
Date: Wed, 26 Feb 2014 14:24:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402261422570.17508@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2085306938-1393453449=:17508"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55007 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbaBZWYT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Feb 2014 17:24:19 -0500
Content-ID: <alpine.DEB.2.00.1402261424160.17508@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ken.dreyer@inktank.com, dan.mick@inktank.com
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2085306938-1393453449=:17508
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1402261424161.17508@cobra.newdream.net>

There is a libedit update coming.  IIRC, this was a dependency for the old 
version of the ceph CLI but the new python implementation should not need 
it.  Probably this just needs to be removed from configure.ac and the 
package dependencies?
--557981400-2085306938-1393453449=:17508
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1402261422571.17508@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: INLINE

Return-Path: <sylvestre@debian.org>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 3769B80466
	for <sage@cobra.newdream.net>; Wed, 26 Feb 2014 10:22:02 -0800 (PST)
Received: by destro.newdream.net (Postfix)
	id 347A512095A; Wed, 26 Feb 2014 10:22:02 -0800 (PST)
Delivered-To: sage@destro.newdream.net
Received: from madmax.dreamhost.com (caiajhbdcahe.dreamhost.com
	[208.97.132.74])
	by destro.newdream.net (Postfix) with ESMTP id 0CF491208C2
	for <sage@newdream.net>; Wed, 26 Feb 2014 10:22:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by madmax.dreamhost.com (Postfix) with ESMTP id CDCB5FD666C
	for <sage@newdream.net>; Wed, 26 Feb 2014 10:22:01 -0800 (PST)
X-DH-Virus-Scanned: Debian amavisd-new at madmax.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 3.4
X-Spam-Level: ***
X-Spam-Status: No, score=3.4 tagged_above=-999 required=999
	tests=[KHOP_BIG_TO_CC=3.4] autolearn=disabled
Received: from terminator.dreamhost.com ([208.97.132.138])
	by localhost (madmax.dreamhost.com [208.97.132.139]) (amavisd-new,
	port 10024) with ESMTP id Iaq6SBPEQ7NC for <sage@newdream.net>;
	Wed, 26 Feb 2014 10:22:00 -0800 (PST)
Received: from batou.ecranbleu.org (batou.ecranbleu.org [88.190.32.89])
	by terminator.dreamhost.com (Postfix) with ESMTP id 5595728853A7
	for <sage@newdream.net>; Wed, 26 Feb 2014 10:16:41 -0800 (PST)
Received: by batou.ecranbleu.org (Postfix, from userid 999)
	id 82A0B12BFE4; Wed, 26 Feb 2014 19:16:34 +0100 (CET)
Received: from [192.168.12.6] (unknown [192.168.12.6])
	(Authenticated sender: sylvestredeb@ledru.info)
	by batou.ecranbleu.org (Postfix) with ESMTPSA id 26DEF12BE49;
	Wed, 26 Feb 2014 19:16:30 +0100 (CET)
Message-ID: <530E2F82.3040300@debian.org>
Date: Wed, 26 Feb 2014 19:16:34 +0100
From: Sylvestre Ledru <sylvestre@debian.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Icedove/24.3.0
MIME-Version: 1.0
To: Andreas Tille <tille@debian.org>, Anton Gladky <gladk@debian.org>,
	Aurelien Jarno <aurel32@debian.org>,
	Bdale Garbee <bdale@gag.com>, Brian May <bam@debian.org>,
	Ceph Maintainers <ceph-maintainers@lists.ceph.com>,
	Chris Lamb <lamby@debian.org>, Christian Hofstaedtler <zeha@debian.org>,
	Christoph Berg <myon@debian.org>, Christoph Egger <christoph@debian.org>,
	Colin Watson <cjwatson@debian.org>, Damyan Ivanov <dmn@debian.org>,
	Debian Firebird Group <pkg-firebird-general@lists.alioth.debian.org>,
	Debian Haskell Group <pkg-haskell-maintainers@lists.alioth.debian.org>,
	Debian Java Maintainers <pkg-java-maintainers@lists.alioth.debian.org>,
	Debian NTP Team <pkg-ntp-maintainers@lists.alioth.debian.org>,
	Debian OpenSSH Maintainers <debian-ssh@lists.debian.org>,
	Debian PHP Maintainers <pkg-php-maint@lists.alioth.debian.org>,
	Debian PostgreSQL Maintainers
	<pkg-postgresql-public@lists.alioth.debian.org>, Debian Science Team
	<debian-science-maintainers@lists.alioth.debian.org>,
	Debian VoIP Team <pkg-voip-maintainers@lists.alioth.debian.org>,
	GNU/kFreeBSD Maintainers <debian-bsd@lists.debian.org>,
	"Gudjon I. Gudjonsson" <gudjon@gudjon.org>,
	Guillem Jover <guillem@debian.org>,
	"HIGUCHI Daisuke (VDR dai)" <dai@debian.org>,
	Jakub Wilk <jwilk@debian.org>, James Page <jamespage@debian.org>,
	Jan Wagner <waja@cyconet.org>,
	Jeffrey Ratcliffe <jeffrey.ratcliffe@gmail.com>,
	Jelmer Vernooij <jelmer@debian.org>,
	=?UTF-8?B?SmVyZW15IExhaW7DqQ==?= <jeremy.laine@m4x.org>,
	Joachim Wiedorn <ad_debian@joonet.de>,
	Kiwamu Okabe <kiwamu@debian.or.jp>, Kurt Roeckx <kurt@roeckx.be>,
	Lars Bahner <bahner@debian.org>,
	"Laszlo Boszormenyi (GCS)" <gcs@debian.org>,
	Lior Kaplan <kaplan@debian.org>,
	LLVM Packaging Team <pkg-llvm-team@lists.alioth.debian.org>,
	Marco Nenciarini <mnencia@debian.org>,
	Mark Purcell <msp@debian.org>, Martin Pitt <mpitt@debian.org>,
	Matthew Vernon <matthew@debian.org>,
	Michael Meskes <meskes@debian.org>, Niels Thykier <niels@thykier.net>,
	Nobuhiro Iwamatsu <iwamatsu@debian.org>,
	=?UTF-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@debian.org>,
	Peter Eisentraut <petere@debian.org>,
	Reinhard Tartler <siretart@tauware.de>, Robert Millan <rmh@debian.org>,
	Ryan Kavanagh <rak@debian.org>,
	Sage Weil <sage@newdream.net>, Sean Finney <seanius@debian.org>,
	Sebastian Ramacher <sramacher@debian.org>,
	Stig Sandbeck Mathisen <ssm@debian.org>,
	Sylvestre Ledru <sylvestre@debian.org>,
	Thijs Kinkhorst <thijs@debian.org>, Tollef Fog Heen <tfheen@debian.org>,
	Tzafrir Cohen <tzafrir@debian.org>,
	Varnish Package Maintainers <pkg-varnish-devel@lists.alioth.debian.org>
Subject: New upstream of libedit + UTF8
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spambayes-Classification: ham; 0.00


Hello,

You receive this email because of your package has libedit as build-dep
[1] (and because libedit has
a crazy popcon and I don't want to break all packages).

A few days ago, I uploaded a new upstream version of libedit
(3.1-20140213-1~exp1).

I also turned on the utf-8 support (for more information,
http://bugs.debian.org/737786
https://bugs.launchpad.net/ubuntu/+source/libedit/+bug/816758
https://bugs.launchpad.net/ubuntu/+source/libedit/+bug/1276836 )

Both changes are available in experimental

I would appreciate if you could test if these changes haven't break your
packages.

I am planning to upload March 7th (Friday).

Thanks,
Sylvestre

[1] grep-dctrl -F Build-Depends "libedit-dev" -s Maintainer -s Uploaders
/var/lib/apt/lists/*unstable*_Sources


--557981400-2085306938-1393453449=:17508--
