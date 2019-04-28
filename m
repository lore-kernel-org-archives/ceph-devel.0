From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Sun, 28 Apr 2019 09:27:20 -0400
Message-ID: <7bac7ba5655a8e783a70f915853a0846e7ff143b.camel@kernel.org>
References: <20190425174739.27604-1-idryomov@gmail.com>
         <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
         <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
         <20190425200941.GW2217@ZenIV.linux.org.uk>
         <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
         <20190426165055.GY2217@ZenIV.linux.org.uk>
         <b175faae4bb98d3379a8642fe5f4e00587c3a734.camel@kernel.org>
         <20190428043801.GE2217@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190428043801.GE2217@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-cifs <linux-cifs@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Sun, 2019-04-28 at 05:38 +0100, Al Viro wrote:
> On Fri, Apr 26, 2019 at 01:30:53PM -0400, Jeff Layton wrote:
> 
> > > I _probably_ would take allocation out of the loop (e.g. make it
> > > __getname(), called unconditionally) and turned it into the
> > > d_path.c-style read_seqbegin_or_lock()/need_seqretry()/done_seqretry()
> > > loop, so that the first pass would go under rcu_read_lock(), while
> > > the second (if needed) would just hold rename_lock exclusive (without
> > > bumping the refcount).  But that's a matter of (theoretical) livelock
> > > avoidance, not the locking correctness for ->d_name accesses.
> > > 
> > 
> > Yeah, that does sound better. I want to think about this code a bit
> 
> FWIW, is there any reason to insist that the pathname is put into the
> beginning of the buffer?  I mean, instead of path + pathlen we might
> return path + offset, with the pathname going from path + offset to
> path + PATH_MAX - 1 inclusive, with path being the thing eventually
> freed.
> 
> It's easier to build the string backwards, seeing that we are walking
> from leaf to root...

(cc'ing linux-cifs)

I don't see a problem doing what you suggest. An offset + fixed length
buffer would be fine there.

Is there a real benefit to using __getname though? It sucks when we have
to reallocate but I doubt that it happens with any frequency. Most of
these paths will end up being much shorter than PATH_MAX and that slims
down the memory footprint a bit.

Also, FWIW -- this code was originally copied from cifs'
build_path_from_dentry(). Should we aim to put something in common
infrastructure that both can call?

There are some significant logic differences in the two functions though
so we might need some sort of callback function or something to know
when to stop walking.

-- 
Jeff Layton <jlayton@kernel.org>
