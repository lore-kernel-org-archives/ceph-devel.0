From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: inconsistencies from read errors during scrub
Date: Tue, 10 May 2016 12:10:24 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605101208130.15518@cpach.fuggernut.com>
References: <CABZ+qqnS5oVfwg0Byd7GKX6XZBN20E+UMF_ueVNGMv3eZzGa6A@mail.gmail.com>
	<CABZ+qqnNYcFUH7c-7dUpFz_utCC4aU8-sWBFTYqdUOA0zH2Bhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqnNYcFUH7c-7dUpFz_utCC4aU8-sWBFTYqdUOA0zH2Bhg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 21 Apr 2016, Dan van der Ster wrote:
> On Thu, Apr 21, 2016 at 1:23 PM, Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org> wrote:
> > Hi cephalapods,
> >
> > In our couple years of operating a large Ceph cluster, every single
> > inconsistency I can recall was caused by a failed read during
> > deep-scrub. In other words, deep scrub reads an object, the read fails
> > with dmesg reporting "Sense Key : Medium Error [current]", "Add.
> > Sense: Unrecovered read error", "blk_update_request: critical medium
> > error", but the ceph-osd keeps on running and serving up data.
> 
> I forgot to mention that the OSD notices the read error. In jewel it prints:
> 
> <objectname>:head got -5 on read, read_error
> 
> So why no assert?

I think this should be controlled by a config option, similar to how it is 
on read (filestore_fail_eio ... although we probably want a more generic 
option for that, too).

The danger would be that if we fail the whole due to a single failed read, 
we might fail too many osds too quickly, and availability drops.  
Ideally, if we saw an eio we would do a graceful offload (mark osd out or 
reweight to 0, drop primary_affinity; and then fail osd when we are done).

sage
