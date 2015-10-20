From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: newstore direction
Date: Tue, 20 Oct 2015 16:42:54 -0400 (EDT)
Message-ID: <888344827.35094163.1445373774060.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net> <CALe9h7dUQcp6zOSFDfnXSQo4VOTObFCWj+HD-idwE1nNzQVsgA@mail.gmail.com> <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:52792 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbJTUmy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Oct 2015 16:42:54 -0400
In-Reply-To: <alpine.DEB.2.00.1510201251140.16833@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

We mostly assumed that sort-of transactional file systems, perhaps hosted in user space was the most tractable trajectory.  I have seen newstore and keyvalue store as essentially congruent approaches using database primitives (and I am interested in what you make of Russell Sears).  I'm skeptical of any hope of keeping things "simple."  Like Martin downthread, most systems I havce seen (filers, ZFS)) make use of a fast, durable commit log and then flex out...something else.

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309


----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "John Spray" <jspray@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, October 20, 2015 4:00:23 PM
> Subject: Re: newstore direction
> 
> On Tue, 20 Oct 2015, John Spray wrote:
> > On Mon, Oct 19, 2015 at 8:49 PM, Sage Weil <sweil@redhat.com> wrote:
> > >  - We have to size the kv backend storage (probably still an XFS
> > > partition) vs the block storage.  Maybe we do this anyway (put metadata
> > > on
> > > SSD!) so it won't matter.  But what happens when we are storing gobs of
> > > rgw index data or cephfs metadata?  Suddenly we are pulling storage out
> > > of
> > > a different pool and those aren't currently fungible.
> > 
> > This is the concerning bit for me -- the other parts one "just" has to
> > get the code right, but this problem could linger and be something we
> > have to keep explaining to users indefinitely.  It reminds me of cases
> > in other systems where users had to make an educated guess about inode
> > size up front, depending on whether you're expecting to efficiently
> > store a lot of xattrs.
> > 
> > In practice it's rare for users to make these kinds of decisions well
> > up-front: it really needs to be adjustable later, ideally
> > automatically.  That could be pretty straightforward if the KV part
> > was stored directly on block storage, instead of having XFS in the
> > mix.  I'm not quite up with the state of the art in this area: are
> > there any reasonable alternatives for the KV part that would consume
> > some defined range of a block device from userspace, instead of
> > sitting on top of a filesystem?
> 
> I agree: this is my primary concern with the raw block approach.
> 
> There are some KV alternatives that could consume block, but the problem
> would be similar: we need to dynamically size up or down the kv portion of
> the device.
> 
> I see two basic options:
> 
> 1) Wire into the Env abstraction in rocksdb to provide something just
> smart enough to let rocksdb work.  It isn't much: named files (not that
> many--we could easily keep the file table in ram), always written
> sequentially, to be read later with random access. All of the code is
> written around abstractions of SequentialFileWriter so that everything
> posix is neatly hidden in env_posix (and there are various other env
> implementations for in-memory mock tests etc.).
> 
> 2) Use something like dm-thin to sit between the raw block device and XFS
> (for rocksdb) and the block device consumed by newstore.  As long as XFS
> doesn't fragment horrifically (it shouldn't, given we *always* write ~4mb
> files in their entirety) we can fstrim and size down the fs portion.  If
> we similarly make newstores allocator stick to large blocks only we would
> be able to size down the block portion as well.  Typical dm-thin block
> sizes seem to range from 64KB to 512KB, which seems reasonable enough to
> me.  In fact, we could likely just size the fs volume at something
> conservatively large (like 90%) and rely on -o discard or periodic fstrim
> to keep its actual utilization in check.
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
