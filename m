From: Jeff Layton <jlayton@redhat.com>
Subject: Re: is the renewal in dentry_lease_is_valid necessary?
Date: Wed, 29 Jun 2016 08:25:00 -0400
Message-ID: <1467203100.6220.2.camel@redhat.com>
References: <1467054441.25213.20.camel@redhat.com>
	 <CAAM7YAm7qHJkKjXSiG2bz-D04uNVJTbDw4XbvZ9mnU==u9eT2Q@mail.gmail.com>
	 <1467122456.32374.15.camel@redhat.com>
	 <B36A9223-ECDA-4B6A-90BE-34CEE6C753C2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35753 "EHLO
	mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbcF2MZE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 08:25:04 -0400
Received: by mail-qt0-f178.google.com with SMTP id f89so23882678qtd.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2016 05:25:03 -0700 (PDT)
In-Reply-To: <B36A9223-ECDA-4B6A-90BE-34CEE6C753C2@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Zheng Yan <ukernel@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 2016-06-29 at 14:53 +0800, Yan, Zheng wrote:
> >=20
> > On Jun 28, 2016, at 22:00, Jeff Layton <jlayton@redhat.com> wrote:
> >=20
> > On Tue, 2016-06-28 at 21:03 +0800, Yan, Zheng wrote:
> > >=20
> > > On Tue, Jun 28, 2016 at 3:07 AM, Jeff Layton <jlayton@redhat.com>
> > > wrote:
> > > >=20
> > > >=20
> > > > I'm eyeballing how to make ceph dentry revalidation occur in
> > > > rcu-walk
> > > > mode in the kernel cephfs client. It looks fairly
> > > > straightforward, but
> > > > for one thing:
> > > >=20
> > > > dentry_lease_is_valid queues an asynchronous lease renewal if
> > > > we're
> > > > halfway to the next lease renewal time:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (session) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ceph_mdsc_lease_send_msg(session, dir,=
 dentry,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CEPH_MDS_LEASE_RENEW,
> > > > seq);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ceph_put_mds_session(session);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > >=20
> > > > That can sleep, so we have to drop out of rcu walk mode in that
> > > > case.
> > > >=20
> > > > Is this lease renewal strictly necessary? I can make the code
> > > > drop out
> > > > of rcuwalk mode and try again in that case, but if this is just
> > > > an
> > > > opportunistic thing, then it may be better for performance to
> > > > take a
> > > > pass on renewing the lease early if we're still in RCU walk
> > > > mode.
> > > >=20
> > > dentry_lease_is_valid is the only place that renew lease. I think
> > > it's
> > > better to drop out of rcuwalk and try again
> > >=20
> > > Regards
> > > Yan, Zheng
> > >=20
> > That seems really odd to me.
> >=20
> > That call is only ever done in the d_revalidate codepath, so you'll
> > only get a lease renewal when you have repeated path-based access
> > to an
> > existing dentry.
> >=20
> > Maybe this means that I don't really understand ceph leases. More
> > questions...
> >=20
> > What exactly does the lease cover here?
> Lease covers dentry. MDS revoke release before changing dentry=E2=80=99=
s
> linkage. If client access a dentry frequently, it should renew the
> dentry lease when necessary. If dentry lease expires, client need to
> send a lookup request if it want to access the dentry.
>=20

Ok, got it, thanks. In that case, what might be better is to queue the
lease renewal to a workqueue and stay in RCU lookup mode. It's not like
we're planning to wait around on the reply so dropping out of RCU mode
is probably not what we want. I'll take a look at whether it makes
sense to embed a work_struct in the ceph_dentry_info.

--=20
Jeff Layton <jlayton@redhat.com>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
