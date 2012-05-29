From: Sage Weil <sage@inktank.com>
Subject: Re: OSD deadlock with cephfs client and OSD on same machine
Date: Tue, 29 May 2012 08:47:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205290836350.14433@cobra.newdream.net>
References: <201205290944.33983.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38128 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab2E2Prj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 11:47:39 -0400
In-Reply-To: <201205290944.33983.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 29 May 2012, Amon Ott wrote:
> Hello again!
> 
> On Linux, if you run OSD on ext4 filesystem, have a cephfs kernel client mount 
> on the same system and no syncfs system call (as to be expected with libc6 < 
> 2.14 or kernel < 2.6.39), OSD deadlocks in sys_sync(). Only reboot recovers 
> the system.
> 
> After some investigation in the code, this is what I found:
> In src/common/sync_filesystem.h, the function sync_filesystem() first tries a 
> syncfs() (not available), then a btrfs ioctrl sync (not available with 
> non-btrfs), then finally a sync(). sys_sync tries to sync all filesystems, 
> including the journal device, the osd storage area and the cephfs mount. 
> Under some load, when OSD calls sync(), cephfs sync waits for the local osd, 
> which already waits for its storage to sync, which the kernel wants to do 
> after the cephfs sync. Deadlock.
> 
> The function sync_filesystem() is called by FileStore::sync_entry() in 
> src/os/FileStore.cc, but only on non-btrfs storage and if 
> filestore_fsync_flushes_journal_data is false. After forcing this to true in 
> OSD config, our test cluster survived three days of heavy load (and still 
> running fine) instead of deadlocking all nodes within an hour. Reproduced 
> with 0.47.2 and kernel 3.2.18, but the related code seems unchanged in 
> current master.
> 
> Conclusion: If you want to run OSD and cephfs kernel client on the same Linux 
> server and have a libc6 before 2.14 (e.g. Debian's newest in experimental is 
> 2.13) or a kernel before 2.6.39, either do not use ext4 (but btrfs is still 
> unstable) or risk data loss by missing syncs through the workaround of 
> forcing filestore_fsync_flushes_journal_data to true.

Note that fsync_flushed_journal_data should only be set to true with ext3 
and the 'data=ordered' or 'data=journal' mount option.  It is an 
implementation artifact only that fsync() will flush all previous writes.

> Please consider putting out a fat warning at least at build time, if syncfs() 
> is not available, e.g. "No syncfs() syscall, please expect a deadlock when 
> running osd on non-btrfs together with a local cephfs mount." Even better 
> would be a quick runtime test for missing syncfs() and storage on non-btrfs 
> that spits out a warning, if deadlock is possible.

I think a runtime warning makes more sense; nobody will see the build time 
warning (e.g., those installed debs).

> As a side effect, the experienced lockup seems to be a good way to reproduce 
> the long standing bug 1047 - when our cluster tried to recover, all MDS 
> instances died with those symptoms. It seems that a partial sync of journal 
> or data partition causes that broken state.

Interesting!  If you could also note on that bug what the metadata 
workload was (what was making hard links?), that would be great!

Thanks-
sage

