From: =?ISO-8859-1?Q?Beno=EEt=20Canet?= <benoit.canet@nodalink.com>
Subject: Re: Inline dedup/compression
Date: Fri, 26 Jun 2015 01:00:48 +0200
Message-ID: <1435273248.3286199.307958545.50866BEC@webmail.messagingengine.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:43641 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751507AbbFYXGk convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Jun 2015 19:06:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 86C9913AC
	for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 19:00:48 -0400 (EDT)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Liu-SSI <james.liu@ssi.samsung.com>, ceph-devel <ceph-devel@vger.kernel.org>


Le Ven 26 juin 2015, =E0 00:01, James (Fei) Liu-SSI a =E9crit :
> Hi Cephers,
>     It is not easy to ask when Ceph is going to support inline
>     dedup/compression across OSDs in RADOS.

disclamer: I am not a Cepher.

This would mean some kind of distributed key value store that is fast
enough   =20
to deliver one query by written object or a kind of distributed in ram
lru hash=20
table in order to optimistically identify the hottest objects.         =
 =20
(The one that are identical and get written the most often)            =
 =20
                                                                       =
        =20
I am more used to block devices so I don't realise how many different
objects  =20
per second get written on disk on a ceph setup.                        =
 =20
                                                                       =
        =20
I don't see how it would cope with partial writes.                     =
 =20
                                                                       =
        =20
If you need speed like in a block device setup you can forget anything
B-TREE to
implement the key-value store because it's O(log n).                   =
 =20
                                                                       =
        =20
So you are left with solutions like SILT that will eat some RAM and beg
you    =20
for an SSD in exchange of O(1+Epsilon) lookups.(Probably good for
Samsung ;)                                =20
See https://www.cs.cmu.edu/~dga/papers/silt-sosp2011.pdf               =
 =20

=46rom my experience with block device setup deduplication is very
demanding to  =20
the key/value store. Maybe with only complete write on big objects this
problem
would disappear.

Best regards

Beno=EEt


> because it is not easy task
>     and answered. Ceph is providing replication and EC for performanc=
e
>     and failure recovery. But we also lose the efficiency  of storage
>     store and cost associate with it. It is kind of contradicted with
>     each other. But I am curious how other Cephers think about this
>     question.
>    Any plan for Cephers to do anything regarding to inline
>    dedupe/compression except the features brought by local node itsel=
f
>    like BRTFS?   =20
>=20
>   Regards,
>   James
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
