From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: tcmalloc issue
Date: Thu, 16 Apr 2015 14:55:41 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD7A5AF@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1503261646150.31431@cobra.newdream.net>
 <551C1514.3060607@ubuntu.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F28CB8270@SACMBXIP01.sdcorp.global.sandisk.com>
 <55261528.7040607@ubuntu.com>
 <9E914F5BD7F48A4782456CEB550A422824489892@SACMBXIP01.sdcorp.global.sandisk.com>
 <552FA175.2000808@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0061.outbound.protection.outlook.com ([157.56.111.61]:49433
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754543AbbDPOzp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 10:55:45 -0400
In-Reply-To: <552FA175.2000808@ubuntu.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>, Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, Sage Weil <sage@newdream.net>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks James !
We will try this out.

Regards
Somnath

-----Original Message-----
From: James Page [mailto:james.page@ubuntu.com]
Sent: Thursday, April 16, 2015 4:48 AM
To: Chaitanya Huilgol; Somnath Roy; Sage Weil; ceph-maintainers@ceph.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: tcmalloc issue

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Folks

The proposed fix is now in the 'proposed' pocket for 14.04 - see:

https://bugs.launchpad.net/ubuntu/+source/google-perftools/+bug/1439277

on how to enable that pocket for testing if you'd like to confirm that you are able to use the required feature now.

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

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

