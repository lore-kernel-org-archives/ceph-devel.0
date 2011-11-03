From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: ceph-mon blocked error
Date: Thu, 3 Nov 2011 12:09:23 -0700
Message-ID: <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
	<CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60918 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934290Ab1KCTJY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2011 15:09:24 -0400
Received: by vws1 with SMTP id 1so1215684vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2011 12:09:23 -0700 (PDT)
In-Reply-To: <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

We are currently running all services on each of the three nodes.
(mon, mds, and several osd processes).

On Wed, Nov 2, 2011 at 9:47 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Wed, Nov 2, 2011 at 9:30 PM, Mandell Degerness
> <mandell@pistoncloud.com> wrote:
>> Should this error showing up in the log worry me?
>
> Looks like the process got stuck while waiting for xfs to do a sync.
> So...yes, that's a problem.
>
> The Ceph monitor really doesn't do anything special that I'd expect t=
o
> be exposing filesystem bugs though. Do you have other Ceph processes
> running on this node?
> -Greg
>
>
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: INFO: task ceph-mon:5715
>> blocked for more than 120 seconds.
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: "echo 0 >
>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: ceph-mon =A0 =A0 =A0 =A0=
D
>> 0000000006bcdc9f =A0 =A0 0 =A05715 =A0 =A0 =A01 0x00000000
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: ffff88080d5dfc38
>> 0000000000000086 ffff8807eadec0c0 ffff8804274d60c0
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: ffff88080d5dfc48
>> 0000000000011980 0000000000011980 0000000000011980
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: ffff88080d5dffd8
>> 0000000000011980 0000000000011980 ffff88080d5dffd8
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: Call Trace:
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff81630b5e>]
>> schedule+0x6d/0x83
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff81630ee2>]
>> schedule_timeout+0x36/0xe3
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff81630360>]
>> wait_for_common+0xa0/0x105
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff81048595>] ?
>> try_to_wake_up+0x1ed/0x1ed
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff812462a8>] ?
>> xfs_bwrite+0x4b/0x95
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116ef45>] ?
>> __sync_filesystem+0xa1/0xa1
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff81630553>]
>> wait_for_completion+0x30/0x46
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff812457c6>]
>> xfs_buf_iowait+0x61/0xb9
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff812462a8>]
>> xfs_bwrite+0x4b/0x95
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff81254c70>]
>> xfs_sync_fsdata+0x4b/0x66
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff81255138>]
>> xfs_quiesce_data+0x39/0xa3
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff81252b49>]
>> xfs_fs_sync_fs+0x34/0x71
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116ef1b>]
>> __sync_filesystem+0x77/0xa1
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116ef6e>]
>> sync_one_sb+0x29/0x3f
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff8114620e>]
>> iterate_supers+0x7c/0xe3
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116ee2f>]
>> sync_filesystems+0x2f/0x45
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff8116f02e>]
>> sys_sync+0x34/0x5a
>> Nov =A02 21:28:12 node-172-16-0-128 kernel: [<ffffffff8163326b>]
>> system_call_fastpath+0x16/0x1b
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
