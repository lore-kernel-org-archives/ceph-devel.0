From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/5 v2 RESEND] fs: Avoid premature clearing of file
 capabilities
Date: Mon, 19 Sep 2016 08:38:23 -0700
Message-ID: <20160919153823.GA16912@infradead.org>
References: <1474299059-14806-1-git-send-email-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbcISPi1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 11:38:27 -0400
Content-Disposition: inline
In-Reply-To: <1474299059-14806-1-git-send-email-jack@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.org, Dave Chinner <david@fromorbit.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>

On Mon, Sep 19, 2016 at 05:30:54PM +0200, Jan Kara wrote:
> Hello,
> 
> I'm resending the patches since Al did not respond to the series yet (I've
> previously posted it in [1] on Aug 3. Al? If Al does not respond, can you
> Andrew please feed to patches to Linus? Thanks.

Yes, please get the series in.  I thought I reviewed it before, but
here it comes again:

Reviewed-by: Christoph Hellwig <hch@lst.de>
