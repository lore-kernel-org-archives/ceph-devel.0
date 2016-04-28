From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Help with understanding throttle.finish()
Date: Thu, 28 Apr 2016 20:15:49 +0200
Message-ID: <57225355.3040401@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:55832 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbcD1SQU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Apr 2016 14:16:20 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 13E48153413
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 20:16:17 +0200 (CEST)
Received: from [IPv6:2001:4cb8:3:1:f473:542e:9337:7a5f] (unknown [IPv6:2001:4cb8:3:1:f473:542e:9337:7a5f])
	by smtp.digiware.nl (Postfix) with ESMTP id 81181153401
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 20:15:56 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm running a rather simple setup on my FreeBSD port.

function TEST_simple() {
     # run the most simple config, and run a bechmark on it.
     local dir=$1

     run_mon $dir a || return 1
     run_osd $dir 0 || return 1

     #
     # default values should work
     #
     ceph tell osd.0 bench || return 1

}

This in the end crashes with:
     8059eec00 -1 FileStore: sync_entry timed out after 600 seconds.
exactly 10 minutes after startup.
This trhread does just about exactly nothing, it initialises the time, 
and then traps after 10 minutes.
# grep 8059eec00  testdir/osd-bench/osd.0.log
2016-04-28 19:51:44.444689 8059eec00 -1 FileStore: sync_entry timed out 
after 600 seconds.
2016-04-28 19:51:44.487104 8059eec00 -1 os/filestore/FileStore.cc: In 
function 'virtual void SyncEntryTimeout::finish(int)' thread 8059eec00 time

I've augmented just about every line of code in src/os/filestore/File*.cc

And I get as far as
	throttle.flush()
It seems to work the first time it gets called. That is, it returns.

However the second time is "stalls" in the call
	 throttle.put(to_put_bytes);
after a number of itterations thru the while-loop.

Below the code of Throttle::Flush and an sequence of the thread doing 
the blocking call
from the log where I've added mode debugging code.

Does anybody have a clue as to continue from here?
   Why does throttle.put not return?
   Is it just throttleing too hard and not reorganising the queue?

--WjW

Code:
std::pair<uint64_t, uint64_t> JournalThrottle::flush(uint64_t mono_id)
{
   uint64_t to_put_bytes = 0;
   uint64_t to_put_ops = 0;
   std::pair<uint64_t, uint64_t> ret;
   {
     locker l(lock);
     while (!journaled_ops.empty() &&
            journaled_ops.front().first <= mono_id) {
       to_put_bytes += journaled_ops.front().second;
       to_put_ops++;
       journaled_ops.pop_front();
     }
   }
   throttle.put(to_put_bytes);
   ret = make_pair(to_put_ops, to_put_bytes);
   return ret;
}

Thread log:
2016-04-28 19:41:43.231410 8059ec900 20 filestore(testdir/osd-bench/0) 
sync_entry(1:1) waiting for max_interval 5.000000
2016-04-28 19:41:43.231438 8059ec900 20 filestore(testdir/osd-bench/0) 
sync_entry(1:1) started at: 2016-04-28 19:41:43.231436
2016-04-28 19:41:44.395763 8059ec900 20 filestore(testdir/osd-bench/0) 
sync_entry(1:1) ended at: 2016-04-28 19:41:44.395758
2016-04-28 19:41:44.395781 8059ec900 20 filestore(testdir/osd-bench/0) 
sync_entry(1:1) waited for 1
2016-04-28 19:41:44.395789 8059ec900 20 filestore(testdir/osd-bench/0) 
sync_entry(1:1) woke after 1.164433
2016-04-28 19:41:44.395795 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3726
2016-04-28 19:41:44.395801 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3730
2016-04-28 19:41:44.395806 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3733
2016-04-28 19:41:44.400570 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3735 starting apply_manager.commit_start()
2016-04-28 19:41:44.400584 8059ec900 10 journal commit_start 
max_applied_seq 32, open_ops 0
2016-04-28 19:41:44.400588 8059ec900 10 journal commit_start blocked, 
all open_ops have completed
2016-04-28 19:41:44.400591 8059ec900 10 journal commit_start committing 
32, still blocked
2016-04-28 19:41:44.400596 8059ec900 10 journal FileJournal commit_start
2016-04-28 19:41:44.400599 8059ec900 10 journal commit_start 
FULL_NOTFULL.  All good.
2016-04-28 19:41:44.400602 8059ec900 10 journal 
apply_manager.commit_start() returning 1
2016-04-28 19:41:44.400605 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3738 done(true) apply_manager.commit_start()
2016-04-28 19:41:44.400637 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3743
2016-04-28 19:41:44.400643 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3745
2016-04-28 19:41:44.400653 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3748
2016-04-28 19:41:44.400673 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3750
2016-04-28 19:41:44.400680 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) 3752
2016-04-28 19:41:44.400685 8059ec900 15 filestore(testdir/osd-bench/0) 
sync_entry(1:1) committing 32
2016-04-28 19:41:44.400701 8059ec900 10 journal commit_started 
committing 32, unblocking
2016-04-28 19:41:44.400728 8059ec900 20 filestore dbobjectmap: seq is 5
2016-04-28 19:41:44.517112 8059ec900 15 
genericfilestorebackend(testdir/osd-bench/0) syncfs: doing a full sync 
(syncfs(2) if possible)
2016-04-28 19:41:45.471870 8059ec900 10 filestore(testdir/osd-bench/0) 
sync_entry(1:1) commit took 1.071257, interval was 2.240513
2016-04-28 19:41:45.471885 8059ec900 10 journal commit_finish 238 thru 
32 journal: 0x8058e5400
2016-04-28 19:41:45.473683 8059ec900 15 journal committed_thru:1804 locked.
2016-04-28 19:41:45.473697 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473701 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473705 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473707 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473710 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473747 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473750 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473753 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473756 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473758 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473761 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473763 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473767 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473772 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473775 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473777 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473779 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473781 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473784 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473786 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473788 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473797 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473800 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473803 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473806 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473809 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473811 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473814 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473817 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473819 8059ec900 10 throttle flush while 
!journaled_ops.empty()
2016-04-28 19:41:45.473822 8059ec900 10 throttle flush:63 calling 
throttle.put()

