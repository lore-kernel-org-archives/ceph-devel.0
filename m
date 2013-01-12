From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Sat, 12 Jan 2013 08:36:34 -0800
Message-ID: <CAPrxi58uyBNJTvHnwKyALWN=f0XiiFicnDHOfWfOCT4tebqxxw@mail.gmail.com>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de>
	<CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com>
	<BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com>
	<50EE73F3.6050705@bisect.de>
	<3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:63178 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab3ALQgf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Jan 2013 11:36:35 -0500
Received: by mail-vc0-f182.google.com with SMTP id fy27so2373115vcb.41
        for <ceph-devel@vger.kernel.org>; Sat, 12 Jan 2013 08:36:35 -0800 (PST)
In-Reply-To: <3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

On Thu, Jan 10, 2013 at 9:13 PM, Gary Lowell <gary.lowell@inktank.com> wrote:
>
> Thanks Danny.  Installing sharutils solved that minor issue.  We now get though the build just fine on opensuse 12, but sles 11sp2 gives more warnings (pasted below).  Should we be using a newer version of autoconf  on sles?  I've tried moving AC_CANONICAL_TARGET earlier in the file, but that causes some other issues with the new java macros.

We could also move away from using autoconf/automake for Java, and use
a packaging/dependency system designed for Java, like Maven.

- Noah
