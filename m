From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Pool setting for recovery priority
Date: Fri, 25 Sep 2015 14:44:42 +0300
Message-ID: <20150925114440.GA30636@gmail.com>
References: <BLU175-W30B038F9EE84A31BF7D842DF5B0@phx.gbl>
 <alpine.DEB.2.00.1509160920120.14342@cobra.newdream.net>
 <20150921133218.GB23240@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:35817 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917AbbIYLoq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Sep 2015 07:44:46 -0400
Received: by lacrr8 with SMTP id rr8so16060113lac.2
        for <ceph-devel@vger.kernel.org>; Fri, 25 Sep 2015 04:44:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150921133218.GB23240@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: GuangYang <yguang11@outlook.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, David Zafman <dzafman@redhat.com>

Hi,

On Mon, Sep 21, 2015 at 04:32:19PM +0300, Mykola Golub wrote:
> On Wed, Sep 16, 2015 at 09:23:07AM -0700, Sage Weil wrote:
> > On Wed, 16 Sep 2015, GuangYang wrote:
> > > Hi Sam,
> > > As part of the effort to solve problems similar to issue #13104 (=
http://tracker.ceph.com/issues/13104), do you think it is appropriate t=
o add some parameters to pool setting:
> > > =9A =9A1. recovery priority of the pool - we have a customized po=
ol recovery priority (like process's nice value) to favor some pools ov=
er others. For example, the bucket index pool is usually much much smal=
ler but important to recover first (e.g. might affect write latency as =
like issue #13104).
> > > =9A =9A2. pool level recovery op priority - currently we have a l=
ow priority for recovery op (by default it is 10 while client io's prio=
rity is 63), is it possible to have a pool setting to customized the pr=
iority on pool level.
> > >=20
> > > The purpose is to give some flexibility in terms of favor some po=
ols over others when doing recovery, in our case using radosgw, we woul=
d like to favor bucket index pool as that is on the write path for all =
requests.
> >=20
> > I think this makes sense, and is analogous to
> >=20
> > 	https://github.com/ceph/ceph/pull/5922
> >=20
> > which does per-pool scrub settings.  I think the only real question=
 is=20
> > whether pg_pool_t is the right place to keep piling these parameter=
s in,=20
> > or whether we want some unstructured key/value settings or somethin=
g.
>=20
> I aggree that adding a bunch of new rarely used fields to pg_pool_t
> might not be a very good idea. Still storing these options here looks
> convenient (accessing, updating...). What do you think if I add
> something like this in pg_pool_t instead?
>=20
>   typedef boost::variant<string,int,double> pool_opt_value_t;
>   typedef std::map<pool_opt_key_t,pool_opt_value_t> opts_t;
>   opts_t opts;
>=20
> (in reality I suppose it will be more compicated but will have
> something like this in base).
>=20
> Usually opts will be empty or have only one or two settings, so it
> will not consume much space.

What do you think about this implementation, which adds a dictionary
for pool options to pg_pool_t?

https://github.com/ceph/ceph/pull/6081

Although #5922 has already been merged to master, I think it is still
not late to change scrub intervals to be stored in options?

>=20
> Or where do you suggest to store them instead?
>=20
> BTW, I see we already have in pg_pool_t:
>=20
>   map<string,string> properties;  ///< OBSOLETE
>=20
> I wonder what it was supposed to be used for and why it is marked
> obsolete?
>=20
> --=20
> Mykola Golub

--=20
Mykola Golub
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
