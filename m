From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: reducing buffer allocations
Date: Thu, 4 Feb 2016 17:40:09 -0500
Message-ID: <20160204224009.GA22061@ultraspiritum.redhat.com>
References: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933879AbcBDWkK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Feb 2016 17:40:10 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id CCC423F3B3
	for <ceph-devel@vger.kernel.org>; Thu,  4 Feb 2016 22:40:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04/02/2016, Sage Weil wrote:
[snip]
> (2) convert buffer::list into an intrusive_list, while embedding N
> (=3D3) buffer::ptr's in the buffer::raw so that most buffers require only
> 1 allocation (provided they aren't on more than N lists).
[snip]
> Do we want both, or just 1, or is there an alternative we should
> consider?

Do we have any places in the code where we seek into a buffer::list that ha=
s a
good number of buffer::ptrs in it? If so then we could get a speedup by
switching from an intrusive list to an intrusive set (or avlset).

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWs9NCXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jwHsH/i/RbDPRkCJXMtzsYGR4Ut0k
eN7MA4XsGkCyKIqCgl7+hSOrHJhd1sLbbrCSoDBqK6AQv4R9u+nzlROJzm4SwkYO
a/w0zSiLjaF3i1xQuGBTZGZZot1o+nDEyzl9st0khT6hIyUeqk7FC/Wc3c2XQIMq
uHTkDm6xU8gTW8JR19KIZENyb1SiLQncOxpdYN0nfqVnJKibHbjX7O7yT56OTGMd
Cl4V2JGOwyRMOURivWX6yL2v9HzH9htVZgJ70uBUyxBdgPzF5VSepHCpzdfxXapK
P5IK0yVidToGMgEjZ4CAmxK/qPPyZFl4/2yPDQ4+7GkS8zFhw8DtVwy82nBnZoM=
=/aO4
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
