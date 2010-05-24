From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Mon, 24 May 2010 13:07:47 +0100
Message-ID: <20100524130747.a33910b5.ctpm@ist.utl.pt>
References: <20100519192222.GD61706@ncolin.muc.de>
	<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>
	<4BF5A9D2.5080609@codemonkey.ws>
	<4BF91937.2070801@redhat.com>
	<87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>
	<4BFA5D96.3030603@redhat.com>
	<lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>
	<4BFA696D.2060606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.ist.utl.pt ([193.136.128.21]:60423 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390Ab0EXMHv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 May 2010 08:07:51 -0400
In-Reply-To: <4BFA696D.2060606@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, Anthony Liguori <anthony@codemonkey.ws>, Christian Brunner <chb@muc.de>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org


On Mon, 24 May 2010 14:56:29 +0300 Avi Kivity <avi@redhat.com> wrote:
> On 05/24/2010 02:42 PM, MORITA Kazutaka wrote:
> >
> >> The server would be local and talk over a unix domain socket, perh=
aps
> >> anonymous.
> >>
> >> nbd has other issues though, such as requiring a copy and no suppo=
rt for
> >> metadata operations such as snapshot and file size extension.
> >>
> >>     =20
> > Sorry, my explanation was unclear.  I'm not sure how running server=
s
> > on localhost can solve the problem.
> >   =20
>=20
> The local server can convert from the local (nbd) protocol to the rem=
ote=20
> (sheepdog, ceph) protocol.
>=20

 Please note that this shouldn't be relevant to the block driver based
on ceph, as it does not use a local daemon -- it connects to the Object
Storage Devices directly over the network.

 Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
