From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: optimizing buffers, encode/decode
Date: Wed, 29 Oct 2014 13:23:58 -0400 (EDT)
Message-ID: <504191181.157.1414603437991.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1410290957240.21856@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2159 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933943AbaJ2RYD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Oct 2014 13:24:03 -0400
In-Reply-To: <alpine.DEB.2.00.1410290957240.21856@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

We're starting a round of work on improving encode/decode workload profiling, which we'll
share as soon as we have something informative.

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> We talked a bit about improving the performance encode/decode 
> yesterday at CDS:
> 
> 	http://pad.ceph.com/p/hammer-buffer_encoding
> 
> I think the main takeaways were:
> 
> 1- We need some up to date profiling information to see
> 
>   - how much of it is buffer-related functions (e.g., append)
>   - which data types are slowest or most frequently encoded (or
> otherwise 
>     show up in the profile)
> 
> 2- For now we should probably focus on the efficiency of the
> encode/decode 
> paths.  Possibilities include
> 
>   - making more things inline
>   - improving the past path
> 
> 3- Matt and the linuxbox folks have been playing with some general 
> optimizations for the buffer::list class.  These include combining 
> some of the function of ptr and raw so that, for the common 
> single-reference case, we chain the raw pointers together directly
> from 
> list using the boost intrusive list type, and fall back to the current
> 
> list -> ptr -> raw strategy when there are additional refs.
> 
> 
> For #2, one simple thought would be to cache a pointer and remaining
> bytes 
> or end pointer into the append_buffer directly in list so that we
> avoid 
> the duplicate asserts and size checks in the common append (encode)
> path.  
> Then a
> 
>   ::encode(myu64, bl);
> 
> would inline into something pretty quick, like
> 
>   remaining -= 8;
>   if (remainining < 0) { // take slow path
> 
>   } else {
>      *ptr = myu64;
>      ptr += 8;
>   }
> 
> Not sure if an end pointer would let us cut out the 2 arithmetic ops
> or 
> not.  Or if it even matters on modern pipelining processors.
> 
> Anyway, any gains we make here will pay dividends across the entire 
> code base.  And any profiling people want to do will help guide 
> things...
> 
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
