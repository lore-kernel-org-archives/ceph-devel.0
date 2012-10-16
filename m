From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd command to display free space in a cluster ?
Date: Tue, 16 Oct 2012 15:57:51 +0200 (CEST)
Message-ID: <80dc18a4-87a6-450d-b582-f1d09da6d373@mailpro>
References: <alpine.DEB.2.00.1210150846030.3424@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:57495 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab2JPN6V convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 09:58:21 -0400
In-Reply-To: <alpine.DEB.2.00.1210150846030.3424@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Thanks Sage,

that's what I was looking for

Regards,

Alexandre


----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 15 Octobre 2012 17:46:36=20
Objet: Re: rbd command to display free space in a cluster ?=20

On Mon, 15 Oct 2012, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> I'm looking for a way to retrieve the free space from a rbd cluster w=
ith rbd command.=20
>=20
> Any hint ?=20
>=20
> (something like ceph -w status, but without need to parse the result)=
=20

rados df=20

is the closest.=20

sage=20



>=20
> Regards,=20
>=20
> Alexandre=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
