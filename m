From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: librados compound operations
Date: Mon, 28 Mar 2011 16:41:05 -0700
Message-ID: <20110328234104.GD10768@dreamer>
References: <Pine.LNX.4.64.1103281539580.17288@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:32846 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab1C1XlK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 19:41:10 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1103281539580.17288@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 28, 2011 at 03:46:21PM -0700, Sage Weil wrote:
> One weird thing I noticed is with the constructor.  In Rados:: did
> 
> +    static ObjectOperation *operation_create();
> 
> and the user then deletes it when they're done (after using it for one or 
> more calls to operate() or aio_operate()).  Is that the the approach we 
> want?  Because right above that in the header is
> 
>      int ioctx_create(const char *name, IoCtx &pioctx);
> 
> which is a totally different convention.  It does match

The usual argument about that is that returning a pointer is only good
when the only possible failure, now and forever, is running out of
memory. The int can communicate more reasons for failure.

So the real question to ask is, how guaranteed is that to work? For
example, in the case of ioctx, the extra name argument might need to
be unique among concurrent operations, etc.

> +void librados::ObjectOperation::write(uint64_t off, const bufferlist& bl)
> +{
> +  ::ObjectOperation *o = (::ObjectOperation *)impl;
> +  bufferlist c = bl;
> +  o->write(off, c);
> +}

Losing constness always makes me a bit sad.

-- 
:(){ :|:&};:
