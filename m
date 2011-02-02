From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: rbd layering
Date: Tue, 1 Feb 2011 23:13:34 -0800
Message-ID: <AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
References: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60588 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab1BBHNh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 02:13:37 -0500
Received: by fxm20 with SMTP id 20so7696599fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 23:13:35 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 31, 2011 at 10:08 PM, Sage Weil <sage@newdream.net> wrote:
> One idea we've talked a fair bit about is layering RBD images. =A0The=
 idea
> would be to create a new image in O(1) time that mirrors on old image=
 and
> get copy-on-write type semantics, like a writeable snapshot.
>
> We've come up with a few different approaches for doing this, each wi=
th
> somewhat different performance characteristics. =A0The main considera=
tion is
> that RBD images do not (currently) have an "allocation table." =A0Ima=
ge data
> is simply striped over objects (that may or may not exist). =A0You re=
ad the
> object for a given block to see if it exists; if it doesn't (a "hole"=
),
> the content is defined to be zero-filled.

Have we thought about the hash table based approach yet? Where every
block gets hashed and we only store one copy for each? I guess this is
basically how git works, except instead of fixed-size blocks, it
tracks variable-sized blobs. This is also how ZFS dedupe works.

The nice thing about the hash table based approach is that you don't
have to track parent-child relationships explicitly. If two users
happen to both install Centos 5.5 with the same settings on the same
sized-image, they'll both be deduped automatically.

The disadvantage, of course, is that you need to hash the blocks.
Also, there's some tiny probability that there will be a hash
collision. You could use a long hash key or do hash chaining to
mitigate this, of course.

The big disadvantage of the allocation table-based approaches, at
least in my mind, is that they don't feel very block device-y.
Allocation maps are things that normally go in a file system rather
than in a block device.

If we do go with an allocation-table based approach, what would the
API look like from the administrator's point of view? I guess I
imagine some kind of API where I create a child RBD block device from
a parent RBD device. Then whenever I wrote to the child image, it
would "re-dupe" the two block devices. (It seems like the amount of
sharing would start at 100% and just go down from there... unless my
analysis is missing something?)

Another possibility is that we could simply run qcow2 over rbd. qcow2
already implements copy-on-write at a higher level of the stack.

I took a quick look at the qcow2 image format at:
http://people.gnome.org/~markmc/qcow-image-format.html

It looks suspiciously like something I've seen before :)
http://en.wikipedia.org/wiki/Inode_pointer_structure

sincerely,
Colin


>
> (I'll use the term "block" and "object" interchangeably to mean the o=
bject
> that stores each RBD block. =A0They're 4MB by default, but can be set=
 to any
> size you want at image creation time.)
>
> 1- copy-up on first write
> =A0- reads
> =A0 =A0- read child image object. =A0if it doesn't exist, read parent=
 block.
> =A0 =A0-> reads to unchanged data are slower
> =A0- writes
> =A0 =A0- write to child image block. =A0if it doesn't exist, OSD will=
 return
> =A0 =A0 =A0ENOENT. =A0the client would do a copy up (copy parent bloc=
k to child
> =A0 =A0 =A0block), and then redo the write.
> =A0 =A0-> first writes are slow, especially if the block existed in t=
he parent.
> =A0- trim/discard
> =A0 =A0- truncate the child object to zero, but do not delete it.
>
> 2- sparse objects
> =A0- make the OSDs maintain allocation metadata for each objects so t=
hat we
> =A0 =A0know which parts of the object are defined and which are holes=
 (a
> =A0 =A0relatively easy thing to do).
> =A0- writes
> =A0 =A0- write to modified region of child object.
> =A0- reads
> =A0 =A0- read child image object AND allocation map. =A0read parent o=
bject for
> =A0 =A0 =A0any holes (or when child object doesn't exist)
> =A0 =A0-> more efficient data transfer when objects are sparse.
> =A0 =A0-> reads to unchanged data are slower (as above)
> =A0- trim/discard
> =A0 =A0- need to somehow distinguish between a hole that falls-thru t=
o parent
> =A0 =A0 =A0and a hole that is defined to be zero by the child image.
>
> In both cases, we could add a(n optional) allocation bitmap to the pa=
rent
> image to avoid the fall-thru for parts of the images that aren't defi=
ned
> by the child image. =A0That could be an explicit step taken by an
> adminstrator (e.g. after marking the parent read-only) to improve
> performance for overlayed images. =A0(Maintaining a consistent bitmap=
 for
> all images is non-trivial, and would slow things down considerably.)
>
> A few use cases for all of this:
> =A0- "golden" VM images
> =A0- writeable snapshots
> =A0- image migration between pools
> =A0 - pause io
> =A0 - mark parent read-only
> =A0 - create "child" image
> =A0 - unpause io, redirect to the new child
> =A0 (these steps are all fast and O(1)!)
> =A0 - asynchronously copy-up parent blocks to the child (this is O(n)=
)
> =A0 - once this is done, remove the child's parent reference and disc=
ard
> =A0 =A0 the parent
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
