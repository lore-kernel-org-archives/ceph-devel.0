From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Too many objects per pg than average: deadlock
 situation
Date: Wed, 23 May 2018 20:35:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1805232034250.31613@piezo.novalocal>
References: <34562966-FC71-4194-9605-9ECB79BDA513@gmail.com>
 <alpine.DEB.2.11.1805202303591.2133@piezo.novalocal>
 <7690C1F1-5C98-4FA2-BD4A-24375F474951@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-959468156-1527107729=:31613"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <7690C1F1-5C98-4FA2-BD4A-24375F474951-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mike A <mike.almateia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-959468156-1527107729=:31613
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 23 May 2018, Mike A wrote:
> Hello
> 
> > 21 мая 2018 г., в 2:05, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> написал(а):
> > 
> > On Sun, 20 May 2018, Mike A wrote:
> >> Hello!
> >> 
> >> In our cluster, we see a deadlock situation.
> >> This is a standard cluster for an OpenStack without a RadosGW, we have a standard block access pools and one for metrics from a gnocchi.
> >> The amount of data in the gnocchi pool is small, but objects are just a lot.
> >> 
> >> When planning a distribution of PG between pools, the PG are distributed depending on the estimated data size of each pool. Correspondingly, as suggested by pgcalc for the gnocchi pool, it is necessary to allocate a little PG quantity.
> >> 
> >> As a result, the cluster is constantly hanging with the error "1 pools have many more objects per pg than average" and this is understandable: the gnocchi produces a lot of small objects and in comparison with the rest of pools it is tens times larger.
> >> 
> >> And here we are at a deadlock:
> >> 1. We can not increase the amount of PG on the gnocchi pool, since it is very small in data size
> >> 2. Even if we increase the number of PG - we can cross the recommended 200 PGs limit for each OSD in cluster
> >> 3. Constantly holding the cluster in the HEALTH_WARN mode is a bad idea
> >> 4. We can set the parameter "mon pg warn max object skew", but we do not know how the Ceph will work when there is one pool with a huge object / pool ratio
> >> 
> >> There is no obvious solution.
> >> 
> >> How to solve this problem correctly?
> > 
> > As a workaround, I'd just increase the skew option to make the warning go 
> > away.
> > 
> > It seems to me like the underlying problem is that we're looking at object 
> > count vs pg count, but ignoring the object sizes.  Unfortunately it's a 
> > bit awkward to fix because we don't have a way to quantify the size of 
> > omap objects via the stats (currently).  So for now, just adjust the skew 
> > value enough to make the warning go away!
> > 
> > sage
> 
> This situation can somehow negatively affect the work of the cluster?

Eh, you'll end up with a PG count that is possibly suboptimal.  You'd have 
to work pretty hard to notice any difference, though.  I wouldn't worry 
about it.

sage

--8323329-959468156-1527107729=:31613
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-959468156-1527107729=:31613--
