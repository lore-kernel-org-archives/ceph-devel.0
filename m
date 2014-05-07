From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: v0.80 Firefly released
Date: Wed, 7 May 2014 08:53:05 -0700
Message-ID: <CAPYLRzhyt3i0sXOGrqZxzrH02+VOjBeMS37xk8ua2K2C2oydkw@mail.gmail.com>
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
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, May 7, 2014 at 8:44 AM, Dan van der Ster
<daniel.vanderster-vJEk5272eHo@public.gmane.org> wrote:
> Hi,
>
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

It changes the calculation of who becomes the primary, and that
primary serves both reads and writes. In slightly more depth:
Previously, the primary has always been the first OSD chosen as a
member of the PG.
For erasure coding, we added the ability to specify a primary
independent of the selection ordering. This was part of a broad set of
changes to prevent moving the EC "shards" around between different
members of the PG, and means that the primary might be the second OSD
in the PG, or the fourth.
Once this work existed, we realized that it might be useful in other
cases, because primaries get more of the work for their PG (serving
all reads, coordinating writes).
So we added the ability to specify a "primary affinity", which is like
the CRUSH weights but only impacts whether you become the primary. So
if you have 3 OSDs that each have primary affinity = 1, it will behave
as normal. If two have primary affinity = 0, the remaining OSD will be
the primary. Etc.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
