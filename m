From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Filestore throttling
Date: Thu, 23 Oct 2014 21:26:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410232119190.10837@cobra.newdream.net>
References: <BLU175-W34FC39734E69C620D262DEDF920@phx.gbl>,
	<alpine.DEB.2.00.1410222104080.10837@cobra.newdream.net>
	<BLU175-W176682F001CDC16FC4FA67DF920@phx.gbl>,
	<alpine.DEB.2.00.1410230653320.10837@cobra.newdream.net>
	<BLU175-W21BCCB0C8E9A1CF98FB27EDF930@phx.gbl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1761252960-1414124767=:10837"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <BLU175-W21BCCB0C8E9A1CF98FB27EDF930-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1761252960-1414124767=:10837
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Oct 2014, GuangYang wrote:
> > commit 44dca5c8c5058acf9bc391303dc77893793ce0be
> > Author: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
> > Date: Sat Jan 19 17:33:25 2013 -0800
> >
> > filestore: disable extra committing queue allowance
> >
> > The motivation here is if there is a problem draining the op queue
> > during a sync. For XFS and ext4, this isn't generally a problem: you
> > can continue to make writes while a syncfs(2) is in progress. There
> > are currently some possible implementation issues with btrfs, but we
> > have not demonstrated them recently.
> >
> > Meanwhile, this can cause queue length spikes that screw up latency.
> > During a commit, we allow too much into the queue (say, recovery
> > operations). After the sync finishes, we have to drain it out before
> > we can queue new work (say, a higher priority client request). Having
> > a deep queue below the point where priorities order work limits the
> > value of the priority queue.
> >
> > Signed-off-by: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
> >
> > I'm not sure it makes sense to increase it in the general case. It mi=
ght
> > make sense for your workload, or we may want to make peering transact=
ions
> > some sort of special case...?
> It is actually another commit:
>=20
> commit=A040654d6d53436c210b2f80911217b044f4d7643a
> filestore: filestore_queue_max_ops 500 -> 50
> Having a deep queue limits the effectiveness of the priority queues
> above by adding additional latency.

Ah, you're right.

> I don't quite understand the use case that it might add additional=20
> latency by increasing this value, would you mind elaborating?

There is a priority queue a bit further up the stack OpWQ, in which high=20
priority items (e.g., client IO) can move ahead of low priority items=20
(e.g., recovery).  If the queue beneath that (the filestore one) is very=20
deep, the client IO will only have a marginal advantage over the recovery=
=20
IO since it will still sit in the second queue for a long time.  Ideally,=
=20
we want the priority queue to be the deepest one (so that we maximize the=
=20
amount of stuff we can reorder) and the queues above and below to be as=20
shallow as possible.

I think the peering operations are different because they can't be=20
reordered with respect to anything else in the same PG (unlike, say,=20
client vs recovery io for that pg).  On the other hand, there may be=20
client IO on other PGs that we want to reorder and finish more quickly. =20
Allowing all of the right reordering and also getting the priority=20
inheritence right here is probably a hugely complex undertaking, so we=20
probably just want to go for a reasonably simple strategy that avoids the=
=20
worst instances of priority inversion (where an important thing is stuck=20
behind a slow thing).  :/

In any case, though, I'm skeptical that making the lowest-level queue=20
deeper is going to help in general, even if it addresses the peering=20
case specifically...

sage
--557981400-1761252960-1414124767=:10837
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-1761252960-1414124767=:10837--
