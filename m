From: James Page <james.page@ubuntu.com>
Subject: Re: Ceph Upstream Tarball + Re: Ceph status for Wheezy
Date: Thu, 12 Jul 2012 11:38:08 +0100
Message-ID: <4FFEA910.6000407@ubuntu.com>
References: <4FFC44BE.6090505@ubuntu.com> <1341966632.12180.22.camel@julia>  <4FFD40DA.7020408@ubuntu.com> <1342042993.12180.98.camel@julia>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:32988 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933641Ab2GLKiK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 06:38:10 -0400
In-Reply-To: <1342042993.12180.98.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Laszlo

On 11/07/12 22:43, Laszlo Boszormenyi (GCS) wrote:
>>> I'm hoping to get to a point where the packaging is the same;
>>> if nothing else it saves extra work!
> Sure, that would be better. I've a package of v0.48 ready to
> upload[2], but can wait some days if you would like to check what I
> may need to merge from your package.

The only thing I can see that makes sense ATM would be the split out
of ceph-mds and ceph-fs-common packages as has been done in Ubuntu and
upstream.  This would help minimise the delta right now.

Would this present and problem considering that Wheezy is now frozen?

Also how are you tracking upstream packaging changes into the Debian
packages?  I think it would be nice to agree a workflow Upstream ->
Debian -> Ubuntu if one is not already in place.

I'll hold off doing anything with 0.48 in Ubuntu until we figure out
what's happening in Debian.

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJP/qkQAAoJEL/srsug59jDa1AQAIXqhP7fKOPwWIp/aIqQ7PED
707fmS9mErOE2tqnzHTVpI7G+c0zTEhY0nkZZqPW9Yc92n8OXiIWOVFSi4n5v6Iz
xF3MX9L8DPcgKnOkOWPWT/Nxl0wVNc8kZxJVJ2pI224s/pA9kbDbq7ZnT6/JwRtu
R49B5qjSPTF2gs5CvjvqU6+GtBQoB2/mn9Ym9AVU1C3CRxtbUHPGJhNr2KIZYBbo
O2oo854LbcY4Bw3QknCStjw0Lk0KS/nOe7yaVE+Ql1LQw6btj89FW/lAitiF4Dbl
SsFmSpc1Xk3t/xBTqyvkuY/Nuu98fbC8fGKw16bNWfv8JP3QEWFcIvZ0b1o8d+HW
hSulu6WB42IyI8pHUCjFCX8rFwnFZs/D1pw52aC39BbadlGWrWs5X0zRg65GqmU/
Gmn1gMSiZYzCsR+5sx9QKdeWuw/i6Y+HU3SmBZ4EeiVjMPieDMt0Zd7Boz7EwTwv
T56+eC7M6w9ovd6JRVqlW6cFBfptC2fwbqLNoYuNmoNTgZJlVe3YEDFLdcwVBifL
16DzwfSPoVD4jsg8wwFczb/Xl80DIm4+PvWbE+MXgTzIyXJLEP035Rs9cFcQJ4P2
rD9ZjVwAA+AuM3Ux5Zwj241ezTC5ZVdRxZiYk4z9ohTC4tnmuaaRHC0F7DCbI3JJ
QacNS8xm5LgjFY5hNFmF
=TNFi
-----END PGP SIGNATURE-----
