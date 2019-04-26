From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
Date: Fri, 26 Apr 2019 22:28:45 +0100
Message-ID: <20190426212845.GC2217@ZenIV.linux.org.uk>
References: <20190425174739.27604-1-idryomov@gmail.com>
 <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk>
 <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
 <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
 <20190426170108.GZ2217@ZenIV.linux.org.uk>
 <fd4327a68e79540e9faee40bd198dfee373e59fb.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fd4327a68e79540e9faee40bd198dfee373e59fb.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Apr 26, 2019 at 04:49:24PM -0400, Jeff Layton wrote:

> Got it, thanks. Why use an atomic_t for the refcount if it's always
> accessed under spinlock?

_Which_ spinlock?  The whole reason for refcounts is that many dentries
might end up with shared external name.  So ->d_lock on one of them
won't do anything to accesses via another...

> > What I don't understand is why would anyone want to mess with
> > name snapshots for dentry_path() lookalikes...
> 
> Mostly because the place where the ceph code needs to use and free these
> strings is rather far removed from where they are created. It simplifies
> that part if we can access and free them all in the same way.
> 
> I was planning to just use name_snapshots universally for that purpose,
> but they have a rather specific method of freeing things that is hard to
> duplicate if you don't have a dentry to clone.
> 
> Probably that means I'm approaching this problem in the wrong way and
> need to do it differently.

For short names snapshot will put the copy into your variable, normally
on the stack frame.  So it doesn't really help if you want to keep that
stuff around.  Again, dentries with short names have those stored inside
the dentry and for anything long-term you will need to copy that data;
otherwise rename() will happily change those under you.

If you want to deal with pathnames, do __getname() + a loop similar to
that in dentry_path() et.al.  All there is to it.  Snapshots are
for situations when you want a reasonably short-term access to
name of specific dentry you have a reference to and do not want
to do any allocations.
