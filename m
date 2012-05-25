From: Greg Farnum <greg@inktank.com>
Subject: Re: 'rbd map' asynchronous behavior
Date: Fri, 25 May 2012 13:07:51 -0700
Message-ID: <919DF5996F3D4B1A84A2E6F55B17F329@inktank.com>
References: <CABYiri-Whv7tGLVb-AcwMKcA1=iMTyguOYokg2xKt9r6hzKRuQ@mail.gmail.com>
 <4FB278D3.1020908@inktank.com>
 <CABYiri8Z8vnNBwsP=maLc9f9ope45v7CFxHo5hZ6_5SbCYfDSA@mail.gmail.com>
 <CABYiri--LDspzeu6MmRuLa7OttuFASGnLoc+vqDa3sg3F=O=Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33420 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab2EYUH4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 16:07:56 -0400
Received: by pbbrp8 with SMTP id rp8so2174391pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 13:07:55 -0700 (PDT)
In-Reply-To: <CABYiri--LDspzeu6MmRuLa7OttuFASGnLoc+vqDa3sg3F=O=Kg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, elder@inktank.com

That looks like a bug that isn't familiar to Josh or I. Can you create a report in the tracker and provide as much debug info as you can come up with? :)


On Friday, May 25, 2012 at 3:15 AM, Andrey Korolyov wrote:

> Hi,
> 
> Newer kernel rbd driver throws a quite strange messages on map|unmap,
> comparing to 3.2 branch:
> 
> rbd map 'path' # device appears as /dev/rbd1 instead of rbd0, then
> rbd unmap /dev/rbd1 # causes following trace, w/ vanilla 3.4.0 from kernel.org (http://kernel.org):
> 
> [ 99.700802] BUG: scheduling while atomic: rbd/3846/0x00000002
> [ 99.700857] Modules linked in: btrfs ip6table_filter ip6_tables
> iptable_filter ip_tables ebtable_nat ebtables x_tables iscsi_tcp
> libiscsi_tcp libiscsi scsi_transport_iscsi fuse nfsd nfs nfs_acl
> auth_rpcgss lockd sunrpc kvm_intel kvm bridge stp llc ipv6 rbd libceph
> loop 8250_pnp pcspkr firewire_ohci coretemp firewire_core hwmon 8250
> serial_core
> [ 99.700899] Pid: 3846, comm: rbd Not tainted 3.4.0 #3
> [ 99.700902] Call Trace:
> [ 99.700910] [<ffffffff81464d68>] ? __schedule+0x96/0x625
> [ 99.700916] [<ffffffff8105f98a>] ? __queue_work+0x254/0x27c
> [ 99.700921] [<ffffffff81465d39>] ? _raw_spin_lock_irqsave+0x2a/0x32
> [ 99.700926] [<ffffffff81069b6d>] ? complete+0x31/0x40
> [ 99.700931] [<ffffffff8105f10a>] ? flush_workqueue_prep_cwqs+0x16e/0x180
> [ 99.700947] [<ffffffff81463bd8>] ? schedule_timeout+0x21/0x1af
> [ 99.700951] [<ffffffff8107165d>] ? enqueue_entity+0x67/0x13d
> [ 99.700955] [<ffffffff81464ad9>] ? wait_for_common+0xc5/0x143
> [ 99.700959] [<ffffffff8106d5fc>] ? try_to_wake_up+0x217/0x217
> [ 99.700963] [<ffffffff81063952>] ? kthread_stop+0x30/0x50
> [ 99.700967] [<ffffffff81060979>] ? destroy_workqueue+0x148/0x16b
> [ 99.700977] [<ffffffffa004ce07>] ? ceph_osdc_stop+0x1f/0xaa [libceph]
> [ 99.700984] [<ffffffffa00463b4>] ? ceph_destroy_client+0x10/0x44 [libceph]
> [ 99.700989] [<ffffffffa00652ae>] ? rbd_client_release+0x38/0x4b [rbd]
> [ 99.700993] [<ffffffffa0065719>] ? rbd_put_client.isra.10+0x28/0x3d [rbd]
> [ 99.700998] [<ffffffffa006609d>] ? rbd_dev_release+0xc3/0x157 [rbd]
> [ 99.701003] [<ffffffff81287387>] ? device_release+0x41/0x72
> [ 99.701007] [<ffffffff81202b95>] ? kobject_release+0x4e/0x6a
> [ 99.701025] [<ffffffffa0065156>] ? rbd_remove+0x102/0x11e [rbd]
> [ 99.701035] [<ffffffff8114b058>] ? sysfs_write_file+0xd3/0x10f
> [ 99.701044] [<ffffffff810f8796>] ? vfs_write+0xaa/0x136
> [ 99.701052] [<ffffffff810f8a07>] ? sys_write+0x45/0x6e
> [ 99.701062] [<ffffffff8146a839>] ? system_call_fastpath+0x16/0x1b
> [ 99.701170] BUG: scheduling while atomic: rbd/3846/0x00000002
> [ 99.701220] Modules linked in: btrfs ip6table_filter ip6_tables
> iptable_filter ip_tables ebtable_nat ebtables x_tables iscsi_tcp
> libiscsi_tcp libiscsi scsi_transport_iscsi fuse nfsd nfs nfs_acl
> auth_rpcgss lockd sunrpc kvm_intel kvm bridge stp llc ipv6 rbd libceph
> loop 8250_pnp pcspkr firewire_ohci coretemp firewire_core hwmon 8250
> serial_core
> [ 99.701251] Pid: 3846, comm: rbd Not tainted 3.4.0 #3
> [ 99.701253] Call Trace:
> [ 99.701257] [<ffffffff81464d68>] ? __schedule+0x96/0x625
> [ 99.701261] [<ffffffff81465ef9>] ? _raw_spin_unlock_irq+0x5/0x2e
> [ 99.701265] [<ffffffff81069f92>] ? finish_task_switch+0x4c/0xc1
> [ 99.701268] [<ffffffff8146525b>] ? __schedule+0x589/0x625
> [ 99.701272] [<ffffffff812084b2>] ? ip4_string+0x5a/0xc8
> [ 99.701276] [<ffffffff81208cbd>] ? string.isra.3+0x39/0x9f
> [ 99.701281] [<ffffffff81208e33>] ? ip4_addr_string.isra.5+0x5a/0x76
> [ 99.701285] [<ffffffff81208b7a>] ? number.isra.1+0x10e/0x218
> [ 99.701290] [<ffffffff81463bd8>] ? schedule_timeout+0x21/0x1af
> [ 99.701294] [<ffffffff81464ad9>] ? wait_for_common+0xc5/0x143
> [ 99.701298] [<ffffffff8106d5fc>] ? try_to_wake_up+0x217/0x217
> [ 99.701303] [<ffffffff8105f24c>] ? flush_workqueue+0x130/0x2a5
> [ 99.701309] [<ffffffffa00463b9>] ? ceph_destroy_client+0x15/0x44 [libceph]
> [ 99.701314] [<ffffffffa00652ae>] ? rbd_client_release+0x38/0x4b [rbd]
> [ 99.701319] [<ffffffffa0065719>] ? rbd_put_client.isra.10+0x28/0x3d [rbd]
> [ 99.701324] [<ffffffffa006609d>] ? rbd_dev_release+0xc3/0x157 [rbd]
> [ 99.701328] [<ffffffff81287387>] ? device_release+0x41/0x72
> [ 99.701334] [<ffffffff81202b95>] ? kobject_release+0x4e/0x6a
> [ 99.701343] [<ffffffffa0065156>] ? rbd_remove+0x102/0x11e [rbd]
> [ 99.701352] [<ffffffff8114b058>] ? sysfs_write_file+0xd3/0x10f
> [ 99.701361] [<ffffffff810f8796>] ? vfs_write+0xaa/0x136
> [ 99.701369] [<ffffffff810f8a07>] ? sys_write+0x45/0x6e
> [ 99.701377] [<ffffffff8146a839>] ? system_call_fastpath+0x16/0x1b
> 
> 
> On Wed, May 16, 2012 at 12:24 PM, Andrey Korolyov <andrey@xdel.ru (mailto:andrey@xdel.ru)> wrote:
> > > This is most likely due to a recently-fixed problem.
> > > The fix is found in this commit, although there were
> > > other changes that led up to it:
> > > 32eec68d2f rbd: don't drop the rbd_id too early
> > > It is present starting in Linux kernel 3.3; it appears
> > > you are running 2.6?
> > 
> > 
> > 
> > Nope, it`s just Debian kernel naming - they continue to name 3.x with
> > 2.6 and I`m following them at own build naming. I have tried that on
> > 3.2 first time, and just a couple of minutes ago on my notebook with
> > 3.3.4 over relatively slow vpn connection - rbd failed with almost
> > same backtrace(I have removed sleep from cycle and bug has been
> > reproduce immediately after first map-unmap) and kernel has panicked
> > after approx. four minutes when I stopped 'for...' execution,
> > unfortunately no bt of panic because of X and lack of configured
> > netconsole :) The symptoms are the same - 'rbd showmapped' shows
> > latest volume, but unmap failed with 'xxx is not a block device remove
> > failed: (22) Invalid argument' and a couple of 'null pointer
> > dereference' messages in dmesg. I have used /dev/rbd0 instead of
> > symlinks to reduce probability of involving udev-related timeout on
> > symlinks creation.
> > 
> > On Tue, May 15, 2012 at 7:40 PM, Josh Durgin <josh.durgin@inktank.com (mailto:josh.durgin@inktank.com)> wrote:
> > > On 05/15/2012 04:49 AM, Andrey Korolyov wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > There are strange bug when I tried to map excessive amounts of block
> > > > devices inside the pool, like following
> > > > 
> > > > for vol in $(rbd ls); do rbd map $vol; [some-microsleep]; [some
> > > > operation or nothing, I have stubbed guestfs mount here] ;
> > > > [some-microsleep]; unmap /dev/rbd/rbd/$vol ; [some-microsleep]; done,
> > > > 
> > > > udev or rbd seems to be somehow late and mapping fails. There is no
> > > > real-world harm at all, and such case can be easily avoided, but on
> > > > busy cluster timeout increases and I was able to catch same thing on
> > > > two-osd config in recovering state. For 0.1 second on healthy cluster,
> > > > all works okay, for 0.05 it may fail with following trace(just for me,
> > > > because I am testing on relatively old and crappy hardware, so others
> > > > may catch that on smaller intervals):
> > > 
> > > 
> > > 
> > > 
> > > udev is asynchronous by nature. The rbd tool itself doesn't wait for
> > > /dev to be populated because you may not be using the default udev rule
> > > (or not using udev at all). Our test framework polls for the device to
> > > make sure 'rbd map' and udev completed:
> > > 
> > > https://github.com/ceph/teuthology/blob/d6b9bd8b63c8c6c1181ece1f6941829d8d1d5152/teuthology/task/rbd.py#L190
> > > 
> > > Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



