From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Hammer vs Jewel librbd performance testing and git bisection
 results
Date: Wed, 11 May 2016 17:22:32 +0200
Message-ID: <20160511152232.GC6902@predictor>
References: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com>
 <20160511133504.GB6902@predictor>
 <751229226.29976609.1462974560840.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:52842 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932181AbcEKPU1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2016 11:20:27 -0400
Content-Disposition: inline
In-Reply-To: <751229226.29976609.1462974560840.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Wed, May 11, 2016 at 09:49:20AM -0400, Matt Benjamin wrote:
> > > syNM5pr-ZwBuR7lqnphEd-4kQUid0C9eRyta3ohOA/edit?usp=3Dsharing
> > >=20
> > > There are several commits of interest that have a noticeable effe=
ct
> > > on 128K sequential read performance:
> > >=20
> > > [..]
> > > 2) https://github.com/ceph/ceph/commit/c474ee42
> > >=20
> > > This commit had a very large impact, reducing performance by anot=
her
> > > 20-25%.
> >=20
> > https://github.com/ceph/ceph/commit/c474ee42#diff-254555dde8dcfb7fb=
908791ab8214b92R318
> > I would check if temporarily forcing unique_lock_name() to return i=
ts arg
> > (or other constant) would change things. If so, probably a more eff=
icient way
> > to construct unique lock name may be in order.
>=20
> ++
>=20
> Naively, too, what unique_lock_name is doing amounts to:  1) creating=
 extra of [a small] std::string [better fixed, but not a likely root ca=
use?] 2) using Utils::stringify to hook ostream operators in the type p=
assed in, and doing that on a new sstream;
=20
I don't thing "stringify" alone is a source of problems. This looks lik=
e a
convenience function to make object dumping easier, so no real point in
changing it, rather than that...

> Maybe we should look horizontally at either speeding up or finding al=
ternatives to stringify in other places?

=2E.. it's usage should be limited to non-performance-critical paths.
In this particular case, probably checking for lockdep and refusing to =
act=20
when it is disabled sounds like the least intrusive way to fix
things.

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
