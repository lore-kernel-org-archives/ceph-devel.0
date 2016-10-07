From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore-Performance regression in the latest master
Date: Fri, 7 Oct 2016 22:16:49 +0000
Message-ID: <BY2PR02MB396E452FEC89E52D7F53890F4C60@BY2PR02MB396.namprd02.prod.outlook.com>
References: <BY2PR02MB396BEF6CFDD1164D194C9D2F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1610062115250.19850@piezo.us.to>
 <BY2PR02MB3969BB28F45C805DB4D2735F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
 <50c62b05-5712-9502-1648-0772f8f8c5c1@redhat.com>
 <BY2PR02MB396C9E7D9CB33A1CDD204AAF4C70@BY2PR02MB396.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1610071317080.18626@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0083.outbound.protection.outlook.com ([104.47.38.83]:36241
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751798AbcJGWdG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 7 Oct 2016 18:33:06 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

My bad, I modified my script to run with high QD for read benchmarking and =
forgot to change back to lower QD for write test. That's why the latency go=
t 4X.
Now, I am running with lower QD (same I was doing earlier) and performance =
is similar to before (at least till 3 hour run now..), no regression. Sorry=
 for the noise.
But, why higher QD is making bluestore to run bumpy and the weird pattern I=
 showed earlier that is probably a separate issue which I will take up late=
r..
Ideally, you should be knowing what QD your cluster is capable of handling =
and beyond that lot of things could go wrong performance wise :-)..

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy=20
Sent: Friday, October 07, 2016 9:21 AM
To: 'Sage Weil'
Cc: Mark Nelson; Ceph Development
Subject: RE: Bluestore-Performance regression in the latest master

Shouldn't be, as amount of data we are writing per write is same as my last=
 test , so, level compaction shouldn't cause this..I am trying to nail it d=
own , will update you hopefully soon..

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Friday, October 07, 2016 6:18 AM
To: Somnath Roy
Cc: Mark Nelson; Ceph Development
Subject: RE: Bluestore-Performance regression in the latest master

On Thu, 6 Oct 2016, Somnath Roy wrote:
> Mark,
> If you see the graph in the below link , you will see it is choppy and fa=
ster till 1 hour , beyond that it is degrading fast..
> If you see the left side graph that is holding the constant=20
> performance throughout for 10 hour (old master) Have you checked the late=
ncy with the shorter run with the latest master as well ? Even with the sho=
rter run it is 4X more latency (even though aggregated throughput is bit mo=
re) for me..
> Anyways, I am trying to reproduce this in another setup just to eliminate=
 HW issues in case..

You mentioned yesterday you had tried switching the rocksdb compaction mode=
.. could that be it?

sage

>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Thursday, October 06, 2016 3:13 PM
> To: Somnath Roy; Sage Weil
> Cc: Ceph Development
> Subject: Re: Bluestore-Performance regression in the latest master
>=20
> This is bluestore specific?  My guess is the cache sizes as well.=20
> Bluestore on master is actually significantly faster for me in all of the=
 tests I've thrown at it vs earlier this week, but my onode hit rate is sti=
ll "decent".
>=20
> I still see higher performance by increasing the min alloc size to 16k an=
d then bumping up the onode cache size a bit with the memory savings.
>=20
> Mark
>=20
> On 10/06/2016 04:52 PM, Somnath Roy wrote:
> > I have increased the cache size at the point where it is started swappi=
ng after 30 min run or so , but, still I am seeing the huge latest differen=
ce.
> > Will try to find out what went wrong recently..
> >
> > Thanks & Regards
> > Somnath
> >
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Thursday, October 06, 2016 2:17 PM
> > To: Somnath Roy
> > Cc: Ceph Development
> > Subject: Re: Bluestore-Performance regression in the latest master
> >
> > On Thu, 6 Oct 2016, Somnath Roy wrote:
> >> Sage,
> >> I am seeing the performance with the latest master is not stable compa=
re to 3 days old master. The peak performance is higher but it is jumping u=
p and down. Analyzing further I suspect recent cache changes has an impact.=
 While the performance is high , I am seeing lower disk reads (probably bec=
ause of cache hits) , but the low point is much lower when it is missing th=
e cache probably. You were saying on the standup about adding buffers in th=
e cache in the write path , is that merged into the master ?
> >
> > The buffered writes by default is not merged:
> >
> > https://github.com/ceph/ceph/pull/11301
> >
> >> The following pull request for cache that got merged seems reasonable.
> >>
> >> https://github.com/ceph/ceph/pull/11295
> >
> > This cut the cache size down by 4x, plus whatever your sharding factor =
is/was.  Could that be it?
> >
> >> Any hunch what is causing this degradation recently ? Otherwise, I=20
> >> need to dig down to find that out :-(
> >>
> >> See the graph in the following link for the performance difference.
> >>
> >> https://docs.google.com/spreadsheets/d/1JO3FaBbfT5jEdyYGB8EhHnAl5bA
> >> He
> >> 0
> >> 6ojLE85mPzsK4/edit?usp=3Dsharing
> >>
> >> The left side graph is with old master and right one is with latest ma=
ster..Old one I ran for 10 hour and latest master I ran it for 2 hours.
> >> The new one has *4X more* latency as well..
> >
> > My guess is the cache size.  I can't think of what else would have much=
 of an effect on latency...
> >
> > s
> > PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that you have received this message in error and that any review, d=
issemination, distribution, or copying of this message is strictly prohibit=
ed. If you have received this communication in error, please notify the sen=
der by telephone or e-mail (as shown above) immediately and destroy any and=
 all copies of this message in your possession (whether hard copies or elec=
tronically stored copies).
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> > in the body of a message to majordomo@vger.kernel.org More majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
