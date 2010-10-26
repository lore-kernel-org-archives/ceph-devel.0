From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: ceph and large xattrs
Date: Tue, 26 Oct 2010 14:12:06 -0700
Message-ID: <AANLkTinaE=fT2r7Duwdkv7VThZ=yzOuxgJuXN5Pa-F=8@mail.gmail.com>
References: <AANLkTi=nT8w7suredVJx+Acopfdr=JL7O04x-3V5tfng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40511 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758534Ab0JZVMI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Oct 2010 17:12:08 -0400
Received: by eye27 with SMTP id 27so5761288eye.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Oct 2010 14:12:06 -0700 (PDT)
In-Reply-To: <AANLkTi=nT8w7suredVJx+Acopfdr=JL7O04x-3V5tfng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>, ceph-devel@vger.kernel.org

We recently hit an issue with xattrs on different underlying
filesystems. The basic problem is that we use xattrs for various
metadata information that we attach to the different objects, and for
some cases it tends to grow to relatively large sizes. It appears that
the various underlying filesystems that we currently use (btrfs, ext3,
ext4) have some limits on the xattrs sizes. For ext3/4 the total sizes
of all xattrs on a single file is limited and can't go beyond a single
block (e.g., typically 4k), whereas in btrfs, the limitation is per
each xattr but not globally. This problem was discovered as we changed
some error handling code, which previously just ignored those issues
and now crashed the osds in a very noticeable way.
For btrfs we've worked around the problem by splitting larger xattrs
into chunks, so that we never write a large xattr that the underlying
filesystem can't digest. For ext3/4 this can't really work, as there
is a total maximum limit that can be used on a single file, so
splitting doesn't help there.

The best solution for this problem, is just having it fixed on ext4,
however, at this point it's not something that we want to dive into.
Another solution to this problem would be by having a separate file
that holds the metadata, or at least the parts of the metadata that
wouldn't fit the xattrs. This is not an optimal solution, as it will
add complexity to the filestore layer, and slows it down. There is
more than just reading/writing xattrs for a single object, and we'd
need to handle operations like object cloning/snapshotting/removal,
etc. There will be another file to take care of for each object, and
it has its complexities.
A possible workaround would be to just identify the specific cases
where the xattrs inflate and to work around these cases, but it isn't
an optimal solution.

As Sage pointed out on the 0.22.1 release notes, at this point we
partially reverted to the silent-ignore handling on ext3/4 so that we
don't crash the osds when we hit that. It seems we only hit that on
specific cases where we think it is safe, as we only saw it on stray
directories that aren't going to be read anyway. But there is still a
lingering problem. A user that sets large xattrs via librados or
through the rados gateway will hit the same issues.

Ted, is this is a set ext4 problem that isn't going to change in the
future? It'll help us to know on what solution to focus our efforts
on.

Yehuda
