From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] vfs: add d_prune dentry operation
Date: Thu, 6 Oct 2011 17:21:18 -0400
Message-ID: <20111006212118.GA24109@infradead.org>
References: <1317875170-9349-1-git-send-email-sage@newdream.net>
 <1317875170-9349-2-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:33183
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759174Ab1JFVVW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2011 17:21:22 -0400
Content-Disposition: inline
In-Reply-To: <1317875170-9349-2-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: linux-fsdevel@vger.kernel.org, viro@ZenIV.linux.org.uk, hch@infradead.org, ceph-devel@vger.kernel.org, rwheeler@redhat.com, linux-kernel@vger.kernel.org

On Wed, Oct 05, 2011 at 09:26:10PM -0700, Sage Weil wrote:
> This adds a d_prune dentry operation that is called by the VFS prior to
> pruning (i.e. unhashing and killing) a hashed dentry from the dcache.  This
> will be used by Ceph to maintain a flag indicating whether the complete
> contents of a directory are contained in the dcache, allowing it to satisfy
> lookups and readdir without addition server communication.

What tree is the patch against?  I seems to fail to apply against Linus'
latests.  

It also seem like it basically should not be be opencoded but in a
wrapper around dentry_lru_del for all cases but the lazy removal from
LRU in case that is referenced, with some comments explaining the whole
thing.

