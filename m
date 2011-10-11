From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] vfs: add d_prune dentry operation
Date: Tue, 11 Oct 2011 08:39:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110110838500.32350@cobra.newdream.net>
References: <1317875170-9349-1-git-send-email-sage@newdream.net>
 <1317875170-9349-2-git-send-email-sage@newdream.net> <20111006212118.GA24109@infradead.org>
 <Pine.LNX.4.64.1110061507550.29500@cobra.newdream.net> <20111010051141.GV3159@dastard>
 <Pine.LNX.4.64.1110100850020.26361@cobra.newdream.net> <20111010162115.GB751@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48091 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab1JKPjY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 11:39:24 -0400
In-Reply-To: <20111010162115.GB751@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, viro@ZenIV.linux.org.uk, ceph-devel@vger.kernel.org, rwheeler@redhat.com, linux-kernel@vger.kernel.org

On Mon, 10 Oct 2011, Christoph Hellwig wrote:
> On Mon, Oct 10, 2011 at 09:19:43AM -0700, Sage Weil wrote:
> > Let me know if the below is clearer.  The requirement is that ->d_prune be 
> > called prior to unhashing (and then destroying) a victim dentry.  I'm a 
> > little worried about mixing that in with the lru helpers because it is 
> > only indirectly related to whether the dentry is on the LRU, and that may 
> > confuse people.  A cleaned up opencoded patch is here:
> > 
> > 	https://github.com/NewDreamNetwork/ceph-client/commit/784a6aa6dc7baf2069c40988d79130dba17c7068
> > 
> > and the updated dentry_lru_prune() wrapper version is below.
> 
> Long term what I really want is a helper for doing more of the real
> removal in single place.  This is one step towards it, and the series
> from Dave is another.

Ah, makes sense.

Dave, is the revised patch more clear?  

sage

