From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: v0.80 Firefly released
Date: Wed, 7 May 2014 08:51:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405070849350.31818@cobra.newdream.net>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net>
	<536A54C6.4060202@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <536A54C6.4060202-vJEk5272eHo@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Dan van der Ster <daniel.vanderster-vJEk5272eHo@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Wed, 7 May 2014, Dan van der Ster wrote:
> Hi,
> 
> Sage Weil wrote:
> 
> * *Primary affinity*: Ceph now has the ability to skew selection of
>   OSDs as the "primary" copy, which allows the read workload to be
>   cheaply skewed away from parts of the cluster without migrating any
>   data.
> 
> 
> Can you please elaborate a bit on this one? I found the blueprint [1] but
> still don't quite understand how it works. Does this only change the crush
> calculation for reads? i.e writes still go to the usual primary, but reads
> are distributed across the replicas? If so, does this change the consistency
> model in any way.

It basically just skews the choice of which replica is the primary.  No 
data has to move, but the read workload and write overhead associated with 
being the primary (driving recovery and forwarding writes) is diverted 
away from the nodes whose 'affinity' is reduced from the default/baseline.

sage
