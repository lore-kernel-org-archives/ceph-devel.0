From: GuangYang <yguang11@outlook.com>
Subject: RE: radosgw - stuck ops
Date: Tue, 4 Aug 2015 09:48:25 -0700
Message-ID: <BLU175-W4225FE328848A260F90305DF760@phx.gbl>
References: <BLU175-W48D8E409F917C02492E3C4DF760@phx.gbl>,<CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc1s9.hotmail.com ([65.55.116.20]:59248 "EHLO
	BLU004-OMC1S9.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbbHDQ4Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 12:56:25 -0400
In-Reply-To: <CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, Weil Sage <sweil@redhat.com>, "Just, Samuel" <sjust@redhat.com>
Cc: Sadeh-Weinraub Yehuda <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Yehuda,
Thanks for the quick response. My comments inline..

Thanks,
Guang
________________________________
> Date: Tue, 4 Aug 2015 08:41:26 -0700=20
> Subject: Re: radosgw - stuck ops=20
> From: ysadehwe@redhat.com=20
> To: yguang11@outlook.com; sweil@redhat.com; sjust@redhat.com=20
> CC: yehuda@redhat.com; ceph-devel@vger.kernel.org=20
>=20
>=20
>=20
> On Mon, Aug 3, 2015 at 6:53 PM, GuangYang=20
> <yguang11@outlook.com<mailto:yguang11@outlook.com>> wrote:=20
> Hi Yehuda,=20
> Recently with our pre-production clusters (with radosgw), we had an=20
> outage that all radosgw worker threads got stuck and all clients=20
> request resulted in 500 because that there is no worker thread taking=
=20
> care of them.=20
>=20
> What we observed from the cluster, is that there was a PG stuck at=20
> *peering* state, as a result, all requests hitting that PG would occu=
py=20
> a worker thread infinitely and that gradually stuck all workers.=20
>=20
> The reason why the PG stuck at peering is still under investigation,=20
> but radosgw side, I am wondering if we can pursue anything to improve=
=20
> such use case (to be more specific, 1 out of 8192 PGs' issue cascadin=
g=20
> to a service unavailable across the entire cluster):=20
>=20
> 1. The first approach I can think of is to add timeout at objecter=20
> layer for each OP to OSD, I think the complexity comes with WRITE, th=
at=20
> is, how do we make sure the integrity if we abort at objecter layer.=20
> But for immutable op, I think we certainly can do this, since at an=20
> upper layer, we already reply back to client with an error.=20
> 2. Do thread pool/working queue sharding at radosgw, in which case,=20
> partial failure would (hopefully) only impact partial of worker threa=
ds=20
> and only cause a partial outage.=20
>=20
>=20
> The problem with timeouts is that they are racy and can bring the=20
> system into inconsistent state. For example, an operation takes too=20
> long, rgw gets a timeout, but the operation actually completes on the=
=20
> osd. So rgw returns with an error, removes the tail and does not=20
> complete the write, whereas in practice the new head was already=20
> written and points at the newly removed tail. The index would still=20
> show as if the old version of the object was still there. I'm sure we=
=20
> can come up with some more scenarios that I'm not sure we could resol=
ve=20
> easily.=A0
Right, that is my concern as well, we will need to come up with a mecha=
nism to
preserve integrity, like for each write, it should be all or nothing, n=
ot partial, though
we already reply to client with a 500 error.
But that is the problem we properly need to deal with anyway, for examp=
le, in our
cluster, each time we detect this kind of availability issue, we will n=
eed to restart
all radosgw daemons to bring it back, which has the possibility to leav=
e some
inconsistent state.
I am thinking it might make sense to start with *immutable* requests, f=
or example,
bucket listing, object get/head, etc. We can timeout as long as we time=
out with client.
That should be much easier to implement and solve part of the problem.
> The problem with sharding is that for large enough objects they could=
=20
> end up writing to any pg, so I'm not sure how effective that would be=
=2E
Not sure of other use cases with radosgw across the community, but for =
us, at
time being, 95%tile of the objects are stored with one chunk, so that s=
hould be
effective for this kind of work load, but yeah we should consider to su=
pport more
general use cases. As a bottom line, that should not make things worse.
> One solution that I can think of is to determine before the read/writ=
e=20
> whether the pg we're about to access is healthy (or has been unhealth=
y=20
> for a short period of time), and if not to cancel the request before=20
> sending the operation. This could mitigate the problem you're seeing =
at=20
> the expense of availability in some cases. We'd need to have a way to=
=20
> query pg health through librados which we don't have right now afaik.=
=A0
That sounds good. The only complexity I can think of is for large objec=
ts
which has several chunks, we will need to deal with the write issue as =
well, since each chunk
might assign to different PGs?
> Sage / Sam, does that make sense, and/or possible?=20
>=20
> Yehuda=20
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
