From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Thu, 10 Jan 2013 08:55:31 +0100
Message-ID: <50EE73F3.6050705@bisect.de>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de> <CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com> <BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:50483 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932560Ab3AJHzf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Jan 2013 02:55:35 -0500
In-Reply-To: <BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Gary Lowell <gary.lowell@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@inktank.com>

Am 10.01.2013 05:32, schrieb Gary Lowell:
> I have this patch, and the ones from Friday in the wip-rpm-update bra=
nch.  Everything looks good except that we have the following new warni=
ng from configure:
>=20
> =85.
> checking for kaffe... no
> checking for java... java
> checking for uudecode... no
> WARNING: configure: I have to compile Test.class from scratch
> checking for gcj... no
> checking for guavac... no
> checking for jikes=85 no
> =85.
>=20
> This may have to do with something in our build environment.

I assume you have no uudecode installed. It should be part of sharutils
(http://www.gnu.org/software/sharutils/)

Regards,

Danny
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
