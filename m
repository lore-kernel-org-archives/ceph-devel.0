From: Sage Weil <sage@newdream.net>
Subject: local object storage changes
Date: Thu, 18 Feb 2010 13:12:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1002181246060.29308@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

The first thing added to the unstable tree now that 0.19 is out is some 
work to improve the object storage and journaling code.  The new approach 
is more flexible in terms of how you can utilize your available hardware 
on each storage node, and also removes the currently strict btrfs 
requirement.

First, a bit of history.  The original storage daemon used a userspace 
file system (ebofs) that was copy on write with frequent superblock 
commits (that would push all prior operations to disk).  Since a full 
commit could be somewhat slow (multiple disk seeks), a "write-behind" 
journal was added: a write was first applied to the local fs (ebofs), and 
then an entry was written to a journal.  If the journal entry committed to 
disk before ebofs did a full commit, we could ack sooner.  If the journal 
was slow, or it filled up, then we were no worse off, because we could 
still ack when the full commit happened.  The journal can be either a file 
or a raw block device.  A separate disk is good; an SSD or NVRAM device is 
better.  A file on another device works too, although it won't be quite as 
fast.

Then we dropped ebofs in favor of btrfs: it had more features, better 
testing, and (one hoped) better performance.  The problem was with 
commits: when a btrfs commit starts, new write operations block while the 
fs gets its ducks in a row to flush everything out to disk.  That means 
that cosd writes would block waiting to apply them to the fs (sometimes 
seconds), even though the journal device was otherwise idle (with typical 
latencies <10ms).

So, the new code decouples applying the writes (to the fs) and journaling 
entirely into different threadpools.  You can either operate in writeahead 
mode (journal, then apply), parallel mode (start both immediately), or the 
(old) writebehind mode (apply, then journal--not recommended).  The trick 
is that you have to apply before you can read back the change, and you 
have to commit before you can ack (usually). Since the commit and apply 
can complete in any order, lots of random code had to be changed to 
properly reflect what the read-what-i-just-wrote dependencies were, and 
some additional tracking of in-progres writes was needed.

There are two big wins here:

 * If you're using a journal (ideally a second device.. a raw disk, or 
ssd, or nvram), write latency will be consistently lower.  Any 
sluggishness from the fs doing it's commits won't have an immediate 
impact.

 * Btrfs isn't strictly required anymore for maintaining consistency.  
Previously, we used some btrfs ioctls to group operations together into 
transactions to ensure they would commit to disk as a unit.  With 
writeahead journaling, that's no longer necessary: we just replay 
everything in the journal that isn't known to have committed to the fs; 
any incorrectly duplicated operations are harmless.  The only requirement 
is that operations are ordered, as with ext3's data=ordered.

That said, btrfs is still preferred.  Ceph makes heavy use of xattrs, and 
many objects are small; given that workload the btrfs 
everything-in-a-btree approach should be a big win.  We also hook into 
btrfs to cheaply clone objects without copying actual data, which makes 
Ceph snapshots perform better.  (It'll still work with other file systems, 
but the object copy will be an actual copy, and slow.)

Using btrfs also means you can operate without a journal, which will work 
fine in cases where low latency writes aren't a requirement.

Anyway, these changes will get lots of testing in unstable over the next 
few weeks and will go into the next release (v0.20).

sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
