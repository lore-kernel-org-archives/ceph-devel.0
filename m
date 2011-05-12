From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/3] d_prune
Date: Wed, 11 May 2011 18:28:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105111826390.14263@cobra.newdream.net>
References: <1305164616-26597-1-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305164616-26597-1-git-send-email-sage@newdream.net>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@ZenIV.linux.org.uk, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, 11 May 2011, Sage Weil wrote:
> [half written email from wrong patch directory]

Hi Al, Christoph,

Once the dentry_unhash series is merged, the VFS won't be doing any
hashing or unhashing of dentries on behalf of file systems; that will
almost solely their responsibility the respective i_op and d_ops.

The one exception is dcache pruning.  Because this is something that is
out of the file system's direct control, it can't control the
consistently or completeness of the contents of the dcache.  This new
d_prune method will notify the fs prior to dropping a dentry so that it
can know whether the dcache contents are complete (say, for a given
directory) in a non-racy way.

The first patch simply adds a d_prune d_op.  The next two patches just
wire ceph up to use it (and can probably be ignored): the second patch
implements a method in Ceph to maintain a flag that indicates whether a
given directory's child list is complete, and the third converts
everything over to use the new flag instead of the old one (which was
racy and is currently disabled).

Al previously expressed reservations about imposing any new rules on the
dcache with respect to hashing/unhashing (or anything else) until the
code had been cleaned up.  At least as far as hashing goes, I think the
dcache behavior is now pretty clean on that front.  I also think it
makes sense intuitively that the VFS wouldn't be futzing around with
that on behalf of file systems, which leads me to believe this is a
reasonable new 'restriction'. Of course, I also need it to make my
caching work, so I'm a bit biased.  :)  Linus didn't hate it, at least
(that much count for something!).

Al, is this reasonable?  Is there something else specifically you would
like to see cleaned up before doing this?

Thanks!
sage
