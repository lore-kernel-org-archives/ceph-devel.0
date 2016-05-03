From: Marcus Watts <mwatts@redhat.com>
Subject: Re: rocksdb related build error
Date: Tue, 3 May 2016 18:58:52 -0400
Message-ID: <20160503225852.GA17962@degu.b.linuxbox.com>
References: <CAF1ivSbg-n6o2_mHzCS_Y9rDZTD+ySess8TqOto-ox7MV012bA@mail.gmail.com>
 <alpine.DEB.2.11.1605030824500.26967@cpach.fuggernut.com>
 <CAF1ivSZ_wxv9SkGkpw3ry7Bt9+HYBse=BZ+WysPLPFD3we=fNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756824AbcECW6z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 May 2016 18:58:55 -0400
Content-Disposition: inline
In-Reply-To: <CAF1ivSZ_wxv9SkGkpw3ry7Bt9+HYBse=BZ+WysPLPFD3we=fNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ming Lin <minggr@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, John Spray <john.spray@redhat.com>

On Tue, May 03, 2016 at 02:15:49PM -0700, Ming Lin wrote:
> On Tue, May 3, 2016 at 5:26 AM, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 3 May 2016, Ming Lin wrote:
> >> Hi John,
> >>
> >> I got rocksdb related build error (commit bb7d9c15).
> >> Any hint to fix it?
> >>
> >> It's OK if I build in the ceph source tree.
> >
> > Out of tree builds don't work currently with autotools.
> 
> I just learned a bit about autotools.
> https://en.wikipedia.org/wiki/GNU_Build_System
> 
> Could you share what the problem is here to support out-of-tree build?
> I'll try to write a patch to fix it.

I looked at this fairly recently.

rocksdb comes with a cmake (only used for windows), and makefile build.
The makefile build doesn't use autotools, it's just a gnu makefile.
gnu make does support out of tree builds, but the rocksdb file doesn't
do that.  So, it wants to find all its source wherever it's installed,
and it puts all the .o's in the same place - So: no separate build possible.
This is a problem for both automake & cmake.

You could change the makefile to work "out of tree", but it won't
be pretty.  Probably you would be adding some "VPATH" statements,
add -I as necessary, and you'd have to work within the structure
of the file which I think seemed a bit more complicated than necessary.

You could switch to using a more regular "auto tools" build.  There are
lots of choices here.  Also some drawbacks, so this won't be the fastest
approach.  Will work and is fairly standard.  You will definitely know a
lot more about automake when you get through with this.  Also rocksdb is
actually be a pretty good starting point to learn this.

You could fix up the cmake stuff to work with unix instead.  This will
be way faster than cobbling up automake.  Especially because you
can just steal my work.  Uh, here,
	http://people.redhat.com/mwatts/rocksdb/

It should quite easy to plug rocskdb + cmake into ceph.  And I suppose
you could build rocskdb using cmake even if you were building ceph
with automake - won't be (much) worse than what's happening today with
the makefile.

But, after I got to this point with rocksdb, I decided that instead
of teaching ceph how to build rocksdb in tree, I could just install
it separately.  The web page above has sample rpm's for just this.
I called the resulting packages just "rocksdb" - but the discussion
folks had about this on ceph was towards the direction of packages
named "ceph-rocksdb".

I also have some changes for ceph to make it work with the
externally installed rocksdb,
	https://github.com/mdw-at-linuxbox/ceph/commit/a753c5619c916214a80c200fb46c38a09b191647

This is probably down a different direction than you want to go, but
feel free to use any bits that are useful and ignore what isn't.

					-Marcus Watts
