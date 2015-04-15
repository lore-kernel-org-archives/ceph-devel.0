From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: how to test hammer rbd objectmap feature ?
Date: Wed, 15 Apr 2015 08:18:51 +0200 (CEST)
Message-ID: <1767564931.287714245.1429078731548.JavaMail.zimbra@oxygem.tv>
References: <2146461277.257952132.1428997703232.JavaMail.zimbra@oxygem.tv> <552D9EE6.2080003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:51868 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964799AbbDOGSy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 02:18:54 -0400
In-Reply-To: <552D9EE6.2080003@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>>Yeah, once we're confident in it in master. The idea behind this=20
>>feature was to allow using object maps with existing images. There=20
>>just wasn't time to include it in the base hammer release.=20

Ok, thanks Josh !

(I'm planning to implement this feature in proxmox when it'll be releas=
ed).


----- Mail original -----
De: "Josh Durgin" <jdurgin@redhat.com>
=C3=80: "aderumier" <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vge=
r.kernel.org>
Envoy=C3=A9: Mercredi 15 Avril 2015 01:12:38
Objet: Re: how to test hammer rbd objectmap feature ?

On 04/14/2015 12:48 AM, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> I would like to known how to enable object map on hammer ?=20
>=20
> I found a post hammer commit here:=20
>=20
> https://github.com/ceph/ceph/commit/3a7b28d9a2de365d515ea1380ee9e4f86=
7504e10=20
> "rbd: add feature enable/disable support"=20
>=20
> - Specifies which RBD format 2 features are to be enabled when creati=
ng=20
> - an image. The numbers from the desired features below should be add=
ed=20
> - to compute the parameter value:=20
> + Specifies which RBD format 2 feature should be enabled when creatin=
g=20
> + an image. Multiple features can be enabled by repeating this option=
=20
> + multiple times. The following features are supported:=20
>=20
> -.. option:: --image-features features=20
> +.. option:: --image-feature feature=20
>=20
> - +1: layering support=20
> - +2: striping v2 support=20
> - +4: exclusive locking support=20
> - +8: object map support=20
> + layering: layering support=20
> + striping: striping v2 support=20
> + exclusive-lock: exclusive locking support=20
> + object-map: object map support (requires exclusive-lock)=20
>=20
>=20
> So, in current hammer release, we can only setup objectmap and other =
features on rbd volume creation ?=20

Yes, that's right.=20

> Do this patch allow to change features on the fly ?=20

Yup, just for exclusive-lock and object map (since they don't=20
affect object layout).=20

> If yes, is it planned to backport it to hammer soon ?=20

Yeah, once we're confident in it in master. The idea behind this=20
feature was to allow using object maps with existing images. There=20
just wasn't time to include it in the base hammer release.=20

Josh=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
