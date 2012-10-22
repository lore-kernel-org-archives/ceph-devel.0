From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd export to stdout ?
Date: Mon, 22 Oct 2012 14:25:33 +0200 (CEST)
Message-ID: <082fc1f4-4556-4c10-b9cc-4b8d3b0c7cbd@mailpro>
References: <508534F0.5080107@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:33986 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2JVM0D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 08:26:03 -0400
In-Reply-To: <508534F0.5080107@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

ok,=20
thanks Wido.

Regards,

Alexandre

----- Mail original -----=20

De: "Wido den Hollander" <wido@widodh.nl>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 22 Octobre 2012 13:58:40=20
Objet: Re: rbd export to stdout ?=20

On 10/22/2012 12:41 PM, Alexandre DERUMIER wrote:=20
> Hi,=20
>=20
> I'm looking for use "rbd export " to stdout and not a file.=20
>=20
> Is it possible ? any hint ?=20
>=20

No, not at this moment. I tried a fifo, but that won't work due to=20
O_EXCL and O_CREATE the rbd command uses.=20

I think it should be possible to export to stdout, but it will require=20
some code changes.=20

I created a feature request for it: http://tracker.newdream.net/issues/=
3380=20

Wido=20

> Regards,=20
>=20
> Alexandre Derumier=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
