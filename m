From: James Page <james.page@canonical.com>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Tue, 15 Jan 2013 09:04:31 +0000
Message-ID: <50F51B9F.8020504@canonical.com>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de> <CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com> <BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com> <50EE73F3.6050705@bisect.de> <3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com> <CAPrxi58uyBNJTvHnwKyALWN=f0XiiFicnDHOfWfOCT4tebqxxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56033 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158Ab3AOJEf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 04:04:35 -0500
In-Reply-To: <CAPrxi58uyBNJTvHnwKyALWN=f0XiiFicnDHOfWfOCT4tebqxxw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Gary Lowell <gary.lowell@inktank.com>, Danny Al-Gaaf <danny.al-gaaf@bisect.de>, ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 12/01/13 16:36, Noah Watkins wrote:
> On Thu, Jan 10, 2013 at 9:13 PM, Gary Lowell
> <gary.lowell@inktank.com> wrote:
>>> 
>>> Thanks Danny.  Installing sharutils solved that minor issue.
>>> We now get though the build just fine on opensuse 12, but sles
>>> 11sp2 gives more warnings (pasted below).  Should we be using a
>>> newer version of autoconf  on sles?  I've tried moving
>>> AC_CANONICAL_TARGET earlier in the file, but that causes some
>>> other issues with the new java macros.
> We could also move away from using autoconf/automake for Java, and
> use a packaging/dependency system designed for Java, like Maven.

If this route it taken please bear in mind that use of Maven will
create some challenges in Ubuntu; specifically with regards to the
fact that ceph is in main and supported by Canonical and Maven +
associated toolchain is *huge* in terms of packages and is not in main.

Ant however is in main and fully supported.

- -- 
James Page
Technical Lead
Ubuntu Server Team
james.page@canonical.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQ9RufAAoJEL/srsug59jDYwoQAJbE3nEhxi0qiEQmyQpvkNlO
VhY2CA2Mu5z+WDkPuF2YqiisM1+v+10RUK077ZOv1K8QIcEffHGWJtuXxRarHGDY
+PHWTinNvNm56BDC6mxAOJPU1hPv0hOgho9E8jW9LJDNTajVGskr03BxMHDLu/OQ
W3X9CqrhD97WAXv95fhPGKQoWxyHUNLMxvusZvbRqMEr23+ccgkMfulOdjETe8LG
BwBCV8FPiFAYxJPaVxm9UvbRXHo3PXvOU8CIpEP0Wk87f3FDQbCTVzJIdSyp30xJ
762U+cXgN6zMkTpvZYHX6vN29vWGSNmkRcsSrGoIlbxZCTkYt13S8iBvSMDeCbVa
SX/YZQNPYEcnkcEDrgHoG0y4xQNcSwIjkji+dKf2A5lxOHU6qDEIcXMp7XMvx3ha
PVh+d2MkRiIPSw48n3d4TZch8VkbJBFFW1klLlC1yKHRsOPee8Ck+tyBAqnW6nCQ
2goiXsH73CASzznfjI3qo9kkIza4eL7k15AjeyMfXh3b88ssuALgDV1Bk9JI0G1b
LyzY7JMqCDqlvmGTJQwm14qKcP3HRGXl8WaNV8gGUo84BV3a2VmqjJw0WWekyk+z
3wSbPgFpQE31N7SmsYBhjROMngOrMdWc4ccEs/EiukDrvC+LnMrhuUmYQfa01iaS
zm59v1Ys83hx+2vapx0M
=Mjh1
-----END PGP SIGNATURE-----
