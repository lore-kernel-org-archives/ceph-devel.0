From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] vfs: add d_prune dentry operation
Date: Mon, 10 Oct 2011 12:21:15 -0400
Message-ID: <20111010162115.GB751@infradead.org>
References: <1317875170-9349-1-git-send-email-sage@newdream.net>
 <1317875170-9349-2-git-send-email-sage@newdream.net>
 <20111006212118.GA24109@infradead.org>
 <Pine.LNX.4.64.1110061507550.29500@cobra.newdream.net>
 <20111010051141.GV3159@dastard>
 <Pine.LNX.4.64.1110100850020.26361@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1110100850020.26361@cobra.newdream.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Sage Weil <sage@newdream.net>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, viro@ZenIV.linux.org.uk, ceph-devel@vger.kernel.org, rwheeler@redhat.com, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Oct 10, 2011 at 09:19:43AM -0700, Sage Weil wrote:
> Let me know if the below is clearer.  The requirement is that ->d_prune be 
> called prior to unhashing (and then destroying) a victim dentry.  I'm a 
> little worried about mixing that in with the lru helpers because it is 
> only indirectly related to whether the dentry is on the LRU, and that may 
> confuse people.  A cleaned up opencoded patch is here:
> 
> 	https://github.com/NewDreamNetwork/ceph-client/commit/784a6aa6dc7baf2069c40988d79130dba17c7068
> 
> and the updated dentry_lru_prune() wrapper version is below.

Long term what I really want is a helper for doing more of the real
removal in single place.  This is one step towards it, and the series
from Dave is another.

