From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: some thoughts about scrub
Date: Mon, 31 Jan 2011 12:56:36 -0800
Message-ID: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42635 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab1AaU63 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jan 2011 15:58:29 -0500
Received: by fxm20 with SMTP id 20so6046418fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jan 2011 12:58:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I was thinking a little bit about OSD scrub and I wanted to share my
thoughts with you guys.

OSD Scrub is the process of reconciling files stored on one instance
of cosd with those stored on another. Each file represents an object
in the ObjectStore. So why would files be different on different
cosds? As I see it, there are three cases:

Case #1:
The hard disk where that the FileStore is reading from could be dying.
In my experience, hard disks that are dying will tend to experience
long delays in reading from the filesystem. Occasionally you will be
unable to read some files, and you'll get EIO instead. When a hard
disk is dying, all you want to do is get your data off there as soon
as possible. You don't want to bother trying to "fix" the files on the
disk. That disk is toast.

Case #2:
Another reason is because the filesystem could be slightly corrupt.
This could happen, for example, if the computer lost power without
properly unmounting its filesystems. The usual remedy in these cases
is to run fsck.

ext3 and ext4 have working fsck commands that can usually fix what
ails your filesystem. Unfortunately, the fixed filesystem may lack
some of the data you used to have. I have often seen files truncated
to 0-length after running ext3's fsck.

Although btrfs does not have a fsck that can fix errors, it does have
data checksumming. This means that the chances that a random disk
error will go undetected are basically zero.

Case #3:
There could be a bug in btrfs, ext4, or Ceph that has caused the data
to diverge between different cosd nodes.


So the question is really: what should our OSD scrub code do?

In case #1, I don't really want to repair the disk. I just want to
become aware of the problem, so I can send someone out to replace the
failing hard disk.

In case #3, I probably don't want to repair things either. If I am
testing code, a repair mechanism that hides Ceph bugs just makes it
harder to create a good test. If I am in production, any mechanism
that causes bugs to generate a bunch of I/O will probably lead to
unhappiness. If there's a btrfs bug on your node, doing a bunch of I/O
with that btrfs partition will probably just make things worse.

So we're left with case #2. The case where the filesystem is slightly
corrupt. The question you really have to ask yourself in this case is:
what is faster, running fsck on the corrupt filesystem, or
reformatting and using Ceph to synchronize everything over?

Also keep in mind that, again, btrfs doesn't have fsck. I suspect that
checksum failures will return EIO, which looks a lot like case #1 to
the hapless sysadmin.


Here's what I think:
* Repairing FileStores might be a lot less useful than we originally
thought. Notifying the sysadmin about file errors might be a lot more
useful than we originally thought. We should have a configuration
option for scrub that makes it just note errors, but not initiate
repair.

* If we absolutely must repair a filestore, but only have 2x
replication, we might consider the FileStore whose underlying FS has
been fsck'ed most recently to be the non-authoritative one.

what do you think?

cheers,
Colin
