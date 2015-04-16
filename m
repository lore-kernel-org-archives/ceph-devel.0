From: James Page <james.page@ubuntu.com>
Subject: Re: tcmalloc issue
Date: Thu, 16 Apr 2015 12:48:05 +0100
Message-ID: <552FA175.2000808@ubuntu.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1503261646150.31431@cobra.newdream.net> <551C1514.3060607@ubuntu.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB8270@SACMBXIP01.sdcorp.global.sandisk.com> <55261528.7040607@ubuntu.com> <9E914F5BD7F48A4782456CEB550A422824489892@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53779 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbbDPLsL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 07:48:11 -0400
In-Reply-To: <9E914F5BD7F48A4782456CEB550A422824489892@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Folks

The proposed fix is now in the 'proposed' pocket for 14.04 - see:

https://bugs.launchpad.net/ubuntu/+source/google-perftools/+bug/1439277

on how to enable that pocket for testing if you'd like to confirm that
you are able to use the required feature now.

Cheers

James

- -- 
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVL6F1AAoJEL/srsug59jDRGoP/AuQ8jGGAKgsRGu/aSnAzG0N
Aepa9AEnE2CH310HiYXqaKsmthKLwFy6vEkL0AkL4c4oDNVh9sdTaqBWV8qZXkxo
iSzWMeoId54du5F/wgk5e+Itk78tdxmdBhiALlCyudm2erlIYzc1iMLwBY1AIO3u
Ii7KngmPZj1d8DtUtfWAMoY8HbKSeZLpPpsu0mNOE6yzY/AycPlF/FPpWYoV2VBF
fUEOWu3FCst8YwGnegMwi3PIrjdvvVOfU1QxRJgeP8/oy5QB+LqAIHQEwpLsiASv
CJDZXj82SbFhMJxSj2vFF8WdfoNFz80DeMtdp268zjxaHVHVEjEszPAaZr862EHE
5qIXfAYgTYXtfI9p12OZm1PX7ogH45pfk5iMOZyZIWijkAnFHdMZ3ePHUMa+cBeR
DBE3Zbd7BJ+jFQ53rtkTI1L9TmUikad5BRVJXB9bVIENDOxj69vS7dn960FsWme8
CulQ/Scil/Da8vauo/itKx2ey3tVuxX96hUAHubCjBgQyPPmW/KTqICYLgMMUy2n
ZPMwVfKeM29KuLtyCu/VGdKtjaqjUl5QvTL0NJQaS18wFbsJOBGjwS2Mqfy2mVyU
3SDLAshD43m6Se2St8gEMIL3n5WYdGTksqb/iBVRKUfl3FhuBLTpb4ixtz3D2Tn1
HS2oqV/Bl/XFE0iyvPoM
=WHzY
-----END PGP SIGNATURE-----
