From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: radosgw-admin list users?
Date: Thu, 18 Sep 2014 17:27:46 +0000
Message-ID: <robbat2-20140918T171125-842049841Z@orbis-terrarum.net>
References: <1464A418-AB3C-46C6-8D20-8FA796538A62@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:53991 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932117AbaIRR2B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Sep 2014 13:28:01 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id D896F340278
	for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 17:27:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1464A418-AB3C-46C6-8D20-8FA796538A62@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Related to this thread, radosgw-admin doesn't seem to have anything to
list the users.

The closest I have as a hack is:
rados ls --pool=3D.users.uid |sed 's,.buckets$,,g' |sort |uniq

But this does require internal knowledge of how it's stored, and I don'=
t
want to rely on it.

On Thu, Sep 18, 2014 at 03:53:27PM +0800,  Zhao zhiming wrote:
> HI ALL,
> 	I know radosgw-admin can delete one user with command =E2=80=98rados=
gw-admin user rm uid=3Dxxx=E2=80=99, I want to know have some commands =
to delete multiple or all users?
>=20
> thanks. --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
