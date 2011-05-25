From: Wido den Hollander <wido@widodh.nl>
Subject: Re: fuse vs kernel client
Date: Wed, 25 May 2011 22:35:39 +0200
Message-ID: <1306355739.3556.2.camel@Nokia-N900-02-8>
References: <4DDD646E.4090105@ufm.su>
Reply-To: Wido den Hollander <wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52095 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237Ab1EYUhb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 May 2011 16:37:31 -0400
In-Reply-To: <4DDD646E.4090105@ufm.su>
Content-ID: <1306355738.3556.1.camel@Nokia-N900-02-8>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

Hi,

----- Original message -----
> Hi!
>=20
> It's me again (I feel like that I'm here soon banned :)
>=20
> ceph have fuse client and kernel client.
>=20
> Why are two of them?

The kernel client runs as a kernel module and will generaly give you mo=
re performance en functionality, but it in some situations you might wa=
nt to run the user-space FUSE client.

If the kernel client crashes you'll end up with a kernel panic and you =
also need root privs.

> Which is better?

That is up to you, but I prefer the kernel client, I think most users d=
o.

The FUSE client is useful for fast and simple testing though.

Wido

>=20
> WBR,
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0  http://vger.kernel.org/majordomo-info.h=
tml

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
