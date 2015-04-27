From: Herve Rousseau <hroussea@cern.ch>
Subject: Re: [PATCH] Swift: Set Content-Length when requesting/checking
 Keystone tokens
Date: Mon, 27 Apr 2015 08:38:51 +0200
Message-ID: <20150427063851.GA14185@adm01>
References: <1429979938-18465-1-git-send-email-hroussea@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx0.moulticast.net ([185.16.173.236]:5514 "EHLO
	mx.moulticast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbbD0Gpg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 02:45:36 -0400
Received: by mx0.moulticast.net (OpenSMTPD) with ESMTPSA id 5c961611;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
	for <ceph-devel@vger.kernel.org>;
	Mon, 27 Apr 2015 08:38:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1429979938-18465-1-git-send-email-hroussea@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 25/04/15 18:38 +0200, Herve Rousseau wrote:
> From: Herv=C3=A9 Rousseau <hroussea@cern.ch>
>=20
> Running Keystone with WSGIChunkedRequest=3DOn is not supported.
>=20
> We have to make sure that we set the Content-Length header when getti=
ng
> an admin token and checking revoked tokens, otherwise Keystone return=
s
> a HTTP 411 error.
>=20
> Same applies when checking revoked tickets.
>=20
> Signed-off-by: Herv=C3=A9 Rousseau <hroussea@cern.ch>

[snip]

Hi all,

We identified this issue when doing some integration tests with Keyston=
e and
user/password authentication instead of using the admin token, it's rel=
ated
to http://tracker.ceph.com/issues/7796.

We followed the aforementioned bug report and directives but then keyst=
one
wouldn't work because they won't support Chunked encoding as their docu=
mentation
now reflects:=20
 https://git.openstack.org/cgit/openstack/keystone/commit/?id=3D05c01e2=
6d1e62298489ba3894576faf3c352e2c9

Cheers,=20

--=20
Herv=C3=A9 Rousseau
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
