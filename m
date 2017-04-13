From: Mohamad Gebai <mgebai@suse.com>
Subject: Measuring lock conention
Date: Thu, 13 Apr 2017 11:43:50 -0400
Message-ID: <90991cbf-c59e-d080-783e-e712540a99b1@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60748 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdDMPoX (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 13 Apr 2017 11:44:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

Yesterday during the performance call there was some talk around 
measuring lock contention in wallclock, and it was mentioned that an 
option would be to monitor the futex system call. I just uploaded to 
Github a script I've used in the past that does exactly that, in case 
there was interest in pursuing this approach 
(https://github.com/mogeb/bt-futex). The Python script expects a CTF 
trace (e.g. LTTng). The functionality is very minimal at this point, but 
if there is interest I'd be happy to enhance it further. The main 
drawback of this approach is that it only works for locks that use futex 
(spinlocks, for instance, wouldn't be monitored). No instrumentation to 
the application is required.

Here's an example output of the amount of time spent in the futex 
syscall, per thread (system-wide). The LOCK_TIME column shows the amount 
of time waiting on a lock, in nanoseconds:

$> python3 count_futex.py kernel/
PROCESS_NAME (TID): LOCK_TIME ns
git (17550):  2,122
git (17551):  8,124
example (17554):  80,690,708
example (17555):  80,020,536
example (17556):  367,010,253
example (17557):  459,009,153
example (17558):  199,676,209
example (17559):  108,401
example (17560):  475,562,084
example (17561):  80,549,102
example (17562):  468,002,252
example (17564):  92,108,616
example (17566):  450,655,745
example (17567):  49,904,388
libvirtd (3772):  2,389
libvirtd (3773):  2,839
libvirtd (3775):  2,417
libvirtd (3776):  3,577
libvirtd (3777):  2,492

Mohamad
