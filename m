From: Ming Lin <minggr@gmail.com>
Subject: Re: understand ceph packets on the wire
Date: Mon, 6 Feb 2017 13:14:49 -0800
Message-ID: <CAF1ivSaR3V5ck12BPj1=TyvNO6Cb1-pug22iYoxCwOTM2-XzAg@mail.gmail.com>
References: <CAF1ivSZtbb_mrSB7gdgO0sszWwZA+r95btd6_AM4VXffNyXq8A@mail.gmail.com>
 <CAJE9aOO+qgU+vyusOXkwQ-3OC+9z0BYTZm_d7SmZG23PQ9nhuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35454 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdBFVOv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 16:14:51 -0500
Received: by mail-io0-f182.google.com with SMTP id j18so75496961ioe.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 13:14:51 -0800 (PST)
In-Reply-To: <CAJE9aOO+qgU+vyusOXkwQ-3OC+9z0BYTZm_d7SmZG23PQ9nhuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 6, 2017 at 3:18 AM, kefu chai <tchaikov@gmail.com> wrote:
> On Sat, Feb 4, 2017 at 7:18 AM, Ming Lin <minggr@gmail.com> wrote:
>> Hi,
>>
>> With a one monitor one OSD test setup(osd pool default size = 1), I
>> captured the packets with tshark.
>> pcap.out file: https://ufile.io/43c78
>>
>> The test I did was:
>> dd if=tmp.txt bs=512 count=1 of=/dev/rbd0 oflag=direct
>>
>> About 350 packets were captured just for above simple "dd" command.
>>
>> If you open the file with wireshark, you'll see packet #41 is the data packet.
>> "192.168.122.1" is the OSD and "192.168.122.131" is the rbd client.
>>
>> What are other packets?
>
> you can set "debug-ms=1" and probably set "log_file" to a writable
> path, then check the log.

Got it. The other packets were actually from systemd-udevd doing read
on the background.
I added a debug in the krbd driver. Here is the trace.

[   90.206486] CPU: 0 PID: 1382 Comm: systemd-udevd Tainted: G
  OE   4.10.0-rc6+ #291

[   90.206488] Call Trace:
[   90.206493]  dump_stack+0x63/0x89
[   90.206497]  rbd_queue_rq+0x85/0x90 [rbd]
[   90.206499]  blk_mq_dispatch_rq_list+0xdb/0x1f0
[   90.206500]  blk_mq_process_rq_list+0x122/0x140
[   90.206501]  __blk_mq_run_hw_queue+0xae/0xc0
[   90.206502]  blk_mq_run_hw_queue+0x95/0xc0
[   90.206503]  blk_mq_insert_requests+0xdc/0x1c0
[   90.206504]  blk_mq_flush_plug_list+0x127/0x140
[   90.206506]  blk_flush_plug_list+0xc7/0x220
[   90.206507]  blk_finish_plug+0x2c/0x40
[   90.206510]  __do_page_cache_readahead+0x19c/0x240
[   90.206511]  force_page_cache_readahead+0xa2/0x100
[   90.206512]  page_cache_sync_readahead+0x3f/0x50
[   90.206514]  generic_file_read_iter+0x579/0x7c0
[   90.206517]  ? _copy_to_user+0x2d/0x40
[   90.206519]  blkdev_read_iter+0x37/0x40
[   90.206521]  __vfs_read+0xbd/0x110
[   90.206522]  vfs_read+0x8c/0x130
[   90.206524]  SyS_read+0x46/0xa0
[   90.206525]  ? SyS_lseek+0x87/0xb0
[   90.206528]  entry_SYSCALL_64_fastpath+0x1e/0xad
