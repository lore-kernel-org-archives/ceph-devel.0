From: James Harper <james.harper-NMzNsA1hOHcW+bLBXbPJGg@public.gmane.org>
Subject: Re: v0.61.8 Cuttlefish released
Date: Mon, 19 Aug 2013 23:30:40 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B6649FF7F@BITCOM1.int.sbss.com.au>
References: <alpine.DEB.2.00.1308191251390.11136@cobra.newdream.net>
	<6035A0D088A63A46850C3988ED045A4B6649FD75@BITCOM1.int.sbss.com.au>
	<alpine.DEB.2.00.1308191518150.11018@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1308191518150.11018-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

> On Mon, 19 Aug 2013, James Harper wrote:
> > >
> > > We've made another point release for Cuttlefish. This release contains a
> > > number of fixes that are generally not individually critical, but do trip
> > > up users from time to time, are non-intrusive, and have held up under
> > > testing.
> > >
> > > Notable changes include:
> > >
> > >  * librados: fix async aio completion wakeup
> > >  * librados: fix aio completion locking
> > >  * librados: fix rare deadlock during shutdown
> >
> > Could any of these be causing the segfaults I'm seeing in tapdisk rbd?
> > Are these fixes in dumpling?
> 
> They are also in the dumpling branch and 0.67.1.  They might explain it...
> not a slam dunk though.
> 

Just upgraded to test and no joy - tapdisk still segfaults

Thanks

James
