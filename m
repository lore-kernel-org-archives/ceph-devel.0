From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Hammer vs Jewel librbd performance testing and git bisection
 results
Date: Wed, 11 May 2016 09:49:20 -0400 (EDT)
Message-ID: <751229226.29976609.1462974560840.JavaMail.zimbra@redhat.com>
References: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com> <20160511133504.GB6902@predictor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:45309 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbcEKNtY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 09:49:24 -0400
In-Reply-To: <20160511133504.GB6902@predictor>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Piotr =?utf-8?Q?Da=C5=82ek?= <branch@predictor.org.pl>
Cc: ceph-devel@vger.kernel.org

Hi,

----- Original Message -----
> From: "Piotr Da=C5=82ek" <branch@predictor.org.pl>
> To: ceph-devel@vger.kernel.org
> Sent: Wednesday, May 11, 2016 9:35:04 AM
> Subject: Re: Hammer vs Jewel librbd performance testing and git bisec=
tion results
>=20
syNM5pr-ZwBuR7lqnphEd-4kQUid0C9eRyta3ohOA/edit?usp=3Dsharing
> >=20
> > There are several commits of interest that have a noticeable effect
> > on 128K sequential read performance:
> >=20
> > [..]
> > 2) https://github.com/ceph/ceph/commit/c474ee42
> >=20
> > This commit had a very large impact, reducing performance by anothe=
r
> > 20-25%.
>=20
> https://github.com/ceph/ceph/commit/c474ee42#diff-254555dde8dcfb7fb90=
8791ab8214b92R318
> I would check if temporarily forcing unique_lock_name() to return its=
 arg
> (or other constant) would change things. If so, probably a more effic=
ient way
> to construct unique lock name may be in order.

++

Naively, too, what unique_lock_name is doing amounts to:  1) creating e=
xtra of [a small] std::string [better fixed, but not a likely root caus=
e?] 2) using Utils::stringify to hook ostream operators in the type pas=
sed in, and doing that on a new sstream;

Maybe we should look horizontally at either speeding up or finding alte=
rnatives to stringify in other places?

Matt

>=20
> --
> Piotr Da=C5=82ek


--=20
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
