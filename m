From: Sage Weil <sage@inktank.com>
Subject: Re: question about  striped_read
Date: Wed, 24 Jul 2013 22:54:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307242252080.10870@cobra.newdream.net>
References: <201307250852310158703@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58654 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab3GYFy5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 01:54:57 -0400
In-Reply-To: <201307250852310158703@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 25 Jul 2013, majianpeng wrote:
> Hi all,
> 	I met a problem and ask somebody could help me.
> In func striped_read()
> > if (ret > 0) {
> >                int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> 
> >                if (read < pos - off) {
> >                       dout(" zero gap %llu to %llu\n", off + read, pos);
> >                        ceph_zero_page_vector_range(page_align + read,
> >                                                    pos - off - read, pages);
> >                }   
> >                pos += ret;
> >               read = pos - off;
> 
> At first , pos = off and off don't modify.
> Why does it judge 'read < pos -off ' ?
> Because the read = pos -off, so the read must equal pos -off.

This block triggers if we hit a stripe.  off is always the original 
starting offset.  pos is the current position that we just tried to read 
from.  We might:

 - try to read a big extent from off == pos
 - readpages truncates this to the end of the object
 - we get a short read (not a complete object)
 - read is some partial amount
 - pos is off + read + a gap
 - we try to read from the next object and there is data
   => there was a hole and we need to zero the gap

If, on the other hand, there isn't data in the next object, then we don't 
want to zero the hole.. and least not until we decide where EOF is.  
That's why this block is where it is, and never triggers on the first 
iteration.

Does that make sense?
sage
