From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: OSD deadlock with cephfs client and OSD on same machine
Date: Mon, 5 Nov 2012 20:17:30 +0000
Message-ID: <20121105201730.723eb457.ctpm@ist.utl.pt>
References: <201205290944.33983.a.ott@m-privacy.de>
	<Pine.LNX.4.64.1205290836350.14433@cobra.newdream.net>
	<201205300908.56991.a.ott@m-privacy.de>
	<201206011135.38119.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.ist.utl.pt ([193.136.128.21]:37641 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642Ab2KEURd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Nov 2012 15:17:33 -0500
In-Reply-To: <201206011135.38119.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org


On Fri, 1 Jun 2012 11:35:37 +0200 Amon Ott <a.ott@m-privacy.de> wrote:
>=20
> After backporting syncfs() support into Debian stable libc6 2.11 and=20
> recompiling Ceph with it, our test cluster is now running with syncfs=
().
>=20

 Hi,

 We're running OSDs on top of Debian wheezy, which unfortunately has
libc6 2.13. By chance, do you still have that patch to backport syncfs(=
)?

 Thanks in advance

Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
