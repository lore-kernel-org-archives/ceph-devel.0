From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: master build failure with boost 1.60
Date: Tue, 8 Mar 2016 13:49:40 -0700
Message-ID: <CAANLjFq3bC+-3LZ4PzyqY5W5pSfHGVQp=BAW986M67P2g8K+dA@mail.gmail.com>
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35454 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbcCHUtm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2016 15:49:42 -0500
Received: by mail-vk0-f45.google.com with SMTP id e6so32114821vkh.2
        for <ceph-devel@vger.kernel.org>; Tue, 08 Mar 2016 12:49:40 -0800 (PST)
In-Reply-To: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Karol Mroz <kmroz@suse.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Karol,

I think I may have already resolved this with a patch I was already
working on. Can you pull in https://github.com/ceph/ceph/pull/7984 and
see if it resolves the issue?

Thanks,
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.6
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJW3zreCRDmVDuy+mK58QAAiX0P/RB6HZOaBiDkh89z37wf
LG+sMH84PigUiGQ/dW4NpPC96pBfpOeKYxU0ZFjV1A2jkfjGxKsqNr6gSioE
wnaN8u5emoND5nb/O4psm+9EQguLcSsfLVvt+1JCOUMdRibrZVfBsjJ1hfhu
rE6exUGmabR+sTgC0fL2Rd00+FLN4SeqYiEkH/YhRMPoX7sNAgrwlj6z2N7E
nS8aUZTZVzHxoWh+QwLdKuE6QSd8EPh9L2BQhqjrhERPh4SyG5XfK97p77O+
dSOiAYx1Ecz1qjHQEI6Ml5pPAKTqJSEhFOgDdDguYzN1E+uBb8eJSB0ZB6M3
hPbuEKIg/nVa06LL2ZMgRpkC327xjtPnSsExDGfR4fEN9zv3TCMmJ9X+YDrS
dAKItZCss64CXOWATHhx1LKBHusl4Cu9y8EZL80/coKJuqfQs0OCnjmGoxHF
xwqp7AaiKu5jh6sNRT/VbJxvuWTz9/G5iznjphXyk/zVeit5SYjK5HozIC6y
em7H+kcQJl/JluA82bixtM5j+o+kcx9h3Jxbymf2g6XlFQMSQ6V3l3N/AO79
yXXpiBUrRInP8YzQvCjPLREPWPQTSadRdAUfaE4NSu9ZC9/TtoTyrf0NutUT
/qUfEXCOQJSNuXIelo1Fp0WKCgE31zPcgGnBroejTZs+A5LlMzWLcsKZaKh0
qIzs
=xE7o
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Mar 7, 2016 at 7:49 AM, Karol Mroz <kmroz@suse.com> wrote:
> Hi folks,
>
> We've recently hit a build failure on ceph master for which Abhishek has opened
> a bug: http://tracker.ceph.com/issues/14998.
>
> Our rolling distribution (openSUSE Tumbleweed) has pushed out boost 1.60
> which looks to be at the heart of the failure. Is boost 1.60 to be supported in
> Jewel?
>
> Thanks!
>
> --
> Regards,
> Karol
