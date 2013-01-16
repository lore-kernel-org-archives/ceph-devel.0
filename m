From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Ceph slow request & unstable issue
Date: Wed, 16 Jan 2013 11:13:59 +0300
Message-ID: <CABYiri_50ijzfm1y-ryNULXq8DDNUWghrBaQBfzBkspzjpZx1A@mail.gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC5DCC63@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64032 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab3APIVU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 03:21:20 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so1088113obb.5
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 00:21:20 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5DCC63@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "sage@inktank.com" <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 16, 2013 at 4:58 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> w=
rote:
> Hi list,
>         We are suffering from OSD or OS down when there is continuing=
 high pressure on the Ceph rack.
>         Basically we are on Ubuntu 12.04+ Ceph 0.56.1, 6 nodes, in ea=
ch nodes with 20 * spindles + 4* SSDs as journal.(120 spindles in total=
)
>         We create a lots of RBD volumes (say 240),mounting to 16 diff=
erent client machines ( 15 RBD Volumes/ client) and running DD concurre=
ntly on top of each RBD.
>
>         The issues are:
> 1. Slow requests
> =E3=80=80=E3=80=80From the list-archive it seems solved in 0.56.1 but=
 we still notice such warning
> 2. OSD Down or even host down
> Like the message below.Seems some OSD has been blocking there for qui=
te a long time.
>
>         Suggestions are highly appreciate.Thanks
>                                                                      =
                                                                       =
                            Xiaoxi
>
> _____________________________________________
>
> Bad news:
>
> I have  back all my Ceph machine=E2=80=99s OS to kernel  3.2.0-23, wh=
ich Ubuntu 12.04 use.
> I run dd command (dd if=3D/dev/zero bs=3D1M count=3D60000 of=3D/dev/r=
bd${i} & )on Ceph client to create data prepare test at last night.
> Now, I have one machine down (can=E2=80=99t be reached by ping), anot=
her two machine has all OSD daemon down, while the three left has some =
daemon down.
>
> I have many warnings in OSD log like this:
>
> no flag points reached
> 2013-01-15 19:14:22.769898 7f20a2d57700  0 log [WRN] : slow request 5=
2.218106 seconds old, received at 2013-01-15 19:13:30.551718: osd_op(cl=
ient.10674.1:1002417 rb.0.27a8.6b8b4567.000000000eba [write 3145728~524=
288] 2.c61810ee RETRY) currently waiting for sub ops
> 2013-01-15 19:14:23.770077 7f20a2d57700  0 log [WRN] : 21 slow reques=
ts, 6 included below; oldest blocked for > 1132.138983 secs
> 2013-01-15 19:14:23.770086 7f20a2d57700  0 log [WRN] : slow request 5=
3.216404 seconds old, received at 2013-01-15 19:13:30.553616: osd_op(cl=
ient.10671.1:1066860 rb.0.282c.6b8b4567.000000001057 [write 2621440~524=
288] 2.ea7acebc) currently waiting for sub ops
> 2013-01-15 19:14:23.770096 7f20a2d57700  0 log [WRN] : slow request 5=
1.442032 seconds old, received at 2013-01-15 19:13:32.327988: osd_op(cl=
ient.10674.1:1002418
>
> Similar info in dmesg we have saw pervious:
>
> [21199.036476] INFO: task ceph-osd:7788 blocked for more than 120 sec=
onds.
> [21199.037493] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> [21199.038841] ceph-osd        D 0000000000000006     0  7788      1 =
0x00000000
> [21199.038844]  ffff880fefdafcc8 0000000000000086 0000000000000000 ff=
ffffffffffffe0
> [21199.038848]  ffff880fefdaffd8 ffff880fefdaffd8 ffff880fefdaffd8 00=
00000000013780
> [21199.038852]  ffff88081aa58000 ffff880f68f52de0 ffff880f68f52de0 ff=
ff882017556200
> [21199.038856] Call Trace:
> [21199.038858]  [<ffffffff8165a55f>] schedule+0x3f/0x60
> [21199.038861]  [<ffffffff8106b7e5>] exit_mm+0x85/0x130
> [21199.038864]  [<ffffffff8106b9fe>] do_exit+0x16e/0x420
> [21199.038866]  [<ffffffff8109d88f>] ? __unqueue_futex+0x3f/0x80
> [21199.038869]  [<ffffffff8107a19a>] ? __dequeue_signal+0x6a/0xb0
> [21199.038872]  [<ffffffff8106be54>] do_group_exit+0x44/0xa0
> [21199.038874]  [<ffffffff8107ccdc>] get_signal_to_deliver+0x21c/0x42=
0
> [21199.038877]  [<ffffffff81013865>] do_signal+0x45/0x130
> [21199.038880]  [<ffffffff810a091c>] ? do_futex+0x7c/0x1b0
> [21199.038882]  [<ffffffff810a0b5a>] ? sys_futex+0x10a/0x1a0
> [21199.038885]  [<ffffffff81013b15>] do_notify_resume+0x65/0x80
> [21199.038887]  [<ffffffff81664d50>] int_signal+0x12/0x17
>
>
> Thanks.
> -chen
>

my 0.02$:
http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg11531.html
and kernel panic from two different hosts from yesterday during ceph
startup(on 3.8-rc3, images from console available at
http://imgur.com/wIRVn,k0QCS#0) leads to suggestion that Ceph may have
been introduced lockup-alike behavior not a long ago, causing, in my
case, excessive amount of context switches on the host leading to osd
flaps and panic at the ip-ib stack due to same issue.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
