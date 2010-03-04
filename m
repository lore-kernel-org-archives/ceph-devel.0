From: Sage Weil <sage@newdream.net>
Subject: Re: build fails on centos 5
Date: Thu, 4 Mar 2010 08:18:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003040808250.28379@cobra.newdream.net>
References: <hmo8e2$lnv$1@dough.gmane.org>
	<Pine.LNX.4.64.1003040707500.28379@cobra.newdream.net>
	<hmokna$lnv$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <hmokna$lnv$2@dough.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

On Thu, 4 Mar 2010, Thomas Mueller wrote:
> Am Thu, 04 Mar 2010 07:11:00 -0800 schrieb Sage Weil:
> > Hi Thomas,
> > 
> > On Thu, 4 Mar 2010, Thomas Mueller wrote:
> >> /usr/src/ceph-0.19.1/src/os/FileStore.cc:928: undefined reference to
> >> `sync_file_range' libos.a(FileStore.o): In function
> >> `FileStore::flusher_entry()':
> > 
> > sync_file_range() appeared in 2.6.17.  It sounds like CentOS 5 was based
> > on an older kernel.  Since your kernel is new, a recent glibc is
> > probably all you need to get things going.
> 
> original centos kernel is 2.6.18. anyhow, i found a RHEL bug (which 
> centos is based on):
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=518581
> 
> comment #1 from this bug:
> It has only been added to glibc 2.6, and cannot be backported due to ABI
> breakage.  You can always fall back to syscall(3).    
> 
> so, RHEL/CentOS 5 will never support this directly. 

Ah, makes sense.
 
> what about implementing the mentioned "syscall(3)" workaround for RHEL/
> CentOS?

I can add a check in configure.ac for sync_file_range(3) in the unstable 
branch.  In the meantime, the easiest thing would be to just replace 
those lines with a call to fdatasync() (or leave them off entirely in 
os/FileStore.cc, where it's purely an optimization).

sage



diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
index 639b7d7..e11e092 100644
--- a/src/os/FileJournal.cc
+++ b/src/os/FileJournal.cc
@@ -544,15 +544,18 @@ void FileJournal::do_write(bufferlist& bl)
     ::fsync(fd);
 #else
     if (is_bdev) {
-      if (split) {
+      ::fdatasync(fd);
+      /*if (split) {
 	::sync_file_range(fd, header.max_size - split, split, SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE);
 	::sync_file_range(fd, get_top(), bl.length() - split, SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE);
 	::sync_file_range(fd, header.max_size - split, split, SYNC_FILE_RANGE_WAIT_AFTER);
 	::sync_file_range(fd, get_top(), bl.length() - split, SYNC_FILE_RANGE_WAIT_AFTER);
+
       } else {
 	::sync_file_range(fd, write_pos, bl.length(),
 			  SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER);
       }
+	*/
     } else
       ::fdatasync(fd);
 #endif
diff --git a/src/os/FileStore.cc b/src/os/FileStore.cc
index 8dd7998..1f511c4 100644
--- a/src/os/FileStore.cc
+++ b/src/os/FileStore.cc
@@ -1327,8 +1327,8 @@ int FileStore::_write(coll_t cid, const sobject_t& oid,
 
     if (!g_conf.filestore_flusher ||
 	!queue_flusher(fd, offset, len)) {
-      if (g_conf.filestore_sync_flush)
-	::sync_file_range(fd, offset, len, SYNC_FILE_RANGE_WRITE);
+      /*if (g_conf.filestore_sync_flush)
+	::sync_file_range(fd, offset, len, SYNC_FILE_RANGE_WRITE);*/
       ::close(fd);
     }
     r = did;
@@ -1508,7 +1508,7 @@ void FileStore::flusher_entry()
 	q.pop_front();
 	if (!stop && ep == sync_epoch) {
 	  dout(10) << "flusher_entry flushing+closing " << fd << " ep " << ep << dendl;
-	  ::sync_file_range(fd, off, len, SYNC_FILE_RANGE_WRITE);
+	  //::sync_file_range(fd, off, len, SYNC_FILE_RANGE_WRITE);
 	} else 
 	  dout(10) << "flusher_entry JUST closing " << fd << " (stop=" << stop << ", ep=" << ep
 		   << ", sync_epoch=" << sync_epoch << ")" << dendl;


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
