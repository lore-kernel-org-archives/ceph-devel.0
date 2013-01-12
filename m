From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Sat, 12 Jan 2013 22:59:06 +0100
Message-ID: <50F1DCAA.8020802@bisect.de>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de> <CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com> <BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com> <50EE73F3.6050705@bisect.de> <3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:43721 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754284Ab3ALV7L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 12 Jan 2013 16:59:11 -0500
In-Reply-To: <3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Gary Lowell <gary.lowell@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, Sage Weil <sage@inktank.com>

Am 11.01.2013 06:13, schrieb Gary Lowell:
[...]
> Thanks Danny.  Installing sharutils solved that minor issue.  We now
> get though the build just fine on opensuse 12, but sles 11sp2 gives
> more warnings (pasted below).  Should we be using a newer version of
> autoconf  on sles?  I've tried moving AC_CANONICAL_TARGET earlier in
> the file, but that causes some other issues with the new java
> macros.
> 
> Thanks, Gary

I'll take a look at it, I guess it's a problem in configure.ac.

I see the same warnings in our build system at SUSE for SLES (see: e.g.
logs at
https://build.opensuse.org/project/monitor?project=home%3Adalgaaf%3Abranches%3Afilesystems),
but the package builds just fine for openSUSE, SLES, Fedora, RHEL and
CentOS there.

Danny
