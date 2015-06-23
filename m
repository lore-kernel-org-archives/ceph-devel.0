From: Barclay Jameson <almightybeeij@gmail.com>
Subject: Re: Ceph hard lock Hammer 9.2
Date: Tue, 23 Jun 2015 09:25:57 -0500
Message-ID: <CAMzumdaTn5NX9g3J_ea0wAzPVDt2tsMDFsafjECDuzN9OOWa=w@mail.gmail.com>
References: <CAMzumda0cMjMphp2B-u5hcPKsF9K26YQRGg4tKYJL5VPXX2AJQ@mail.gmail.com>
	<CAC6JEv_=gWCvanpkwqcrDpKYX0Wb8cV=aE6S-uHgT_c1-76gtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34045 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932882AbbFWOZ6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 10:25:58 -0400
Received: by oigx81 with SMTP id x81so8093023oig.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 07:25:57 -0700 (PDT)
In-Reply-To: <CAC6JEv_=gWCvanpkwqcrDpKYX0Wb8cV=aE6S-uHgT_c1-76gtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>

Sure,
I guess it's actually a soft kernel lock since it's only the
filesystem that is hung with high IO wait.
The kernel is 4.0.4-1.el6.elrepo.x86.
The Ceph version is 0.94.2 (Sorry about the confusion I missed a 4
when I typed in the subject line).
I was testing copying 100,000 files from directory (dir1) to
(dir1-`hostname`) on three septate hosts.
2 of the hosts completed the job and the third one hung with the stack
trace in /var/log/messages.

On Tue, Jun 23, 2015 at 6:54 AM, Gregory Farnum <greg@gregs42.com> wrote:
> On Mon, Jun 22, 2015 at 9:45 PM, Barclay Jameson
> <almightybeeij@gmail.com> wrote:
>> Has anyone seen this?
>
> Can you describe the kernel you're using, the workload you were
> running, the Ceph cluster you're running against, etc?
>
>>
>> Jun 22 15:09:27 node kernel: Call Trace:
>> Jun 22 15:09:27 node kernel: [<ffffffff816803ee>] schedule+0x3e/0x90
>> Jun 22 15:09:27 node kernel: [<ffffffff8168062e>]
>> schedule_preempt_disabled+0xe/0x10
>> Jun 22 15:09:27 node kernel: [<ffffffff81681ce3>]
>> __mutex_lock_slowpath+0x93/0x100
>> Jun 22 15:09:27 node kernel: [<ffffffffa060def8>] ?
>> __cap_is_valid+0x58/0x70 [ceph]
>> Jun 22 15:09:27 node kernel: [<ffffffff81681d73>] mutex_lock+0x23/0x40
>> Jun 22 15:09:27 node kernel: [<ffffffffa0610f2d>]
>> ceph_check_caps+0x38d/0x780 [ceph]
>> Jun 22 15:09:27 node kernel: [<ffffffff812f5a9b>] ?
>> __radix_tree_delete_node+0x7b/0x130
>> Jun 22 15:09:27 node kernel: [<ffffffffa0612637>]
>> ceph_put_wrbuffer_cap_refs+0xf7/0x240 [ceph]
>> Jun 22 15:09:27 node kernel: [<ffffffffa060b170>]
>> writepages_finish+0x200/0x290 [ceph]
>> Jun 22 15:09:27 node kernel: [<ffffffffa05e2731>]
>> handle_reply+0x4f1/0x640 [libceph]
>> Jun 22 15:09:27 node kernel: [<ffffffffa05e3065>] dispatch+0x85/0xa0 [libceph]
>> Jun 22 15:09:27 node kernel: [<ffffffffa05d7ceb>]
>> process_message+0xab/0xd0 [libceph]
>> Jun 22 15:09:27 node kernel: [<ffffffffa05db052>] try_read+0x2d2/0x430 [libceph]
>> Jun 22 15:09:27 node kernel: [<ffffffffa05db7e8>] con_work+0x78/0x220 [libceph]
>> Jun 22 15:09:27 node kernel: [<ffffffff8108c475>] process_one_work+0x145/0x460
>> Jun 22 15:09:27 node kernel: [<ffffffff8108c8b2>] worker_thread+0x122/0x420
>> Jun 22 15:09:27 node kernel: [<ffffffff8167fdb8>] ? __schedule+0x398/0x840
>> Jun 22 15:09:27 node kernel: [<ffffffff8108c790>] ? process_one_work+0x460/0x460
>> Jun 22 15:09:27 node kernel: [<ffffffff8108c790>] ? process_one_work+0x460/0x460
>> Jun 22 15:09:27 node kernel: [<ffffffff8109170e>] kthread+0xce/0xf0
>> Jun 22 15:09:27 node kernel: [<ffffffff81091640>] ?
>> kthread_freezable_should_stop+0x70/0x70
>> Jun 22 15:09:27 node kernel: [<ffffffff81683dd8>] ret_from_fork+0x58/0x90
>> Jun 22 15:09:27 node kernel: [<ffffffff81091640>] ?
>> kthread_freezable_should_stop+0x70/0x70
>> Jun 22 15:11:27 node kernel: INFO: task kworker/2:1:40 blocked for
>> more than 120 seconds.
>> Jun 22 15:11:27 node kernel:      Tainted: G          I
>> 4.0.4-1.el6.elrepo.x86_64 #1
>> Jun 22 15:11:27 node kernel: "echo 0 >
>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> Jun 22 15:11:27 node kernel: kworker/2:1     D ffff881ff279f7f8     0
>>   40      2 0x00000000
>> Jun 22 15:11:27 node kernel: Workqueue: ceph-msgr con_work [libceph]
>> Jun 22 15:11:27 node kernel: ffff881ff279f7f8 ffff881ff261c010
>> ffff881ff2b67050 ffff88207fd95270
>> Jun 22 15:11:27 node kernel: ffff881ff279c010 ffff88207fd15200
>> 7fffffffffffffff 0000000000000002
>> Jun 22 15:11:27 node kernel: ffffffff81680ae0 ffff881ff279f818
>> ffffffff816803ee ffffffff810ae63b
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
