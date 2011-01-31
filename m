From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: some thoughts about scrub
Date: Mon, 31 Jan 2011 15:11:52 -0700
Message-ID: <1296511912.23762.205.camel@sale659.sandia.gov>
References: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:40878 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab1AaWMC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jan 2011 17:12:02 -0500
In-Reply-To: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Colin,

On Mon, 2011-01-31 at 13:56 -0700, Colin McCabe wrote:
> I was thinking a little bit about OSD scrub and I wanted to share my
> thoughts with you guys.
> 
> OSD Scrub is the process of reconciling files stored on one instance
> of cosd with those stored on another. Each file represents an object
> in the ObjectStore. So why would files be different on different
> cosds? As I see it, there are three cases:
> 
> Case #1:
> The hard disk where that the FileStore is reading from could be dying.
> In my experience, hard disks that are dying will tend to experience
> long delays in reading from the filesystem. Occasionally you will be
> unable to read some files, and you'll get EIO instead. When a hard
> disk is dying, all you want to do is get your data off there as soon
> as possible. You don't want to bother trying to "fix" the files on the
> disk. That disk is toast.
> 
> Case #2:
> Another reason is because the filesystem could be slightly corrupt.
> This could happen, for example, if the computer lost power without
> properly unmounting its filesystems. The usual remedy in these cases
> is to run fsck.
> 
> ext3 and ext4 have working fsck commands that can usually fix what
> ails your filesystem. Unfortunately, the fixed filesystem may lack
> some of the data you used to have. I have often seen files truncated
> to 0-length after running ext3's fsck.
> 
> Although btrfs does not have a fsck that can fix errors, it does have
> data checksumming. This means that the chances that a random disk
> error will go undetected are basically zero.
> 
> Case #3:
> There could be a bug in btrfs, ext4, or Ceph that has caused the data
> to diverge between different cosd nodes.
> 
> 
> So the question is really: what should our OSD scrub code do?
> 
> In case #1, I don't really want to repair the disk. I just want to
> become aware of the problem, so I can send someone out to replace the
> failing hard disk.
> 
> In case #3, I probably don't want to repair things either. If I am
> testing code, a repair mechanism that hides Ceph bugs just makes it
> harder to create a good test. If I am in production, any mechanism
> that causes bugs to generate a bunch of I/O will probably lead to
> unhappiness. If there's a btrfs bug on your node, doing a bunch of I/O
> with that btrfs partition will probably just make things worse.
> 
> So we're left with case #2. The case where the filesystem is slightly
> corrupt. The question you really have to ask yourself in this case is:
> what is faster, running fsck on the corrupt filesystem, or
> reformatting and using Ceph to synchronize everything over?
> 
> Also keep in mind that, again, btrfs doesn't have fsck. I suspect that
> checksum failures will return EIO, which looks a lot like case #1 to
> the hapless sysadmin.
> 
> 
> Here's what I think:
> * Repairing FileStores might be a lot less useful than we originally
> thought. Notifying the sysadmin about file errors might be a lot more
> useful than we originally thought. We should have a configuration
> option for scrub that makes it just note errors, but not initiate
> repair.
> 
> * If we absolutely must repair a filestore, but only have 2x
> replication, we might consider the FileStore whose underlying FS has
> been fsck'ed most recently to be the non-authoritative one.
> 
> what do you think?

So I have a couple thoughts.

My understanding/experience on disk failure is that there is a class
of failure where individual sectors cannot be read, for some reason.

When the OS tries to read such a sector, the disk firmware "knows"
the read has failed, and kicks off a recovery process which includes
repeated read attempts, recalibrating the head, etc.  During this time
the disk does nothing else.  The time allotted for such recovery is
tunable on some drives.  Eventually some sort of error gets passed
up the call stack.  This can take several minutes.

Most drives have some spare sectors that they internally remap over
bad sectors.  Such a bad sector can be "healed" by rewriting that
LBA, because the drive will internally remap it.  You can use
smartctl on drives that support it to learn how many sectors have
had read errors, of both the recoverable and unrecoverable variety,
I think, and also how many spare sectors are remaining.

So one of the things I'd really like Ceph scrub to do when it is
reading every one of its objects is rewrite the ones on which it
gets read errors, by fetching one of its other copies.  Maybe it
already does this?  If Ceph scrub works this way, then another
thing I really want to do is learn to tell my disks to not try 
so hard to recover a sector, as I know I have at least one other 
copy I can use to repair it, and because that minimizes the time
that osd is stalled.

Then, if I'm paying attention to smartctl results for my drives,
I'll see which ones have only a few spare sectors left, and
replace them before they can fail (i.e. have no spare sectors
remaining).

Note that if I don't rewrite such a bad LBA, then any time
I attempt to read it I trigger a long stall while the drive
attempts recovery.  I really don't want this.

If such a bad sector is used for btrfs metadata, well, AFAIK
btrfs duplicates its metadata by default (see mkfs.btrfs -m single).
Presumably if it gets a metadata read failure it will rewrite the
offending sectors using its other copy?  If not, we should try
to convince the btrfs devs to do so.

To recap, 
case #1 - if the failure is a read failure on an object, I want
Ceph scrub to rewrite the object using one of its other copies.

case #2 - no opinion; as long as Ceph warns me the object
store has an underlying fs failure, I'm happy to rebuild it.

case #3 - I agree, don't paper over underlying bugs.

Thanks for asking.

-- Jim

> 
> cheers,
> Colin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


