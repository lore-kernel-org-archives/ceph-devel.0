From: Wido den Hollander <wido@42on.com>
Subject: Re: rads gateway Parallel Uploads
Date: Mon, 13 Jul 2015 08:16:03 +0200
Message-ID: <55A357A3.7060002@42on.com>
References: <0142046B-030E-4E7D-96FB-C7C519E4B0FC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:47297 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbbGMGPv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Jul 2015 02:15:51 -0400
In-Reply-To: <0142046B-030E-4E7D-96FB-C7C519E4B0FC@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?546LIOWBpQ==?= <jason.jianwang@gmail.com>, ceph-devel@vger.kernel.org



On 13-07-15 08:07, =E7=8E=8B =E5=81=A5 wrote:
> Hello Cepher,
> I am working on prorting Google Cloud Storage API to rados gateway an=
d I notice that Google Cloud Storage support parallel uploads as below:
> "Object composition enables a simple mechanism for uploading an objec=
t in parallel: simply divide your data into as many chunks as required =
to fully utilize your available bandwidth, upload each chunk to a disti=
nct object, compose your final object, and delete any temporary objects=
=2E =E2=80=9C
> So I am wondering whether radios gateway support the similar feature =
to let user parallel upload large objects?

Yes, you can do a multipart upload with the RADOS gateway, no problem.

Wido

> Thanks
> Jian
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
