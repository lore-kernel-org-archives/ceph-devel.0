From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: krbd blk-mq support ?
Date: Fri, 31 Oct 2014 21:12:53 +0100 (CET)
Message-ID: <aadb2941-2e45-4ecd-ad2f-eb32d3ece64c@mailpro>
References: <90C9DE11-CACE-4533-83EF-6F1F887E6A8F@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:47217 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757236AbaJaUNB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Oct 2014 16:13:01 -0400
In-Reply-To: <90C9DE11-CACE-4533-83EF-6F1F887E6A8F@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Haomai Wang <haomaiwang@gmail.com>, Sage Weil <sage@newdream.net>, Christoph Hellwig <hch@infradead.org>, Ceph Devel <ceph-devel@vger.kernel.org>

>>filestore_xattr_use_omap ?=20

Oh, I think it's a mistake (Just copy paste some configs from sommath).
But I'm using xfs, so I don't think I need it




=09

----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Haomai Wang" <haomaiwang@gmail.com>, "Sage Weil" <sage@newdream.ne=
t>, "Christoph Hellwig" <hch@infradead.org>, "Ceph Devel" <ceph-devel@v=
ger.kernel.org>=20
Envoy=C3=A9: Vendredi 31 Octobre 2014 06:39:22=20
Objet: Re: krbd blk-mq support ?=20


Hi,=20


why do you use=20


filestore_xattr_use_omap ?=20

Stefan=20


Excuse my typo s ent from my mobile phone.=20

Am 31.10.2014 um 06:04 schrieb Alexandre DERUMIER < aderumier@odiso.com=
 >:=20



filestore_xattr_use_omap=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
