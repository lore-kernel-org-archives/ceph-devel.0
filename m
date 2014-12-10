From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: krbd blk-mq support ?
Date: Wed, 10 Dec 2014 18:15:38 +0100 (CET)
Message-ID: <2057019275.865798.1418231738426.JavaMail.zimbra@oxygem.tv>
References: <20141113071815.GA27154@infradead.org> <473f435c-e053-47b9-9061-07b44c83d5d0@mailpro> <20141210140518.GA25470@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:53863 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbaLJRPu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Dec 2014 12:15:50 -0500
In-Reply-To: <1394621476.865737.1418231736651.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Christoph,

I have redone bench, but I think I don't have enough ios/osd.

I'm stuck around 120000iops randread 4k with or without your patch.

(But I don't see any speed regression)

I'm going to have a bigger full ssd production cluster in the coming mo=
nths,
So I'll redone tests when I'll be ready.

Regards,

Alexandre
----- Mail original -----
De: "Christoph Hellwig" <hch@infradead.org>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mercredi 10 D=C3=A9cembre 2014 15:05:18
Objet: Re: krbd blk-mq support ?

On Thu, Nov 13, 2014 at 10:44:18AM +0100, Alexandre DERUMIER wrote:=20
> >>Did you manage to get those numbers?=20
>=20
> Not yet, I'll try next week.=20

What's the result? I'd really like to get rid of old request drivers=20
as much as possible.=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
