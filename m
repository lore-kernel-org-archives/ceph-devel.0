From: James Page <james.page@ubuntu.com>
Subject: Re: Ubuntu R-Series plans for Ceph
Date: Mon, 05 Nov 2012 09:33:16 +0000
Message-ID: <509787DC.1060709@ubuntu.com>
References: <507D960A.7040101@ubuntu.com> <5096E3FA.7040209@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40982 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2KEJdT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 04:33:19 -0500
In-Reply-To: <5096E3FA.7040209@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Wido

On 04/11/12 21:54, Wido den Hollander wrote:
>> I've started to put together a Launchpad Blueprint to act as a 
>> placeholder for discussion at the Ubuntu Developer Summit in a
>> couple of weeks time.
>> 
>> I'd be interested in feedback on what folks would like to see
>> from Ceph on Ubuntu in 6 months time for Ubuntu 13.04.
>> 
>> Let me know what you think and I'll collate ideas.
> 
> Are there plans to build libvirt with RBD support? RBD storage
> pool support was added in libvirt 0.9.14 and it would be useful if
> libvirt was build with this storage backend support.
> 
> I can't seem to add this to the blueprint myself, so that's why
> I'm asking here.

Sounds sensible and a nice addition to the rbd support already baked
into qemu-kvm.

I'll raise it on the blueprint and talk to the libvirt maintainers in
Ubuntu about getting it enabled.

Cheers

James

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBCAAGBQJQl4fcAAoJEL/srsug59jDov0P/jUdO0s30ONbFOINx+9f9S/r
1S0syIxmoL9Ul+jd2GIRQLvt2pM/lEJJpgQoLI8u3n0poS0D7gDPkhvq2GXXlMCl
F8jAf7ehruduDOiZhvWPZvhBhKyOmQ7lmSvHA3PovwJsCAbgA2mZKacFBEicRxM6
vx0CeCEP34G3vcSf5Fre3MMsYk0+w4mrhput9Bg4zy3X93VwuTQUJjTcXUVVGR+H
24ZYP10YTVz6LUrNKng1CZiVGV9S9su/klVHzCu4fOD87yGB0wq5p2m4BGN9m3c/
VG1rY4xdjLlHZbdSEIiltpVwqtLMYjJwxuXGZoXi0a/WmvtNXpajsXCdSbJxoz1P
mHhMd1QIDyouL7w/QjvPGmaGI2rzOEbhcsX8DaeWfDihA6fkL0Eue1vR2PCvUamp
74yQiOH2dqFmJ1MRaUTX6EmcecqNMHYXH4VDZulb+DG/VkjylAFS+l45WWYlyvEh
ni46hCxt0U06xSHRm81/L2CXlHCnU5q1nbKJghzfm9UzuLzZZF79H68DGCZeb+64
VI4wy1+4B74MWVsCmaAFlDp95R2BRPpJ1NEee70hFhrtFzCdt7/7Vag7KOZKyXaT
BRHJehInFk6LpxlOLEJmENaH5tExFd8OQIvJu9u7a2pEMhUUYOUd9wOvK8GIcEOM
VYXSCTQihrjHdATr5CXD
=JoFJ
-----END PGP SIGNATURE-----
