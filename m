From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: ceph performance call:  buffer
Date: Thu, 16 Oct 2014 14:42:27 -0400 (EDT)
Message-ID: <1251350300.123.1413484947475.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <54400C8C.8050006@dachary.org>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4678 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbaJPSnd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 14:43:33 -0400
In-Reply-To: <54400C8C.8050006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Casey Bodley <casey@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>

Ack, very interested in that :).

Matt

----- "Loic Dachary" <loic@dachary.org> wrote:

> Hi Again,
>=20
> On 16/10/2014 11:16, Loic Dachary wrote:
> > Hi Matt,
> >=20
> > You will probably be interested in
>=20
> (I have to find which sequence of keys send out the mail by
> accident... :-)
>=20
> https://github.com/ceph/ceph/pull/2595
>=20
> and
>=20
> https://github.com/dachary/ceph/commit/734e555c640a3b5e9bbf0329bd524c=
ffaca61c4f
>=20
> in particular. It does not do anything performance wise but it's goin=
g
> to be merged in the not-to-distant future.
>=20
> Cheers
>=20
> >=20
> > On 16/10/2014 11:00, Matt W. Benjamin wrote:
> >> Hi Folks,
> >>
> >> Per yesterday's Ceph performance call, we've pushed 2 wip branches
> for review and feedback to
> https://github.com/linuxbox2/linuxbox-ceph.git .
> >>
> >> 1. xio-v084-inline reorganizes ceph::buffer as a namespace, and
> (nearly) all of
> >> buffer::hash, buffer::ptr and buffer::list as inline
> >>
> >> 2. xio-v084-inline-flat restores some raw encapsulation lost in th=
e
> prior change,
> >> then refactors buffer::raw to remove virtual methods
> >>
> >> We've made some effort to measure the impact of the changes, but
> don't have
> >> reliable data yet.  (It's possible that our initial impression of
> improvement from the inlining change was not accurate, but more likel=
y
> we need better workload tests.)
> >>
> >> In addition, we've been working on an experiment to refactor
> buffer::ptr and buffer::raw to use boost::intrusive::list, to unify
> the interfaces of the two types to permit interning buffer::raw
> directly on the containing list when there is no sharing, and a slab
> allocator for both types.  We plan to push a wip branch with these
> changes to when they've stabilized a bit more and/or we have real per=
f
> numbers.
> >>
> >> Thanks,
> >>
> >> Matt
> >>
> >=20
>=20
> --=20
> Lo=C3=AFc Dachary, Artisan Logiciel Libre

--=20
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
