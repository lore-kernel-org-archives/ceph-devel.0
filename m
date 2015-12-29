From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: how io works when backfill
Date: Tue, 29 Dec 2015 06:51:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512290650040.10312@cobra.newdream.net>
References: <CAAL-TMe06UBK9XBWd+WW8FqB+o5J1n+_GvDJ7FgQtSO51KbSyQ@mail.gmail.com> <CA+cZ7sg8NXXmkX-RULnE3uYN91ZV1d1xeVqZeXjmdTyAwq1h2A@mail.gmail.com> <CA+cZ7sir4YJBJDtejh+2_r6Hq0AMOU1TEzvNzrfH=tbzUVvCuA@mail.gmail.com> <alpine.DEB.2.00.1512280927160.14646@cobra.newdream.net>
 <CAAL-TMdWiDBXrFSpG9MXGN2=2+MnEHrZBpXRdb7VEgGeyExwhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57805 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbbL2Ov2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Dec 2015 09:51:28 -0500
In-Reply-To: <CAAL-TMdWiDBXrFSpG9MXGN2=2+MnEHrZBpXRdb7VEgGeyExwhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Wu <archer.wudong@gmail.com>
Cc: Zhiqiang Wang <wonzhq@gmail.com>, ceph-devel@vger.kernel.org

On Tue, 29 Dec 2015, Dong Wu wrote:
> if add in osd.7 and 7 becomes the primary: pg1.0 [1, 2, 3]  --> pg1.0
> [7, 2, 3],  is it similar with the example above?
> still install a pg_temp entry mapping the PG back to [1, 2, 3], then
> backfill happens to 7, normal io write to [1, 2, 3], if io to the
> portion of the PG that has already been backfilled will also be sent
> to osd.7?

Yes (although I forget how it picks the ordering of the osds in the temp 
mapping).  See PG::choose_acting() for the details.

> how about these examples about removing an osd:
> - pg1.0 [1, 2, 3]
> - osd.3 down and be removed
> - mapping changes to [1, 2, 5], but osd.5 has no data, then install a
> pg_temp mapping the PG back to [1, 2], then backfill happens to 5,
> - normal io write to [1, 2], if io hits object which has been
> backfilled to osd.5, io will also send to osd.5
> - when backfill completes, remove the pg_temp and mapping changes back
> to [1, 2, 5]

Yes

> another example:
> - pg1.0 [1, 2, 3]
> - osd.3 down and be removed
> - mapping changes to [5, 1, 2], but osd.5 has no data of the pg, then
> install a pg_temp mapping the PG back to [1, 2] which osd.1
> temporarily becomes the primary, then backfill happens to 5,
> - normal io write to [1, 2], if io hits object which has been
> backfilled to osd.5, io will also send to osd.5
> - when backfill completes, remove the pg_temp and mapping changes back
> to [5, 1, 2]
> 
> is my ananysis right?

Yep!

sage

> 
> 2015-12-29 1:30 GMT+08:00 Sage Weil <sage@newdream.net>:
> > On Mon, 28 Dec 2015, Zhiqiang Wang wrote:
> >> 2015-12-27 20:48 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
> >> > Hi,
> >> > When add osd or remove osd, ceph will backfill to rebalance data.
> >> > eg:
> >> > - pg1.0    [1, 2, 3]
> >> > - add an osd(eg. osd.7)
> >> > - ceph start backfill, then pg1.0 osd set changes to [1, 2, 7]
> >> > - if [a, b, c, d, e] are objects needing to backfill to osd.7 and now
> >> > object a is backfilling
> >> > - when a write io hits object a, then the io needs to wait for its
> >> > complete, then goes on.
> >> > - but if io hits object b which has not been backfilled, io reaches
> >> > osd.1, then osd.1 send the io to osd.2  and osd.7, but osd.7 does not
> >> > have object b, so osd.7 needs to wait for object b to backfilled, then
> >> > write. Is it right? Or osd.1 only send the io to osd.2, not both?
> >>
> >> I think in this case, when the write of object b reaches osd.1, it
> >> holds the client write, raises the priority of the recovery of object
> >> b, and kick off the recovery of it. When the recovery of object b is
> >> done, it requeue the client write, and then everything goes like
> >> usual.
> >
> > It's more complicated than that.  In a normal (log-based) recovery
> > situation, it is something like the above: if the acting set is [1,2,3]
> > but 3 is missing the latest copy of A, a write to A will block on the
> > primary while the primary initiates recovery of A immediately.  Once that
> > completes the IO will continue.
> >
> > For backfill, it's different.  In your example, you start with [1,2,3]
> > then add in osd.7.  The OSD will see that 7 has no data for teh PG and
> > install a pg_temp entry mapping the PG back to [1,2,3] temporarily.  Then
> > things will proceed normally while backfill happens to 7.  Backfill won't
> > interfere with normal IO at all, except that IO to the portion of the PG
> > that has already been backfilled will also be sent to the backfill target
> > (7) so that it stays up to date.  Once it complets, the pg_temp entry is
> > removed and the mapping changes back to [1,2,7].  Then osd.3 is allowed to
> > remove it's copy of the PG.
> >
> > sage
> >
> 
> 
