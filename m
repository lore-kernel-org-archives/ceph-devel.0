From: Sage Weil <sage@inktank.com>
Subject: Re: Re: question about striped_read
Date: Thu, 25 Jul 2013 08:50:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307250848160.29435@cobra.newdream.net>
References: <201307250852310158703@gmail.com> <alpine.DEB.2.00.1307242252080.10870@cobra.newdream.net> <201307251455102701172@gmail.com> <CAAM7YAnDKvGBsXxzbcsFHTbTo7-7AgNnRXRCK+gEbvkwGuj5cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35508 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678Ab3GYPup (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 11:50:45 -0400
In-Reply-To: <CAAM7YAnDKvGBsXxzbcsFHTbTo7-7AgNnRXRCK+gEbvkwGuj5cg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: majianpeng <majianpeng@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 25 Jul 2013, Yan, Zheng wrote:
> On Thu, Jul 25, 2013 at 2:55 PM, majianpeng <majianpeng@gmail.com> wrote:
> >>On Thu, 25 Jul 2013, majianpeng wrote:
> >>> Hi all,
> >>>      I met a problem and ask somebody could help me.
> >>> In func striped_read()
> >>> > if (ret > 0) {
> >>> >                int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
> >>>
> >>> >                if (read < pos - off) {
> >>> >                       dout(" zero gap %llu to %llu\n", off + read, pos);
> >>> >                        ceph_zero_page_vector_range(page_align + read,
> >>> >                                                    pos - off - read, pages);
> >>> >                }
> >>> >                pos += ret;
> 
> I think you are right. probably above line should be 'pos += this_len'

It should be easy to construct a simple test for this.  E.g., something 
like

 pwrite(fd, buf, 0, 3000000);
 pwrite(fd, buf, 4194304, 1000);
 pread(fd, buf, 0, 6000000);
 ...

and whatever else to verify that pos was in fact advanced properly?

sage

> 
> regards
> yan, zheng
> 
> 
> >>> >               read = pos - off;
> >>>
> >>> At first , pos = off and off don't modify.
> >>> Why does it judge 'read < pos -off ' ?
> >>> Because the read = pos -off, so the read must equal pos -off.
> >>
> >>This block triggers if we hit a stripe.  off is always the original
> >>starting offset.  pos is the current position that we just tried to read
> >>from.  We might:
> >>
> >> - try to read a big extent from off == pos
> >> - readpages truncates this to the end of the object
> >> - we get a short read (not a complete object)
> > What's the mean of not a complete object?
> > FYI,a short read maybe  met the boundry of stripe(object) or the EOF of file.
> > For the hole of file, i don't know how to handle.
> >> - read is some partial amount
> >> - pos is off + read + a gap
> > From the code : read = pos - off; after that, the pos don't change.
> > So the a gap where is from?
> >
> > Thanks!
> > Jianpeng Ma
> >> - we try to read from the next object and there is data
> >>   => there was a hole and we need to zero the gap
> >>
> >>If, on the other hand, there isn't data in the next object, then we don't
> >>want to zero the hole.. and least not until we decide where EOF is.
> >>That's why this block is where it is, and never triggers on the first
> >>iteration.
> >>
> >>Does that make sense?
> >>sage
> 
> 
