From: Sage Weil <sage@inktank.com>
Subject: Re: ceph-brag ready
Date: Sat, 15 Feb 2014 09:43:50 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402150942070.17892@cobra.newdream.net>
References: <78E29451-D203-4B1A-B825-E86894D940FB@enovance.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1293863827-1392486230=:17892"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59824 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbaBORnu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Feb 2014 12:43:50 -0500
In-Reply-To: <78E29451-D203-4B1A-B825-E86894D940FB@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1293863827-1392486230=:17892
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2014, Sebastien Han wrote:
> Hi guys,
>=20
> First implementation of the ceph-brag is ready.
> We have a public repo available here, so can try it out.
>=20
> https://github.com/enovance/ceph-brag
>=20
> However I don=92t have any idea on how to submit this to github.com/cep=
h.
> Can someone help me on that?

I'm merging this into ceph.git now (src/brag/{client, server}).  I don't=20
see Signed-off-by lines on the commits, though, or an indication of what=20
the license is.  Can you confirm whether this should be LGPL or MIT or=20
whatever?

Thanks!
sage
--557981400-1293863827-1392486230=:17892--
