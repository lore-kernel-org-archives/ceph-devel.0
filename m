From: Sage Weil <sage@newdream.net>
Subject: Re: librados compound operations
Date: Mon, 28 Mar 2011 16:53:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103281647520.17288@cobra.newdream.net>
References: <Pine.LNX.4.64.1103281539580.17288@cobra.newdream.net>
 <20110328234104.GD10768@dreamer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34023 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab1C1Xu0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 19:50:26 -0400
In-Reply-To: <20110328234104.GD10768@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 28 Mar 2011, Tommi Virtanen wrote:
> On Mon, Mar 28, 2011 at 03:46:21PM -0700, Sage Weil wrote:
> > One weird thing I noticed is with the constructor.  In Rados:: did
> > 
> > +    static ObjectOperation *operation_create();
> > 
> > and the user then deletes it when they're done (after using it for one or 
> > more calls to operate() or aio_operate()).  Is that the the approach we 
> > want?  Because right above that in the header is
> > 
> >      int ioctx_create(const char *name, IoCtx &pioctx);
> > 
> > which is a totally different convention.  It does match
> 
> The usual argument about that is that returning a pointer is only good
> when the only possible failure, now and forever, is running out of
> memory. The int can communicate more reasons for failure.
> 
> So the real question to ask is, how guaranteed is that to work? For
> example, in the case of ioctx, the extra name argument might need to
> be unique among concurrent operations, etc.

In this case, yeah.. like the completion.  All we're doing is calling new 
on the hidden type.

> > +void librados::ObjectOperation::write(uint64_t off, const bufferlist& bl)
> > +{
> > +  ::ObjectOperation *o = (::ObjectOperation *)impl;
> > +  bufferlist c = bl;
> > +  o->write(off, c);
> > +}
> 
> Losing constness always makes me a bit sad.

Yeah... in this case it's because the internal methods are stealing the 
bufferlist contents (instead of copying).  That's pretty unfriendly 
because the argument is clobbered... the pain probably shouldn't be shared 
with librados users.  This is where the std::list<> copy happens instead.  

sage

