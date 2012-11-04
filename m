From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ubuntu R-Series plans for Ceph
Date: Sun, 04 Nov 2012 22:54:02 +0100
Message-ID: <5096E3FA.7040209@widodh.nl>
References: <507D960A.7040101@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:39546 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab2KDVyG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 16:54:06 -0500
In-Reply-To: <507D960A.7040101@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 16-10-12 19:14, James Page wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi All
>
> I've started to put together a Launchpad Blueprint to act as a
> placeholder for discussion at the Ubuntu Developer Summit in a couple
> of weeks time.
>
> I'd be interested in feedback on what folks would like to see from
> Ceph on Ubuntu in 6 months time for Ubuntu 13.04.
>
> Let me know what you think and I'll collate ideas.

Are there plans to build libvirt with RBD support? RBD storage pool 
support was added in libvirt 0.9.14 and it would be useful if libvirt 
was build with this storage backend support.

I can't seem to add this to the blueprint myself, so that's why I'm 
asking here.

Wido

>
> Cheers
>
> James
>
> [0] https://blueprints.launchpad.net/ubuntu/+spec/servercloud-r-ceph
> - --
> James Page
> Ubuntu Core Developer
> Debian Maintainer
> james.page@ubuntu.com
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://www.enigmail.net/
>
> iQIcBAEBCAAGBQJQfZYKAAoJEL/srsug59jDl9EP/i8gFCkiZpfoPF7pVGy1JYMZ
> Iy/dIIqnIEgedSq/bdWt9WKZ8vOn2vC/gE2cSTqylBKjH5w7UAtMFHlJWZAUM8tA
> HoiXIxXbmvv2rFm1qVfQhpKCiJ+RhSg5eOfhNz90UgDii1Xoc8aN+TsrvtZcgkqu
> ouJ/T+UbAIVocEO/6fbBOJXsVGFT8WIy4R3zlOTYe+Xrnprxx70ZkzeZ2f9+i2so
> Lmm48kPHjW8y+QVhr9gALY5I+WGU47yjv3WGsuCgNDfk8DJY15exmaCov172x0m6
> eZTp4DQMkBiUePABo/NZLZqEk1WC0wYQ3dJ9II4UUWyBkMas5gG6Pi0m2MSil8+m
> L0Voo0wJxfbvg7wrlL5dr4szcjfMVx+F1P7exeOnRAplNoueBNDTQaqItHe0L740
> MmXEwqrEuRMw8c8wbqWSUywJuEjBLzGhA9aHVrMUzrz0FjdoZhzSXFa2C3lK0Y0E
> DPaj69fenwz+1J25EP/GDpcXtjw1k/gskEcVNFnDEyyvI5BjbiqbhE1q/tezcZjs
> DT00NdJL4dIpu5BgP8XezOyideskZfNh6ExgMub48ObPje2YEn9OmRflRALmJyrW
> 2ZLrgkqV0BTVGOrMU4IZa/xyNy5NpRf7uvr7hCVyLq0RopCPorbBJT+1wLaAXYx7
> FxRtGgTht76an1S1Sn3L
> =xvlU
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
