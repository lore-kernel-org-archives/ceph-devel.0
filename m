From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: How to release Hammer osd RAM when compiled with
	jemalloc
Date: Wed, 14 Dec 2016 01:46:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612140144360.32565@piezo.novalocal>
References: <CAAL-TMcjJi7dQrOHiBUwQCgJ5R2cWDeLBB3XzKAogvaAR7yUxg@mail.gmail.com>
	<alpine.DEB.2.11.1612131238260.32565@piezo.novalocal>
	<CAAL-TMdqQiLExSB+tTrGvnOiMxNgSZmM6KYEPyYCHJDouWfM4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAL-TMdqQiLExSB+tTrGvnOiMxNgSZmM6KYEPyYCHJDouWfM4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dong Wu <archer.wudong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 14 Dec 2016, Dong Wu wrote:
> Thanks for your response.
> 
> 2016-12-13 20:40 GMT+08:00 Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>:
> > On Tue, 13 Dec 2016, Dong Wu wrote:
> >> Hi, all
> >>    I have a cluster with nearly 1000 osds, and each osd already
> >> occupied 2.5G physical memory on average, which cause each host 90%
> >> memory useage. when use tcmalloc, we can use "ceph tell osd.* release"
> >> to release unused memory, but in my cluster, ceph is build with
> >> jemalloc, so can't use "ceph tell osd.* release", is there any methods
> >> to release some memory?
> >
> > We explicitly call into tcmalloc to release memory with that command, but
> > unless you've patched something in yourself there is no integration with
> > jemalloc's release API.
> 
> Are there any methods to know detail memory usage of OSD, if we have a
> memory allocator recording detail memory usage, will this be helpful?
> Is it on the schedule?

Kraken has a new mempool infrastructure and some of the OSD pieces have 
been moved into it, but only some.  There's quite a bit of opportunity to 
further categorize allocations to get better visibility here.

Barring that, your best bet is to use either tcmalloc's heap profiling or 
valgrind massif.  Both slow down execution by a lot (5-10x).  Massif has 
better detail, but is somewhat slower.

sage


> 
> >
> >> another question:
> >> can I decrease the following config value which used for cached osdmap
> >>  to lower osd's memory?
> >>
> >> "mon_min_osdmap_epochs": "500"
> >> "osd_map_max_advance": "200",
> >> "osd_map_cache_size": "500",
> >> "osd_map_message_max": "100",
> >> "osd_map_share_max_epochs": "100"
> >
> > Yeah.  You should be fine with 500, 50, 100, 50, 50.
> 
> >
> > sage
> 
> Thanks.
> Regards.
> 
> 
