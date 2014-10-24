From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: krbd blk-mq support ?
Date: Fri, 24 Oct 2014 14:27:47 +0200 (CEST)
Message-ID: <8dd75b6c-f026-466d-baa4-fa4d11f8800a@mailpro>
References: <20141024105501.GA14699@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55365 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300AbaJXM1z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Oct 2014 08:27:55 -0400
In-Reply-To: <20141024105501.GA14699@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

>>If you're willing to experiment give the patches below a try, not tha=
t=20
>>I don't have a ceph test cluster available, so the conversion is=20
>>untestested.=20

Ok, Thanks ! I'll try them and see If I can improve qemu performance on=
 a single drive with multiqueues.

----- Mail original -----=20

De: "Christoph Hellwig" <hch@infradead.org>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Vendredi 24 Octobre 2014 12:55:01=20
Objet: Re: krbd blk-mq support ?=20

If you're willing to experiment give the patches below a try, not that=20
I don't have a ceph test cluster available, so the conversion is=20
untestested.=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
