From: Barclay Jameson <almightybeeij@gmail.com>
Subject: Ceph hard lock Hammer 9.2
Date: Mon, 22 Jun 2015 15:45:36 -0500
Message-ID: <CAMzumda0cMjMphp2B-u5hcPKsF9K26YQRGg4tKYJL5VPXX2AJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34742 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbbFVUph (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jun 2015 16:45:37 -0400
Received: by obbkm3 with SMTP id km3so28271189obb.1
        for <ceph-devel@vger.kernel.org>; Mon, 22 Jun 2015 13:45:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Has anyone seen this?

Jun 22 15:09:27 node kernel: Call Trace:
Jun 22 15:09:27 node kernel: [<ffffffff816803ee>] schedule+0x3e/0x90
Jun 22 15:09:27 node kernel: [<ffffffff8168062e>]
schedule_preempt_disabled+0xe/0x10
Jun 22 15:09:27 node kernel: [<ffffffff81681ce3>]
__mutex_lock_slowpath+0x93/0x100
Jun 22 15:09:27 node kernel: [<ffffffffa060def8>] ?
__cap_is_valid+0x58/0x70 [ceph]
Jun 22 15:09:27 node kernel: [<ffffffff81681d73>] mutex_lock+0x23/0x40
Jun 22 15:09:27 node kernel: [<ffffffffa0610f2d>]
ceph_check_caps+0x38d/0x780 [ceph]
Jun 22 15:09:27 node kernel: [<ffffffff812f5a9b>] ?
__radix_tree_delete_node+0x7b/0x130
Jun 22 15:09:27 node kernel: [<ffffffffa0612637>]
ceph_put_wrbuffer_cap_refs+0xf7/0x240 [ceph]
Jun 22 15:09:27 node kernel: [<ffffffffa060b170>]
writepages_finish+0x200/0x290 [ceph]
Jun 22 15:09:27 node kernel: [<ffffffffa05e2731>]
handle_reply+0x4f1/0x640 [libceph]
Jun 22 15:09:27 node kernel: [<ffffffffa05e3065>] dispatch+0x85/0xa0 [libceph]
Jun 22 15:09:27 node kernel: [<ffffffffa05d7ceb>]
process_message+0xab/0xd0 [libceph]
Jun 22 15:09:27 node kernel: [<ffffffffa05db052>] try_read+0x2d2/0x430 [libceph]
Jun 22 15:09:27 node kernel: [<ffffffffa05db7e8>] con_work+0x78/0x220 [libceph]
Jun 22 15:09:27 node kernel: [<ffffffff8108c475>] process_one_work+0x145/0x460
Jun 22 15:09:27 node kernel: [<ffffffff8108c8b2>] worker_thread+0x122/0x420
Jun 22 15:09:27 node kernel: [<ffffffff8167fdb8>] ? __schedule+0x398/0x840
Jun 22 15:09:27 node kernel: [<ffffffff8108c790>] ? process_one_work+0x460/0x460
Jun 22 15:09:27 node kernel: [<ffffffff8108c790>] ? process_one_work+0x460/0x460
Jun 22 15:09:27 node kernel: [<ffffffff8109170e>] kthread+0xce/0xf0
Jun 22 15:09:27 node kernel: [<ffffffff81091640>] ?
kthread_freezable_should_stop+0x70/0x70
Jun 22 15:09:27 node kernel: [<ffffffff81683dd8>] ret_from_fork+0x58/0x90
Jun 22 15:09:27 node kernel: [<ffffffff81091640>] ?
kthread_freezable_should_stop+0x70/0x70
Jun 22 15:11:27 node kernel: INFO: task kworker/2:1:40 blocked for
more than 120 seconds.
Jun 22 15:11:27 node kernel:      Tainted: G          I
4.0.4-1.el6.elrepo.x86_64 #1
Jun 22 15:11:27 node kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Jun 22 15:11:27 node kernel: kworker/2:1     D ffff881ff279f7f8     0
  40      2 0x00000000
Jun 22 15:11:27 node kernel: Workqueue: ceph-msgr con_work [libceph]
Jun 22 15:11:27 node kernel: ffff881ff279f7f8 ffff881ff261c010
ffff881ff2b67050 ffff88207fd95270
Jun 22 15:11:27 node kernel: ffff881ff279c010 ffff88207fd15200
7fffffffffffffff 0000000000000002
Jun 22 15:11:27 node kernel: ffffffff81680ae0 ffff881ff279f818
ffffffff816803ee ffffffff810ae63b
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
