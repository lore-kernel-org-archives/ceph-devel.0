From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: some snapshot problems
Date: Fri, 9 Nov 2012 21:32:38 +0000
Message-ID: <20121109213238.fb1049a8.ctpm@ist.utl.pt>
References: <CABFZihudrA640nD9N60b8w0ccQvmaduGmceBf2uHrpLbShtjig@mail.gmail.com>
	<alpine.DEB.2.00.1211050139280.14104@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ist.utl.pt ([193.136.128.22]:58987 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714Ab2KIVcm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Nov 2012 16:32:42 -0500
In-Reply-To: <alpine.DEB.2.00.1211050139280.14104@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: liu yaqi <liuyaqiyaqi@gmail.com>, ceph-devel@vger.kernel.org


On Thu, 8 Nov 2012 09:30:55 -0800 (PST) Sage Weil <sage@inktank.com> wr=
ote:
> Lots of different snapshots:
>=20
>  - librados lets you do 'selfmanaged snaps' in its API, which let an=20
>    application control which snapshots apply to which objects.=20
>  - you can create a 'pool' snapshot on an entire librados pool.  this=
=20
>    cannot be used at the same time as rbd, fs, or the above 'selfmana=
ged'=20
>    snaps.

 Could you please clarify this? You mean that if a given pool has a
snapshot created, a subsequent 'rbd snap create' on an image placed in
that very same pool would fail?

 A quick search through the RADOS and RBD documentation didn't turn
anything up about this restriction, but I apologize if I missed it.

 Thanks

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
