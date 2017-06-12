From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: ceph-mds crash v12.0.3
Date: Mon, 12 Jun 2017 15:16:01 +0300
Message-ID: <9ff48e2f-26b6-8399-427a-fe577eac5bec@unixsol.org>
References: <eaf869fc-892f-a8e1-fea3-2661ce7f401e@unixsol.org>
 <CALe9h7c9bBMc4qd55sHx_T1jRrsHqWn+RksvQ=pzDFDKUYEwPw@mail.gmail.com>
 <73168653-b8c8-1f43-e505-0d1f3e3612df@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ns.unixsol.org ([193.110.159.2]:58521 "EHLO ns.unixsol.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdFLMQD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Jun 2017 08:16:03 -0400
In-Reply-To: <73168653-b8c8-1f43-e505-0d1f3e3612df@unixsol.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 6/12/17 1:56 PM, Georgi Chorbadzhiyski wrote:
> On 6/12/17 1:22 PM, John Spray wrote:
>> On Mon, Jun 12, 2017 at 5:13 AM, Georgi Chorbadzhiyski <gf@unixsol.org> wrote:
>>> We started getting these on all of our 3 MDS-es. Any idea how to fix it or at least debug
>>> it and remove the dir entries that are causing the problem?
>>
>> Assuming it's easy to reproduce, set "debug mds = 20", "debug ms = 1"
>> and gather the logs in the run up to the crash.
> 
> After turning up debug as you suggested here are the logs before the crash.
> 
>    -10> 2017-06-12 05:46:05.808399 7fc8038d2700 10 MDSInternalContextBase::complete: 18C_MDS_RetryRequest
>     -9> 2017-06-12 05:46:05.808401 7fc8038d2700  7 mds.0.server dispatch_client_request client_request(client.467465:121280822 readdir #1000007d3e8 sess_umos5jqii50rttcag852lros73 2017-06-12 03:36:19.073284 RETRY=115 caller_uid=1838, caller_gid=1838{}) v2
>     -8> 2017-06-12 05:46:05.808407 7fc8038d2700 10 mds.0.server rdlock_path_pin_ref request(client.467465:121280822 cr=0x7fc819988f00) #1000007d3e8
>     -7> 2017-06-12 05:46:05.808410 7fc8038d2700 10 mds.0.locker acquire_locks request(client.467465:121280822 cr=0x7fc819988f00) - done locking
>     -6> 2017-06-12 05:46:05.808416 7fc8038d2700 20 Session check_access path /client/shared/site.com/oc-content/uploads/session
>     -5> 2017-06-12 05:46:05.808418 7fc8038d2700 10 MDSAuthCap is_capable inode(path /client/shared/site.com/oc-content/uploads/session owner 1838:1838 mode 040755) by caller 1838:1838 mask 1 new 1024:524288 cap: MDSAuthCaps[allow *]
> 
>     -4> 2017-06-12 05:46:05.808423 7fc8038d2700 10 mds.0.server  frag 1* offset 'sess_umos5jqii50rttcag852lros73' offset_hash 13141348 flags 0
>     -3> 2017-06-12 05:46:05.808426 7fc8038d2700 10 mds.0.server  adjust frag 1* -> 1000* fragtree_t(*^1 0*^1 1*^3)
>     -2> 2017-06-12 05:46:05.808430 7fc8038d2700 10 mds.0.server handle_client_readdir on [dir 1000007d3e8.1000* /client/shared/site.com/oc-content/uploads/session/ [2,head] auth pv=1077482 v=1077481 cv=0/0 ap=1+2+2 state=1610612738|complete f(v86 218=218+0) n(v10 b67671 218=218+0) hs=218+6,ss=0+0 dirty=10 | child=1 dirty=1 waiter=0 authpin=1 0x7fc828eae340]
>     -1> 2017-06-12 05:46:05.808447 7fc8038d2700 10 mds.0.server snapid head
>      0> 2017-06-12 05:46:05.843735 7fc8038d2700 -1 *** Caught signal (Segmentation fault) **
>  in thread 7fc8038d2700 thread_name:ms_dispatch
> 
> I've looked at mds code but nothing caught my eye and after "snapid head" debug
> message unfortunately there is not a lot debug printing going on to get a better
> idea what's going on.

A bit more info about the directory structure. The directory from the log above
had >3500 session files names. The debug from the crashes always mentioned this
file: sess_umos5jqii50rttcag852lros73 (unfortunately it was deleted before
I tried to preserve it).

The parent directory is wordpress 'uploads' directory and contains > 78000 files
(pictures and thumbnails).

I've workaround the problem by stopping all cephfs clients and renaming 'session'
directory. I'm currently unable to recreate the problem but I have the files
and the directory structure.

root@cephfs-client:/mnt/test/client/shared/site.com/oc-content/uploads# du -sh .
3.1G	.

root@cephfs-client:/mnt/test/client/shared/site.com/oc-content/uploads# find -type f | wc -l
78321

root@cephfs-client:/mnt/test/client/shared/site.com/oc-content/uploads# ls -l | wc -l
54068

root@cephfs-client:/mnt/test/client/shared/site.com/oc-content/uploads# ls -l session/ | wc -l
3513

root@cephfs-client:/mnt/test/client/shared/site.com/oc-content/uploads# find -type d | wc -l
2435
