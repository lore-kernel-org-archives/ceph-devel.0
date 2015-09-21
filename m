From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Pool setting for recovery priority
Date: Mon, 21 Sep 2015 16:32:19 +0300
Message-ID: <20150921133218.GB23240@gmail.com>
References: <BLU175-W30B038F9EE84A31BF7D842DF5B0@phx.gbl>
 <alpine.DEB.2.00.1509160920120.14342@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38721 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291AbbIUNcW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Sep 2015 09:32:22 -0400
Received: by wiclk2 with SMTP id lk2so111818843wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 21 Sep 2015 06:32:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1509160920120.14342@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: GuangYang <yguang11@outlook.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Sep 16, 2015 at 09:23:07AM -0700, Sage Weil wrote:
> On Wed, 16 Sep 2015, GuangYang wrote:
> > Hi Sam,
> > As part of the effort to solve problems similar to issue #13104 (ht=
tp://tracker.ceph.com/issues/13104), do you think it is appropriate to =
add some parameters to pool setting:
> > =9A =9A1. recovery priority of the pool - we have a customized pool=
 recovery priority (like process's nice value) to favor some pools over=
 others. For example, the bucket index pool is usually much much smalle=
r but important to recover first (e.g. might affect write latency as li=
ke issue #13104).
> > =9A =9A2. pool level recovery op priority - currently we have a low=
 priority for recovery op (by default it is 10 while client io's priori=
ty is 63), is it possible to have a pool setting to customized the prio=
rity on pool level.
> >=20
> > The purpose is to give some flexibility in terms of favor some pool=
s over others when doing recovery, in our case using radosgw, we would =
like to favor bucket index pool as that is on the write path for all re=
quests.
>=20
> I think this makes sense, and is analogous to
>=20
> 	https://github.com/ceph/ceph/pull/5922
>=20
> which does per-pool scrub settings.  I think the only real question i=
s=20
> whether pg_pool_t is the right place to keep piling these parameters =
in,=20
> or whether we want some unstructured key/value settings or something.

I aggree that adding a bunch of new rarely used fields to pg_pool_t
might not be a very good idea. Still storing these options here looks
convenient (accessing, updating...). What do you think if I add
something like this in pg_pool_t instead?

  typedef boost::variant<string,int,double> pool_opt_value_t;
  typedef std::map<pool_opt_key_t,pool_opt_value_t> opts_t;
  opts_t opts;

(in reality I suppose it will be more compicated but will have
something like this in base).

Usually opts will be empty or have only one or two settings, so it
will not consume much space.

Or where do you suggest to store them instead?

BTW, I see we already have in pg_pool_t:

  map<string,string> properties;  ///< OBSOLETE

I wonder what it was supposed to be used for and why it is marked
obsolete?

--=20
Mykola Golub
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
