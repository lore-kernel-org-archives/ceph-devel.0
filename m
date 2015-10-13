From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Initial performance cluster SimpleMessenger vs
 AsyncMessenger results
Date: Tue, 13 Oct 2015 05:58:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510130557040.6589@cobra.newdream.net>
References: <561BE4E3.7050404@redhat.com>
	<CACJqLyaF-rtPVe2cX=y19cxcupfWPVXeZSpgpofXxR1qktwo2g@mail.gmail.com>
	<CACJqLyY+11d9ENxnMeNSTnJ-u-CAKbEED79GAjgJU7=nAAZ=9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CACJqLyY+11d9ENxnMeNSTnJ-u-CAKbEED79GAjgJU7=nAAZ=9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 13 Oct 2015, Haomai Wang wrote:
> resend
> 
> On Tue, Oct 13, 2015 at 10:56 AM, Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > COOL
> >
> > Interesting that async messenger will consume more memory than simple, in my
> > mind I always think async should use less memory. I will give a look at this

Yeah.. I was surprised to see this as well.  The other conclusions 
are quite promising, though!

Note that we still have a few outstanding issues with async msgr that 
cropped up during the infernalis testing, so for now we're doing 
just simplemessenger to get infernalis out the door.  That gives us the 
balance of this next cycle until Jewel to shake out the remaining issues 
so that hopefully we can make this the default for Jewel!

sage


> >
> > On Tue, Oct 13, 2015 at 12:50 AM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >>
> >> Hi Guy,
> >>
> >> Given all of the recent data on how different memory allocator
> >> configurations improve SimpleMessenger performance (and the effect of memory
> >> allocators and transparent hugepages on RSS memory usage), I thought I'd run
> >> some tests looking how AsyncMessenger does in comparison.  We spoke about
> >> these a bit at the last performance meeting but here's the full write up.
> >> The rough conclusion as of right now appears to be:
> >>
> >> 1) AsyncMessenger performance is not dependent on the memory allocator
> >> like with SimpleMessenger.
> >>
> >> 2) AsyncMessenger is faster than SimpleMessenger with TCMalloc + 32MB (ie
> >> default) thread cache.
> >>
> >> 3) AsyncMessenger is consistently faster than SimpleMessenger for 128K
> >> random reads.
> >>
> >> 4) AsyncMessenger is sometimes slower than SimpleMessenger when memory
> >> allocator optimizations are used.
> >>
> >> 5) AsyncMessenger currently uses far more RSS memory than SimpleMessenger.
> >>
> >> Here's a link to the paper:
> >>
> >> https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/view
> >>
> >> Mark
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> >
> >
> >
> > --
> >
> > Best Regards,
> >
> > Wheat
> 
> 
> 
> -- 
> Best Regards,
> 
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
