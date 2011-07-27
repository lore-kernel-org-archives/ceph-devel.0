From: Wido den Hollander <wido@widodh.nl>
Subject: Re: About the rados check command
Date: Wed, 27 Jul 2011 09:23:11 +0200
Message-ID: <1311751391.2751.11.camel@wido-laptop.pcextreme.nl>
References: <CAAdKTP_hMHXHQgEo+aHBXoWvQME+W8iJxZHjpnhRKOoiicSTMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:41373 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab1G0HXN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 03:23:13 -0400
In-Reply-To: <CAAdKTP_hMHXHQgEo+aHBXoWvQME+W8iJxZHjpnhRKOoiicSTMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "doki74216@gmail.com" <doki74216@gmail.com>
Cc: Ceph <ceph-devel@vger.kernel.org>

On Wed, 2011-07-27 at 15:16 +0800, doki74216@gmail.com wrote:
> Dear Ceph,
>=20
> Thanks for your answer before. That let me learn more.
>=20
> Recently,I want to check the pools and the contents in the rados gate=
way.
> So I execute "rados lspools".
> Here is the massages on the screen:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [root@mon1 ~]# rados lspools
> data
> metadata
> rbd
> .rgw
> ^^^^^^^^^^^^^
> .users.uid
> .users
> .pool
> ^^^^^^^^^^^^
> .log
> test2
> test741
> test741-2
> test741-3
> test741-4
> test741-5
> test1
> doki1
> 123
> foo
> anny
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
> I am curious about the information about .rgw  .pool and .log=E3=80=82
>                                                            ^^^^^  ^^^=
^^^
> Therefore I execute "rados -p .rgw ls"
> Here is the massages:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [root@mon1 ~]# rados -p .rgw ls
> .log
> .pool
> .users
> .users.uid
> test1
> test2
> test741
> test741-2
> doki1
> test741-3
> test741-4
> test741-5
> 123
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Question(1): What is that massages that mean? What is the difference
> between the massages will be showed when I type "rados lspools"?

lspools shows you the real RADOS pools, there the pools .rgw, .pool
and .log show meta data pools of the RADOS gateway.

>=20
>=20
> When I execute "rados -p .pool ls"
> Here is the massages:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [root@mon1 ~]# rados -p .pool ls
> 10
> 11
> 13
> 14
> 15
> 17
> 18
> 19
> 20
> 21
> 6
> 12
> 9
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Question(2): What is the number mean?

These numbers correspond to pools that are created/managed by the RADOS
gateway. Try "ceph osd dump -o -", you'll see that those numbers are th=
e
ID's of pools from the RADOS gateway.

>=20
> Question(3): Likewisethe same questions above-mentioned=EF=BC=8CWhat =
is the
> messages mean when I type " rados -p .log ls" ?

The .log pool holds logs from the RADOS gateway, you can extract these
logs with the radosgw_admin tool.

Wido

>=20
> Thank you~
>=20
> Best Regards.
> Stefanie.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
