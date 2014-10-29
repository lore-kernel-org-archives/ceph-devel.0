From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: optimizing buffers, encode/decode
Date: Wed, 29 Oct 2014 13:38:16 -0400 (EDT)
Message-ID: <791540803.179.1414604296487.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <CACJqLybiam9AfmP8aA3nnWR500iA1owS-+yWYSWiFT6-yOn2mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4468 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934312AbaJ2RiV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Oct 2014 13:38:21 -0400
In-Reply-To: <CACJqLybiam9AfmP8aA3nnWR500iA1owS-+yWYSWiFT6-yOn2mw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Hi Haomai,

I agree, and we'll join to hear your talk.

Thanks,

Matt

----- "Haomai Wang" <haomaiwang@gmail.com> wrote:

> I'm interested in bufferlist's own encode/decode performance. But as
> I
> performed until now, I think we need to consider change caller's
> behavior to get better performance.
> 
> Combined
> (https://wiki.ceph.com/Planning/Blueprints/Hammer/Fixed_memory_layout_for_Message%2F%2FOp_passing)
> with
> bp(https://wiki.ceph.com/Planning/Blueprints/Hammer/osd%3A_update_Transaction_encoding),
> I'm going to seeking a way to reduce encode/decodes calls.
> 
> Mainly, we have three points:
> 1. Make ObjectStore::Transaction's metadata and data separated
> 2. No copy for op's data from Messenger to ObjectStore
> 3. Avoid encode/decode for ObjectStore::OP instead of fixed-size
> memory layout
> 
> We have a simple perf test results and a overview design ppt. Hope we
> can have a talk at 8:00(CST).
> 
> On Thu, Oct 30, 2014 at 1:23 AM, Matt W. Benjamin <matt@linuxbox.com>
> wrote:
> > Hi Sage,
> >
> > We're starting a round of work on improving encode/decode workload
> profiling, which we'll
> > share as soon as we have something informative.
> >
> > Matt
> >
> > ----- "Sage Weil" <sage@inktank.com> wrote:
> >
> >> We talked a bit about improving the performance encode/decode
> >> yesterday at CDS:
> >>
> >>       http://pad.ceph.com/p/hammer-buffer_encoding
> >>
> >> I think the main takeaways were:
> >>
> >> 1- We need some up to date profiling information to see
> >>
> >>   - how much of it is buffer-related functions (e.g., append)
> >>   - which data types are slowest or most frequently encoded (or
> >> otherwise
> >>     show up in the profile)
> >>
> >> 2- For now we should probably focus on the efficiency of the
> >> encode/decode
> >> paths.  Possibilities include
> >>
> >>   - making more things inline
> >>   - improving the past path
> >>
> >> 3- Matt and the linuxbox folks have been playing with some general
> >> optimizations for the buffer::list class.  These include combining
> >> some of the function of ptr and raw so that, for the common
> >> single-reference case, we chain the raw pointers together directly
> >> from
> >> list using the boost intrusive list type, and fall back to the
> current
> >>
> >> list -> ptr -> raw strategy when there are additional refs.
> >>
> >>
> >> For #2, one simple thought would be to cache a pointer and
> remaining
> >> bytes
> >> or end pointer into the append_buffer directly in list so that we
> >> avoid
> >> the duplicate asserts and size checks in the common append
> (encode)
> >> path.
> >> Then a
> >>
> >>   ::encode(myu64, bl);
> >>
> >> would inline into something pretty quick, like
> >>
> >>   remaining -= 8;
> >>   if (remainining < 0) { // take slow path
> >>
> >>   } else {
> >>      *ptr = myu64;
> >>      ptr += 8;
> >>   }
> >>
> >> Not sure if an end pointer would let us cut out the 2 arithmetic
> ops
> >> or
> >> not.  Or if it even matters on modern pipelining processors.
> >>
> >> Anyway, any gains we make here will pay dividends across the
> entire
> >> code base.  And any profiling people want to do will help guide
> >> things...
> >>
> >> Thanks!
> >> sage
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel"
> >> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > Matt Benjamin
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI  48104
> >
> > http://linuxbox.com
> >
> > tel.  734-761-4689
> > fax.  734-769-8938
> > cel.  734-216-5309
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Best Regards,
> 
> Wheat

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
