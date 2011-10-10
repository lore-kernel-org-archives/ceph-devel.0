From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] vfs: add d_prune dentry operation
Date: Mon, 10 Oct 2011 07:23:29 -0400
Message-ID: <20111010112329.GB28627@infradead.org>
References: <1317875170-9349-1-git-send-email-sage@newdream.net>
 <1317875170-9349-2-git-send-email-sage@newdream.net>
 <20111006212118.GA24109@infradead.org>
 <Pine.LNX.4.64.1110061507550.29500@cobra.newdream.net>
 <20111010051141.GV3159@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111010051141.GV3159@dastard>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Sage Weil <sage@newdream.net>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, viro@ZenIV.linux.org.uk, ceph-devel@vger.kernel.org, rwheeler@redhat.com, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Oct 10, 2011 at 04:11:41PM +1100, Dave Chinner wrote:
> The code in the patch doesn't explain to me why you'd need to call
> dentry_lru_prune() rather than dentry_lru_del()? It's something to
> do with the difference between active and inactive LRU removal, but

Whenever we actually remove a object it needs to be removed, if it
only gets deleted from the LRU because it now has a reference and
doesn't belong onto the LRU it doesn't.

But yes, this really should be documented better in the code.
