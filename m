From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: How to submit PATCH to ceph ?
Date: Thu, 16 Dec 2010 09:19:00 +0800
Message-ID: <1292462340.2484.26.camel@cephhost>
References: <1292382033.2484.20.camel@cephhost>
	 <Pine.LNX.4.64.1012142124300.564@cobra.newdream.net>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:11667 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752812Ab0LPBRP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Dec 2010 20:17:15 -0500
In-Reply-To: <Pine.LNX.4.64.1012142124300.564@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



=E5=9C=A8 2010-12-15=E4=B8=89=E7=9A=84 13:25 +0800=EF=BC=8CSage Weil=E5=
=86=99=E9=81=93=EF=BC=9A
> Hi Jeff,
>=20
> On Wed, 15 Dec 2010, Jeff Wu wrote:
> > If we fixed some bugs of ceph and ceph-client-standalone,
> > How do we submit the PATCH to ceph.git and ceph-client-standalone.g=
it ?
> > Need we register a user at http://ceph.newdream.net ?
> >=20
> > Could anybody tell me the detail steps ?
>=20
> The -standalone.git is actually generated automatically based on=20
> ceph-client.git (which has the full kernel tree).  Sending patches ba=
sed=20
> on that code is definitely preferred.
>=20
> If you have found/fixed a bug, though, don't hesitate to send whateve=
r you=20
> have!
>=20
Hi ,sage,
thanks.

> Thanks-
> sage
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
