From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 19:49:02 +0200
Message-ID: <4FE9F60E.3020105@profihost.ag>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net> <4FE97BE8.6010603@profihost.ag> <4FE9E006.6030404@profihost.ag> <4FE9E360.8050807@inktank.com> <4FE9E6CB.8080803@profihost.ag> <4FE9EA85.9030809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37817 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab2FZRtH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 13:49:07 -0400
In-Reply-To: <4FE9EA85.9030809@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "hch@infradead.org >> Christoph Hellwig" <hch@infradead.org>

I would but both XFS and btrfs are crashing after a short period.

XFS crashes with this one:
[  479.732636] INFO: task ceph-osd:3217 blocked for more than 120 seconds.
[  479.747724] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  479.763534] ceph-osd        D ffffffff8180e9c0     0  3217      1 
0x00000000
[  479.779837]  ffff880bc4321bd8 0000000000000082 ffff880bc5694830 
0000000000012200
[  479.779840]  ffff880bc4321fd8 ffff880bc4320010 0000000000012200 
0000000000012200
[  479.779841]  ffff880bc4321fd8 0000000000012200 ffff880e40ea9810 
ffff880bc5694830
[  479.779843] Call Trace:
[  479.779850]  [<ffffffff816296e4>] schedule+0x24/0x70
[  479.779853]  [<ffffffff812c2049>] xlog_wait+0x69/0x90
[  479.779856]  [<ffffffff8106de20>] ? try_to_wake_up+0x2b0/0x2b0
[  479.779858]  [<ffffffff812c23b3>] xlog_cil_push+0x343/0x3c0
[  479.779861]  [<ffffffff8126ce09>] ? xfs_buf_unlock+0x19/0x70
[  479.779862]  [<ffffffff812c2ab1>] xlog_cil_force_lsn+0x101/0x110
[  479.779864]  [<ffffffff812bccee>] ? xfs_trans_free_item_desc+0x2e/0x30
[  479.779865]  [<ffffffff812bcd77>] ? xfs_trans_free_items+0x87/0xb0
[  479.779867]  [<ffffffff812c07c8>] _xfs_log_force_lsn+0x48/0x290
[  479.779871]  [<ffffffff8110351b>] ? kmem_cache_free+0x1b/0xf0
[  479.779872]  [<ffffffff812bdfdb>] xfs_trans_commit+0x24b/0x260
[  479.779875]  [<ffffffff81271e9d>] xfs_fs_log_dummy+0x5d/0x90
[  479.779877]  [<ffffffff812bed9c>] ? xfs_log_need_covered+0x7c/0xc0
[  479.779879]  [<ffffffff8127d378>] xfs_quiesce_data+0x88/0x90
[  479.779881]  [<ffffffff8127b428>] xfs_fs_sync_fs+0x28/0x60
[  479.779884]  [<ffffffff811363ae>] __sync_filesystem+0x5e/0x90
[  479.779885]  [<ffffffff811364b3>] sync_filesystem+0x43/0x60
[  479.779887]  [<ffffffff81136518>] sys_syncfs+0x48/0x80
[  479.779890]  [<ffffffff8162ae62>] system_call_fastpath+0x16/0x1b


Am 26.06.2012 18:59, schrieb Mark Nelson:
> On 06/26/2012 11:43 AM, Stefan Priebe wrote:
>> Am 26.06.2012 18:29, schrieb Mark Nelson:
>>> On 06/26/2012 11:15 AM, Stefan Priebe wrote:
>>> Hi Stefan,
>>>
>>> If you can, it would be really interesting to see the blktrace results
>>> during these tests for both xfs and btrfs. blktrace is in the ubuntu
>>> repositories and can be run quite easily from the command line during
>>> your test.
>>
>> Sure any special parameters? I have 4 SSDs per OSD Server.
>>
>> Or just blktrace -o file?
>>
>> Stefan
>
> For each device you run it on you'll get one file per core.  There may
> be some performance impact if you run blktrace on every device per node.
>   If your data is well distributed, even a trace for one OSD (per test)
> would be interesting.
>
> so blktrace -o <outfile prefix> -d <device> where device is your first
> OSD or something.  If you can do it for both btrfs and xfs and maybe run
> each test for a couple of minutes that might be enough.
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

