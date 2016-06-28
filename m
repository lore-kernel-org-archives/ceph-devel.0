From: Jeff Layton <jlayton@redhat.com>
Subject: Re: is the renewal in dentry_lease_is_valid necessary?
Date: Tue, 28 Jun 2016 10:00:56 -0400
Message-ID: <1467122456.32374.15.camel@redhat.com>
References: <1467054441.25213.20.camel@redhat.com>
	 <CAAM7YAm7qHJkKjXSiG2bz-D04uNVJTbDw4XbvZ9mnU==u9eT2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33832 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbcF1OJF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 10:09:05 -0400
Received: by mail-qk0-f180.google.com with SMTP id t127so30891384qkf.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 07:09:04 -0700 (PDT)
In-Reply-To: <CAAM7YAm7qHJkKjXSiG2bz-D04uNVJTbDw4XbvZ9mnU==u9eT2Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Zheng Yan <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 2016-06-28 at 21:03 +0800, Yan, Zheng wrote:
> On Tue, Jun 28, 2016 at 3:07 AM, Jeff Layton <jlayton@redhat.com> wro=
te:
> >=20
> > I'm eyeballing how to make ceph dentry revalidation occur in rcu-wa=
lk
> > mode in the kernel cephfs client. It looks fairly straightforward, =
but
> > for one thing:
> >=20
> > dentry_lease_is_valid queues an asynchronous lease renewal if we're
> > halfway to the next lease renewal time:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (session) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ceph_mdsc_lease_send_msg(session, dir, dentr=
y,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CEPH_MDS_LEASE_RENEW, seq);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ceph_put_mds_session(session);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > That can sleep, so we have to drop out of rcu walk mode in that cas=
e.
> >=20
> > Is this lease renewal strictly necessary? I can make the code drop =
out
> > of rcuwalk mode and try again in that case, but if this is just an
> > opportunistic thing, then it may be better for performance to take =
a
> > pass on renewing the lease early if we're still in RCU walk mode.
> >=20
> dentry_lease_is_valid is the only place that renew lease. I think it'=
s
> better to drop out of rcuwalk and try again
>=20
> Regards
> Yan, Zheng
>=20

That seems really odd to me.

That call is only ever done in the d_revalidate codepath, so you'll
only get a lease renewal when you have repeated path-based access to an
existing dentry.

Maybe this means that I don't really understand ceph leases. More
questions...

What exactly does the lease cover here?

Shouldn't we be renewing it even if we're _not_ doing any path-based
access? For instance, if I open a file and issue reads and writes
against it, that doesn't involve pathnames and the lease doesn't get an
explicit renewal. Doesn't it still need to be renewed though?

--=20
Jeff Layton <jlayton@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
