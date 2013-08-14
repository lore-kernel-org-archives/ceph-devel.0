From: Frederik Thuysbaert <frederik.thuysbaert@gmail.com>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Wed, 14 Aug 2013 10:47:24 +0200
Message-ID: <520B441C.8000305@gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com> <20130419064524.GQ11427@reaktio.net> <6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au> <CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au> <CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B62F433FE@BITCOM1.int.sbss.com.au> <6035A0D088A63A46850C3988ED045A4B62F43442@BITCOM1.int.sbss.com.au> <CAF6-1L502OZGbPHp37vWzEU3H-wsK5z904ZtS7SEUmuM-GhLyA@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B63891798@BITCOM1.int.sbss.com.au> <CAF6-1L4=rY7AJpHGB33KPMk6LfX7q8CHphPzh9amdqwbYzg3dQ@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B6389552A@BITCOM1.int.sbss.com.au> <CAF
 6-1L6jJvYuHN+BoucU2RNzv2R9dpMhbD1UVF96mBPO25FM5g@mail.gmail.com> <520A4945.1030907@gmail.com> <CAF6-1L5mcB=Qs3=XpmFC_S2cPWHFaKChYP77ZhLh0+uvWhR3eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:42880 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759505Ab3HNIr2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 04:47:28 -0400
Received: by mail-we0-f174.google.com with SMTP id q54so7377252wes.5
        for <ceph-devel@vger.kernel.org>; Wed, 14 Aug 2013 01:47:26 -0700 (PDT)
In-Reply-To: <CAF6-1L5mcB=Qs3=XpmFC_S2cPWHFaKChYP77ZhLh0+uvWhR3eQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: James Harper <james.harper@bendigoit.com.au>, =?ISO-8859-1?Q?Pasi_K?= =?ISO-8859-1?Q?=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 13-08-13 17:39, Sylvain Munaut wrote:
>
> It's actually strange that it changes anything at all.
>
> Can you try adding a ERROR("HERE\n");  in that error path processing
> and check syslog to see if it's triggered at all ?
>
> A traceback would be great if you can get a core file. And possibly
> compile tapdisk with debug symbols.
When halting the domU after the errors, I get the following in dom0 syslog:

Aug 14 10:43:57 xen-001 kernel: [ 5041.338756] INFO: task tapdisk:9690 
blocked for more than 120 seconds.
Aug 14 10:43:57 xen-001 kernel: [ 5041.338817] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Aug 14 10:43:57 xen-001 kernel: [ 5041.338903] tapdisk         D 
ffff8800bf213780     0  9690      1 0x00000000
Aug 14 10:43:57 xen-001 kernel: [ 5041.338908]  ffff8800b4b0e730 
0000000000000246 ffff880000000000 ffffffff8160d020
Aug 14 10:43:57 xen-001 kernel: [ 5041.338912]  0000000000013780 
ffff8800b4ebffd8 ffff8800b4ebffd8 ffff8800b4b0e730
Aug 14 10:43:57 xen-001 kernel: [ 5041.338916]  ffff8800b4d36190 
0000000181199c37 ffff8800b5798c00 ffff8800b5798c00
Aug 14 10:43:57 xen-001 kernel: [ 5041.338921] Call Trace:
Aug 14 10:43:57 xen-001 kernel: [ 5041.338929] [<ffffffffa0308411>] ? 
blktap_device_destroy_sync+0x85/0x9b [blktap]
Aug 14 10:43:57 xen-001 kernel: [ 5041.338936] [<ffffffff8105fadf>] ? 
add_wait_queue+0x3c/0x3c
Aug 14 10:43:57 xen-001 kernel: [ 5041.338940] [<ffffffffa0307444>] ? 
blktap_ring_release+0x10/0x2d [blktap]
Aug 14 10:43:57 xen-001 kernel: [ 5041.338945] [<ffffffff810fb141>] ? 
fput+0xf9/0x1a1
Aug 14 10:43:57 xen-001 kernel: [ 5041.338949] [<ffffffff810f8e6c>] ? 
filp_close+0x62/0x6a
Aug 14 10:43:57 xen-001 kernel: [ 5041.338954] [<ffffffff81049831>] ? 
put_files_struct+0x60/0xad
Aug 14 10:43:57 xen-001 kernel: [ 5041.338958] [<ffffffff81049e38>] ? 
do_exit+0x292/0x713
Aug 14 10:43:57 xen-001 kernel: [ 5041.338961] [<ffffffff8104a539>] ? 
do_group_exit+0x74/0x9e
Aug 14 10:43:57 xen-001 kernel: [ 5041.338965] [<ffffffff81055f94>] ? 
get_signal_to_deliver+0x46d/0x48f
Aug 14 10:43:57 xen-001 kernel: [ 5041.338970] [<ffffffff81347759>] ? 
force_sig_info_fault+0x5b/0x63
Aug 14 10:43:57 xen-001 kernel: [ 5041.338975] [<ffffffff8100de27>] ? 
do_signal+0x38/0x610
Aug 14 10:43:57 xen-001 kernel: [ 5041.338979] [<ffffffff81070deb>] ? 
arch_local_irq_restore+0x7/0x8
Aug 14 10:43:57 xen-001 kernel: [ 5041.338983] [<ffffffff8134eb77>] ? 
_raw_spin_unlock_irqrestore+0xe/0xf
Aug 14 10:43:57 xen-001 kernel: [ 5041.338987] [<ffffffff8103f944>] ? 
wake_up_new_task+0xb9/0xc2
Aug 14 10:43:57 xen-001 kernel: [ 5041.338992] [<ffffffff8106f987>] ? 
sys_futex+0x120/0x151
Aug 14 10:43:57 xen-001 kernel: [ 5041.338995] [<ffffffff8100e435>] ? 
do_notify_resume+0x25/0x68
Aug 14 10:43:57 xen-001 kernel: [ 5041.338999] [<ffffffff8134ef3c>] ? 
retint_signal+0x48/0x8c
...
Aug 14 10:44:17 xen-001 tap-ctl: tap-err:tap_ctl_connect: couldn't 
connect to /var/run/blktap-control/ctl9478: 111

>
>
> Cheers,
>
>      Sylvain
Regards

- Frederik
