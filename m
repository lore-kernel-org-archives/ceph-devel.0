From: James Page <james.page@ubuntu.com>
Subject: Re: on disk encryption
Date: Mon, 10 Dec 2012 09:17:08 +0000
Message-ID: <50C5A894.8020507@ubuntu.com>
References: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net> <CANT6BaObaeTF9giuTi-f=2gjW4BUVHyZxRSvETNhunqAta=6FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51510 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab2LJJRL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 04:17:11 -0500
In-Reply-To: <CANT6BaObaeTF9giuTi-f=2gjW4BUVHyZxRSvETNhunqAta=6FA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dustin Kirkland <dustin.kirkland@gazzang.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 19/09/12 02:53, Dustin Kirkland wrote:
>>> Looking forward, another option might be to implement
>>> encryption inside btrfs (placeholder fields are there in the
>>> disk format, introduced along with the compression code way
>>> back when).  This would let ceph-osd handle more of the key
>>> handling internally and do something like, say, only encrypt
>>> the current/ and snap_*/ subdirectories.
>>> 
>>> Other ideas?  Thoughts?
>>> 
>>> sage
> I love the idea of btrfs supporting encryption natively much like
> it does compression.  It may be some time before that happens, so
> in the meantime, I'd love to see Ceph support dm-crypt and/or
> eCryptfs beneath.

Has this discussion progressed into any sort of implementation yet?
It sounds like this is going to be a key feature for users who want
top-to-bottom encryption of data right down to the block level.

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQxaiUAAoJEL/srsug59jDULUP/2pbVVNJC/Dt6S7A+uUGMGQJ
/jgFqu6SVHplTGs3cKqDYH22W9b34Gr/kcga9qj00lo844drRNRo/AVfdaA+j7Ge
gkqc4ZiwNgZSHmu+I9/4fDpSRJf19i2le1/qtIToAXsxZJyefM4clPrWblK24bRd
T7yWbVJBxjiYv7FziHZohDEJ/jz2OMk4THZYVkB+yuUPLbDnbFxqK17gRtKPuS/K
EeuFBw1kFgB0OKQ4LGy/GSOK1xM4NiGKpdV9beeSfu1L5f1ClW0Drl221gnhZ4qe
g6HXAdCK1xhDU2xUhrrPSp0iVFGjxjnvoQz7PikX6Hn5lhqjbAHVaoQ9dJpshAsY
86XDVFJJF2ca9FjzBGo+Cx7Ap0ahI4eK1NTiNc/zPEb8TgM9q1OtIlAb9A6pyC/E
l0WQ/0WzhbbnjeByXloLkTG2K0WkaJYovemc959VUrdpP5Di2vsEhhFsVFlFUlTC
i8xQaQZmoXXp8mhzNwdSLIcoUb9Y5MnghNO3mdz6WfM2KtyrTobi5lKZyFxZJfhA
oGt5It6AF/fRHi2Xu9yLyfVYrnf/oDJn1vjzJ0BkJLZ8rUANLVGYrpiKAECY1EF3
Nb2kXnhBVs1426TgvcAlchDUACPNUR2YVx9s12gHVTZURgrSr0+QMPHJL9uRJPxE
5T4wqmJNV2Caponla/fr
=wHrw
-----END PGP SIGNATURE-----
