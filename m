From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: is the renewal in dentry_lease_is_valid necessary?
Date: Wed, 29 Jun 2016 14:53:06 +0800
Message-ID: <B36A9223-ECDA-4B6A-90BE-34CEE6C753C2@redhat.com>
References: <1467054441.25213.20.camel@redhat.com> <CAAM7YAm7qHJkKjXSiG2bz-D04uNVJTbDw4XbvZ9mnU==u9eT2Q@mail.gmail.com> <1467122456.32374.15.camel@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49039 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbcF2GxL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 02:53:11 -0400
In-Reply-To: <1467122456.32374.15.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Zheng Yan <ukernel@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>


> On Jun 28, 2016, at 22:00, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Tue, 2016-06-28 at 21:03 +0800, Yan, Zheng wrote:
>> On Tue, Jun 28, 2016 at 3:07 AM, Jeff Layton <jlayton@redhat.com> wr=
ote:
>>>=20
>>> I'm eyeballing how to make ceph dentry revalidation occur in rcu-wa=
lk
>>> mode in the kernel cephfs client. It looks fairly straightforward, =
but
>>> for one thing:
>>>=20
>>> dentry_lease_is_valid queues an asynchronous lease renewal if we're
>>> halfway to the next lease renewal time:
>>>=20
>>>         if (session) {
>>>                 ceph_mdsc_lease_send_msg(session, dir, dentry,
>>>                                          CEPH_MDS_LEASE_RENEW, seq)=
;
>>>                 ceph_put_mds_session(session);
>>>         }
>>>=20
>>> That can sleep, so we have to drop out of rcu walk mode in that cas=
e.
>>>=20
>>> Is this lease renewal strictly necessary? I can make the code drop =
out
>>> of rcuwalk mode and try again in that case, but if this is just an
>>> opportunistic thing, then it may be better for performance to take =
a
>>> pass on renewing the lease early if we're still in RCU walk mode.
>>>=20
>> dentry_lease_is_valid is the only place that renew lease. I think it=
's
>> better to drop out of rcuwalk and try again
>>=20
>> Regards
>> Yan, Zheng
>>=20
>=20
> That seems really odd to me.
>=20
> That call is only ever done in the d_revalidate codepath, so you'll
> only get a lease renewal when you have repeated path-based access to =
an
> existing dentry.
>=20
> Maybe this means that I don't really understand ceph leases. More
> questions...
>=20
> What exactly does the lease cover here?

Lease covers dentry. MDS revoke release before changing dentry=E2=80=99=
s linkage. If client access a dentry frequently, it should renew the de=
ntry lease when necessary. If dentry lease expires, client need to send=
 a lookup request if it want to access the dentry.

Yan, Zheng=20

>=20
> Shouldn't we be renewing it even if we're _not_ doing any path-based
> access? For instance, if I open a file and issue reads and writes
> against it, that doesn't involve pathnames and the lease doesn't get =
an
> explicit renewal. Doesn't it still need to be renewed though?
>=20
> --=20
> Jeff Layton <jlayton@redhat.com>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
