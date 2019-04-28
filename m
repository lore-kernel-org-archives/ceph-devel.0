From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Sun, 28 Apr 2019 15:48:50 +0100
Message-ID: <20190428144850.GA23075@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
 <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk>
 <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
 <20190426165055.GY2217@ZenIV.linux.org.uk>
 <b175faae4bb98d3379a8642fe5f4e00587c3a734.camel@kernel.org>
 <20190428043801.GE2217@ZenIV.linux.org.uk>
 <7bac7ba5655a8e783a70f915853a0846e7ff143b.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7bac7ba5655a8e783a70f915853a0846e7ff143b.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-cifs <linux-cifs@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Sun, Apr 28, 2019 at 09:27:20AM -0400, Jeff Layton wrote:

> I don't see a problem doing what you suggest. An offset + fixed length
> buffer would be fine there.
> 
> Is there a real benefit to using __getname though? It sucks when we have
> to reallocate but I doubt that it happens with any frequency. Most of
> these paths will end up being much shorter than PATH_MAX and that slims
> down the memory footprint a bit.

AFAICS, they are all short-lived; don't forget that slabs have cache,
so in that situation allocations are cheap.

> Also, FWIW -- this code was originally copied from cifs'
> build_path_from_dentry(). Should we aim to put something in common
> infrastructure that both can call?
> 
> There are some significant logic differences in the two functions though
> so we might need some sort of callback function or something to know
> when to stop walking.

Not if you want it fast...  Indirect calls are not cheap; the cost of
those callbacks would be considerable.  Besides, you want more than
"where do I stop", right?  It's also "what output do I use for this
dentry", both for you and for cifs (there it's "which separator to use",
in ceph it's "these we want represented as //")...

Can it be called on detached subtree, during e.g. open_by_handle()?
There it can get really fishy; you end up with base being at the
random point on the way towards root.  How does that work, and if
it *does* work, why do we need the whole path in the first place?

BTW, for cifs there's no need to play with ->d_lock as we go.  For
ceph, the only need comes from looking at d_inode(), and I wonder if
it would be better to duplicate that information ("is that a
snapdir/nosnap") into dentry iself - would certainly be cheaper.
OTOH, we are getting short on spare bits in ->d_flags...
