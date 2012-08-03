From: Christoph Hellwig <hch@infradead.org>
Subject: Re: TIER: combine SSDs and HDDs into a single block device
Date: Fri, 3 Aug 2012 03:22:17 -0400
Message-ID: <20120803072217.GA23837@infradead.org>
References: <CADvuQRExAsO2yKo6pT+MMfj8Gwt7a7SGkkOgm-0kjQ+nRzU75g@mail.gmail.com>
 <501AB2B4.2010406@inktank.com>
 <20120802175700.GA16693@infradead.org>
 <501AF5D7.9060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:41814
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751167Ab2HCHWT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Aug 2012 03:22:19 -0400
Content-Disposition: inline
In-Reply-To: <501AF5D7.9060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Christoph Hellwig <hch@infradead.org>, Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org

On Thu, Aug 02, 2012 at 04:49:11PM -0500, Mark Nelson wrote:
> I was thinking of doing that.  Is the realtime allocator a good fit
> for this kind of thing?  I think dchinner mentioned on the xfs
> mailing list last year that it's single threaded and not very well
> optimized (and maybe not production viable?)

It's generally a bit dated and bit rotting, and as Dave said doesn't
parallelize.  But for a setup where you have one OSD per disk and lots
of OSD that's not really quite as important.

