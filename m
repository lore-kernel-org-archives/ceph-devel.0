From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: krbd blk-mq support ?
Date: Thu, 13 Nov 2014 10:44:18 +0100 (CET)
Message-ID: <473f435c-e053-47b9-9061-07b44c83d5d0@mailpro>
References: <20141113071815.GA27154@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:37366 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136AbaKMJo1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 04:44:27 -0500
In-Reply-To: <20141113071815.GA27154@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

>>Did you manage to get those numbers?=20

Not yet, I'll try next week.


----- Mail original -----=20

De: "Christoph Hellwig" <hch@infradead.org>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Jeudi 13 Novembre 2014 08:18:15=20
Objet: Re: krbd blk-mq support ?=20

On Tue, Nov 04, 2014 at 08:19:32AM +0100, Alexandre DERUMIER wrote:=20
> Now : 3.18 kernel + your patch : 120000 iops=20
> 3.10 kernel : 80000iops=20
>=20
>=20
> I'll try 3.18 kernel without your patch to compare.=20

Did you manage to get those numbers?=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
