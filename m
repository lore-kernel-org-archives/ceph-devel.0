From: John Spray <jspray@redhat.com>
Subject: Re: Issue with Ceph File System and LIO
Date: Tue, 15 Dec 2015 10:12:27 +0000
Message-ID: <CALe9h7eH+OgKLH0EjR1ry8wPs5s2NNE7SyTtbCsA_aQHRfBQ2A@mail.gmail.com>
References: <CA+9C14a0E9bc+GL-QiAxPD_B9_PRhEE4PRG2jAa9REWkdNQFiA@mail.gmail.com>
 <566FDCCD.4090800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:32769 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964822AbbLOKMt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Dec 2015 05:12:49 -0500
Received: by mail-lf0-f46.google.com with SMTP id p203so2893217lfa.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Dec 2015 02:12:48 -0800 (PST)
In-Reply-To: <566FDCCD.4090800@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: Eric Eastman <eric.eastman@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>, Zheng Yan <ukernel@gmail.com>

On Tue, Dec 15, 2015 at 9:26 AM, Mike Christie <mchristi@redhat.com> wrote:
> On 12/15/2015 12:08 AM, Eric Eastman wrote:
>> I am testing Linux Target SCSI, LIO, with a Ceph File System backstore
>> and I am seeing this error on my LIO gateway.  I am using Ceph v9.2.0
>> on a 4.4rc4 Kernel, on Trusty, using a kernel mounted Ceph File
>> System.  A file on the Ceph File System is exported via iSCSI to a
>> VMware ESXi 5.0 server, and I am seeing this error when doing a lot of
>> I/O on the ESXi server.   Is this a LIO or a Ceph issue?
>>
>> [Tue Dec 15 00:46:55 2015] ------------[ cut here ]------------
>> [Tue Dec 15 00:46:55 2015] WARNING: CPU: 0 PID: 1123421 at
>> /home/kernel/COD/linux/fs/ceph/addr.c:125
>> ceph_set_page_dirty+0x230/0x240 [ceph]()
>> [Tue Dec 15 00:46:55 2015] Modules linked in: iptable_filter ip_tables
>> x_tables xfs rbd iscsi_target_mod vhost_scsi tcm_qla2xxx ib_srpt
>> tcm_fc tcm_usb_gadget tcm_loop target_core_file target_core_iblock
>> target_core_pscsi target_core_user target_core_mod ipmi_devintf vhost
>> qla2xxx ib_cm ib_sa ib_mad ib_core ib_addr libfc scsi_transport_fc
>> libcomposite udc_core uio configfs ipmi_ssif ttm drm_kms_helper
>> gpio_ich drm i2c_algo_bit fb_sys_fops coretemp syscopyarea ipmi_si
>> sysfillrect ipmi_msghandler sysimgblt kvm acpi_power_meter 8250_fintek
>> irqbypass hpilo shpchp input_leds serio_raw lpc_ich i7core_edac
>> edac_core mac_hid ceph libceph libcrc32c fscache bonding lp parport
>> mlx4_en vxlan ip6_udp_tunnel udp_tunnel ptp pps_core hid_generic
>> usbhid hid hpsa mlx4_core psmouse bnx2 scsi_transport_sas fjes [last
>> unloaded: target_core_mod]
>> [Tue Dec 15 00:46:55 2015] CPU: 0 PID: 1123421 Comm: iscsi_trx
>> Tainted: G        W I     4.4.0-040400rc4-generic #201512061930
>> [Tue Dec 15 00:46:55 2015] Hardware name: HP ProLiant DL360 G6, BIOS
>> P64 01/22/2015
>> [Tue Dec 15 00:46:55 2015]  0000000000000000 00000000fdc0ce43
>> ffff880bf38c38c0 ffffffff813c8ab4
>> [Tue Dec 15 00:46:55 2015]  0000000000000000 ffff880bf38c38f8
>> ffffffff8107d772 ffffea00127a8680
>> [Tue Dec 15 00:46:55 2015]  ffff8804e52c1448 ffff8804e52c15b0
>> ffff8804e52c10f0 0000000000000200
>> [Tue Dec 15 00:46:55 2015] Call Trace:
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff813c8ab4>] dump_stack+0x44/0x60
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff8107d772>] warn_slowpath_common+0x82/0xc0
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff8107d8ba>] warn_slowpath_null+0x1a/0x20
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc01fadb0>]
>> ceph_set_page_dirty+0x230/0x240 [ceph]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff81188770>] ?
>> pagecache_get_page+0x150/0x1c0
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc01fe338>] ?
>> ceph_pool_perm_check+0x48/0x700 [ceph]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff8119301d>] set_page_dirty+0x3d/0x70
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc01fcd7e>]
>> ceph_write_end+0x5e/0x180 [ceph]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff813dc006>] ?
>> iov_iter_copy_from_user_atomic+0x156/0x220
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff81187bc4>]
>> generic_perform_write+0x114/0x1c0
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc01f818a>]
>> ceph_write_iter+0xf8a/0x1050 [ceph]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc0205983>] ?
>> ceph_put_cap_refs+0x143/0x320 [ceph]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff810b10ba>] ?
>> check_preempt_wakeup+0xfa/0x220
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff811a7eec>] ? zone_statistics+0x7c/0xa0
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff813dd2ee>] ? copy_page_to_iter+0x5e/0xa0
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff816e5d22>] ?
>> skb_copy_datagram_iter+0x122/0x250
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff812053f6>] vfs_iter_write+0x76/0xc0
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc02cbf88>]
>> fd_do_rw.isra.5+0xd8/0x1e0 [target_core_file]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc02cc155>]
>> fd_execute_rw+0xc5/0x2a0 [target_core_file]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc04696f2>]
>> sbc_execute_rw+0x22/0x30 [target_core_mod]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc04681ef>]
>> __target_execute_cmd+0x1f/0x70 [target_core_mod]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc0468da5>]
>> target_execute_cmd+0x195/0x2a0 [target_core_mod]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc05db89a>]
>> iscsit_execute_cmd+0x20a/0x270 [iscsi_target_mod]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc05e4aea>]
>> iscsit_sequence_cmd+0xda/0x190 [iscsi_target_mod]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc05eafbd>]
>> iscsi_target_rx_thread+0x51d/0xe30 [iscsi_target_mod]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff8101566c>] ? __switch_to+0x1dc/0x5a0
>> [Tue Dec 15 00:46:55 2015]  [<ffffffffc05eaaa0>] ?
>> iscsi_target_tx_thread+0x1e0/0x1e0 [iscsi_target_mod]
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff8109c8b8>] kthread+0xd8/0xf0
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff8109c7e0>] ?
>> kthread_create_on_node+0x1a0/0x1a0
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff817fc58f>] ret_from_fork+0x3f/0x70
>> [Tue Dec 15 00:46:55 2015]  [<ffffffff8109c7e0>] ?
>> kthread_create_on_node+0x1a0/0x1a0
>> [Tue Dec 15 00:46:55 2015] ---[ end trace 4079437668c77cbb ]---
>> [Tue Dec 15 00:47:45 2015] ABORT_TASK: Found referenced iSCSI task_tag: 95784927
>> [Tue Dec 15 00:47:45 2015] ABORT_TASK: ref_tag: 95784927 already
>> complete, skipping

Looks likely to be a kclient bug, as it's in the newish
pool_perm_check path.  Perhaps we don't usually see this because we'd
usually hit the permissions checks earlier (or during a read).

CCing zyan, who will have a better idea than me.

Eric: you should probably go ahead and open a ticket for this.

John

>>
>
>
> For writes, LIO just allocates pages using GFP_KERNEL, passes them to
> sock_recvmsg to read the data into them, then passes them to the fs
> using the function you see above, vfs_iter_write. So it does not do
> anything fancy.
>
> Do we need to send specific types of pages to ceph?
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
