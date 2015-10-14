From: "Chen, Xiaoxi" <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Initial performance cluster SimpleMessenger vs
 AsyncMessenger results
Date: Wed, 14 Oct 2015 15:57:54 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC0363250E@shsmsx102.ccr.corp.intel.com>
References: <561BE4E3.7050404@redhat.com>
	<CACJqLyaF-rtPVe2cX=y19cxcupfWPVXeZSpgpofXxR1qktwo2g@mail.gmail.com>
	<CACJqLyY+11d9ENxnMeNSTnJ-u-CAKbEED79GAjgJU7=nAAZ=9A@mail.gmail.com>
	<561D0113.108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <561D0113.108-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Mark,
     The Async result  in 128K drops quickly after some point, is that because of the testing methodology?
      
     Other conclusion looks to me like simple messenger + Jemalloc is the best practice till now as it has the same performance as async but using much less memory?

-Xiaoxi

> -----Original Message-----
> From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of
> Mark Nelson
> Sent: Tuesday, October 13, 2015 9:03 PM
> To: Haomai Wang
> Cc: ceph-devel; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> Subject: Re: [ceph-users] Initial performance cluster SimpleMessenger vs
> AsyncMessenger results
> 
> Hi Haomai,
> 
> Great!  I haven't had a chance to dig in and look at it with valgrind yet, but if I
> get a chance after I'm done with newstore fragment testing and somnath's
> writepath work I'll try to go back and dig in if you haven't had a chance yet.
> 
> Mark
> 
> On 10/12/2015 09:56 PM, Haomai Wang wrote:
> > resend
> >
> > On Tue, Oct 13, 2015 at 10:56 AM, Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >> COOL
> >>
> >> Interesting that async messenger will consume more memory than
> >> simple, in my mind I always think async should use less memory. I
> >> will give a look at this
> >>
> >> On Tue, Oct 13, 2015 at 12:50 AM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> wrote:
> >>>
> >>> Hi Guy,
> >>>
> >>> Given all of the recent data on how different memory allocator
> >>> configurations improve SimpleMessenger performance (and the effect
> >>> of memory allocators and transparent hugepages on RSS memory usage),
> >>> I thought I'd run some tests looking how AsyncMessenger does in
> >>> comparison.  We spoke about these a bit at the last performance
> meeting but here's the full write up.
> >>> The rough conclusion as of right now appears to be:
> >>>
> >>> 1) AsyncMessenger performance is not dependent on the memory
> >>> allocator like with SimpleMessenger.
> >>>
> >>> 2) AsyncMessenger is faster than SimpleMessenger with TCMalloc +
> >>> 32MB (ie
> >>> default) thread cache.
> >>>
> >>> 3) AsyncMessenger is consistently faster than SimpleMessenger for
> >>> 128K random reads.
> >>>
> >>> 4) AsyncMessenger is sometimes slower than SimpleMessenger when
> >>> memory allocator optimizations are used.
> >>>
> >>> 5) AsyncMessenger currently uses far more RSS memory than
> SimpleMessenger.
> >>>
> >>> Here's a link to the paper:
> >>>
> >>> https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/view
> >>>
> >>> Mark
> >>> _______________________________________________
> >>> ceph-users mailing list
> >>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>
> >>
> >>
> >>
> >> --
> >>
> >> Best Regards,
> >>
> >> Wheat
> >
> >
> >
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
