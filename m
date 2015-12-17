From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Issue with Ceph File System and LIO
Date: Thu, 17 Dec 2015 17:38:06 +0800
Message-ID: <CAAM7YAm2r+LVPMpE_GbWCJmE-bdi-uXHyzqAR1JgPMXCSx55pQ@mail.gmail.com>
References: <CA+9C14a0E9bc+GL-QiAxPD_B9_PRhEE4PRG2jAa9REWkdNQFiA@mail.gmail.com>
	<CAAM7YAk=U7NqEujuMXAyem00NDJfx-TOYGgJez76f48HS6nt2A@mail.gmail.com>
	<CA+9C14ZOZQcWSGL8ukDeVQAtoTEDRNOLq=CB1ZusiMsx6-seMw@mail.gmail.com>
	<CAAM7YAnktfNvd-EXU+1Eok4kUafWwnvj+CCGocF7ffTcAt-dsA@mail.gmail.com>
	<CA+9C14bbtBjgOD0hpSfapRrsx+Eg_dYyFfV+uXvgB5X7eRidDg@mail.gmail.com>
	<CA+9C14bMs1u80P3g1D4QsDHHzLy5YUvB+KWmcrKa0o5aX9W38g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11419fc0b5a95a052714c71e
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35627 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbLQJiI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 04:38:08 -0500
Received: by mail-lf0-f43.google.com with SMTP id l133so47516752lfd.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 01:38:07 -0800 (PST)
In-Reply-To: <CA+9C14bMs1u80P3g1D4QsDHHzLy5YUvB+KWmcrKa0o5aX9W38g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Eastman <eric.eastman@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--001a11419fc0b5a95a052714c71e
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 17, 2015 at 4:56 PM, Eric Eastman
<eric.eastman@keepertech.com> wrote:
> I patched the 4.4rc4 kernel source and restarted the test.  Shortly
> after starting it, this showed up in dmesg:
>
> [Thu Dec 17 03:29:55 2015] WARNING: CPU: 0 PID: 2547 at
> fs/ceph/addr.c:1162 ceph_write_begin+0xfb/0x120 [ceph]()
> [Thu Dec 17 03:29:55 2015] Modules linked in: iscsi_target_mod
> vhost_scsi tcm_qla2xxx ib_srpt tcm_fc tcm_usb_gadget tcm_loop
> target_core_file target_core_iblock target_core_pscsi target_core_user
> target_core_mod ipmi_devintf vhost qla2xxx ib_cm ib_sa ib_mad ib_core
> ib_addr libfc scsi_transport_fc libcomposite udc_core uio configfs ttm
> ipmi_ssif drm_kms_helper drm coretemp kvm gpio_ich i2c_algo_bit
> i7core_edac fb_sys_fops syscopyarea edac_core sysfillrect sysimgblt
> ipmi_si input_leds hpilo ipmi_msghandler shpchp acpi_power_meter
> irqbypass serio_raw 8250_fintek lpc_ich mac_hid ceph bonding libceph
> lp parport libcrc32c fscache mlx4_en vxlan ip6_udp_tunnel udp_tunnel
> ptp pps_core hid_generic usbhid hid mlx4_core hpsa psmouse bnx2 fjes
> scsi_transport_sas [last unloaded: target_core_mod]
> [Thu Dec 17 03:29:55 2015] CPU: 0 PID: 2547 Comm: iscsi_trx Tainted: G
>        W I     4.4.0-rc4-ede1 #1
> [Thu Dec 17 03:29:55 2015] Hardware name: HP ProLiant DL360 G6, BIOS
> P64 01/22/2015
> [Thu Dec 17 03:29:55 2015]  ffffffffc020cd47 ffff8805f1e97958
> ffffffff813ad644 0000000000000000
> [Thu Dec 17 03:29:55 2015]  ffff8805f1e97990 ffffffff81079702
> ffff8805f1e97a50 00000000015dd000
> [Thu Dec 17 03:29:55 2015]  ffff880c034df800 0000000000000200
> ffffea0000b26a80 ffff8805f1e979a0
> [Thu Dec 17 03:29:55 2015] Call Trace:
> [Thu Dec 17 03:29:55 2015]  [<ffffffff813ad644>] dump_stack+0x44/0x60
> [Thu Dec 17 03:29:55 2015]  [<ffffffff81079702>] warn_slowpath_common+0x82/0xc0
> [Thu Dec 17 03:29:55 2015]  [<ffffffff810797fa>] warn_slowpath_null+0x1a/0x20
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc01e53bb>]
> ceph_write_begin+0xfb/0x120 [ceph]
> [Thu Dec 17 03:29:55 2015]  [<ffffffff8117c8df>]
> generic_perform_write+0xbf/0x1a0
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc01dff9c>]
> ceph_write_iter+0xf5c/0x1010 [ceph]
> [Thu Dec 17 03:29:55 2015]  [<ffffffff810a888c>] ? __enqueue_entity+0x6c/0x70
> [Thu Dec 17 03:29:55 2015]  [<ffffffff813c0003>] ?
> iov_iter_get_pages+0x113/0x210
> [Thu Dec 17 03:29:55 2015]  [<ffffffff816b6802>] ?
> skb_copy_datagram_iter+0x122/0x250
> [Thu Dec 17 03:29:55 2015]  [<ffffffff811f6c93>] vfs_iter_write+0x63/0xa0
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc03c3f29>]
> fd_do_rw.isra.5+0xc9/0x1b0 [target_core_file]
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc03c40d5>]
> fd_execute_rw+0xc5/0x2a0 [target_core_file]
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc0445e72>]
> sbc_execute_rw+0x22/0x30 [target_core_mod]
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc04449cf>]
> __target_execute_cmd+0x1f/0x70 [target_core_mod]
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc0445525>]
> target_execute_cmd+0x195/0x2a0 [target_core_mod]
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc05c978a>]
> iscsit_execute_cmd+0x20a/0x270 [iscsi_target_mod]
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc05d28da>]
> iscsit_sequence_cmd+0xda/0x190 [iscsi_target_mod]
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc05d8c4d>]
> iscsi_target_rx_thread+0x51d/0xe30 [iscsi_target_mod]
> [Thu Dec 17 03:29:55 2015]  [<ffffffff8101463d>] ? __switch_to+0x1cd/0x570
> [Thu Dec 17 03:29:55 2015]  [<ffffffffc05d8730>] ?
> iscsi_target_tx_thread+0x1c0/0x1c0 [iscsi_target_mod]
> [Thu Dec 17 03:29:55 2015]  [<ffffffff810974c9>] kthread+0xc9/0xe0
> [Thu Dec 17 03:29:55 2015]  [<ffffffff81097400>] ?
> kthread_create_on_node+0x180/0x180
> [Thu Dec 17 03:29:55 2015]  [<ffffffff817c794f>] ret_from_fork+0x3f/0x70
> [Thu Dec 17 03:29:55 2015]  [<ffffffff81097400>] ?
> kthread_create_on_node+0x180/0x180
> [Thu Dec 17 03:29:55 2015] ---[ end trace 382a45986961da4e ]---


Could you please try the apply the new incremental patch and try again.


Regards
Yan, Zheng


>
> There are WARNINGs on both line 125 and 1162. I will attached the
> whole set of dmesg output to the tracker ticket 14086
>
> I wanted to note that file system snapshots are enabled and being used
> on this file system.
>
> Thanks
> Eric
>
> On Wed, Dec 16, 2015 at 8:15 AM, Eric Eastman
> <eric.eastman@keepertech.com> wrote:
>>>>
>>> This warning is really strange. Could you try the attached debug patch.
>>>
>>> Regards
>>> Yan, Zheng
>>
>> I will try the patch and get back to the list.
>>
>> Eric

--001a11419fc0b5a95a052714c71e
Content-Type: application/octet-stream; name="cephfs1.patch"
Content-Disposition: attachment; filename="cephfs1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iia20b0n0

ZGlmZiAtLWdpdCBhL2ZzL2NlcGgvYWRkci5jIGIvZnMvY2VwaC9hZGRyLmMKaW5kZXggYjdkMjE4
YS4uZDVlYTBmMyAxMDA2NDQKLS0tIGEvZnMvY2VwaC9hZGRyLmMKKysrIGIvZnMvY2VwaC9hZGRy
LmMKQEAgLTEwODEsMTggKzEwODEsMjQgQEAgcmV0cnlfbG9ja2VkOgogCQkJciA9IHdhaXRfZXZl
bnRfaW50ZXJydXB0aWJsZShjaS0+aV9jYXBfd3EsCiAJCQkgICAgICAgY29udGV4dF9pc193cml0
ZWFibGVfb3Jfd3JpdHRlbihpbm9kZSwgc25hcGMpKTsKIAkJCWNlcGhfcHV0X3NuYXBfY29udGV4
dChzbmFwYyk7Ci0JCQlpZiAociA9PSAtRVJFU1RBUlRTWVMpCi0JCQkJcmV0dXJuIHI7Ci0JCQly
ZXR1cm4gLUVBR0FJTjsKKwkJCWlmIChyICE9IC1FUkVTVEFSVFNZUykKKwkJCQlyID0gLUVBR0FJ
TjsKKwkJCXByX2VycigidXBkYXRlX3dyaXRlYWJsZV9wYWdlIG5vIHNuYXBjICVwICVkXG4iLCBw
YWdlLCByKTsKKwkJCXJldHVybiByOwogCQl9CiAJCWNlcGhfcHV0X3NuYXBfY29udGV4dChvbGRl
c3QpOwogCiAJCS8qIHlheSwgd3JpdGVhYmxlLCBkbyBpdCBub3cgKHdpdGhvdXQgZHJvcHBpbmcg
cGFnZSBsb2NrKSAqLwogCQlkb3V0KCIgcGFnZSAlcCBzbmFwYyAlcCBub3QgY3VycmVudCwgYnV0
IG9sZGVzdFxuIiwKIAkJICAgICBwYWdlLCBzbmFwYyk7Ci0JCWlmICghY2xlYXJfcGFnZV9kaXJ0
eV9mb3JfaW8ocGFnZSkpCisJCWlmICghY2xlYXJfcGFnZV9kaXJ0eV9mb3JfaW8ocGFnZSkpIHsK
KwkJCWlmICghUGFnZUxvY2tlZChwYWdlKSkKKwkJCQlwcl9lcnIoImNsZWFyX3BhZ2VfZGlydHlf
Zm9yX2lvIHVubG9ja3MgJXBcbiIsIHBhZ2UpOwogCQkJZ290byByZXRyeV9sb2NrZWQ7CisJCX0K
IAkJciA9IHdyaXRlcGFnZV9ub3VubG9jayhwYWdlLCBOVUxMKTsKKwkJaWYgKCFQYWdlTG9ja2Vk
KHBhZ2UpKQorCQkJcHJfZXJyKCJ3cml0ZXBhZ2Vfbm91bmxvY2sgdW5sb2NrcyAlcCAlZFxuIiwg
cGFnZSwgcik7CiAJCWlmIChyIDwgMCkKIAkJCWdvdG8gZmFpbF9ub3NuYXA7CiAJCWdvdG8gcmV0
cnlfbG9ja2VkOwpAQCAtMTEyMywxMSArMTEyOSwxNCBAQCByZXRyeV9sb2NrZWQ6CiAKIAkvKiB3
ZSBuZWVkIHRvIHJlYWQgaXQuICovCiAJciA9IHJlYWRwYWdlX25vdW5sb2NrKGZpbGUsIHBhZ2Up
OworCWlmICghUGFnZUxvY2tlZChwYWdlKSkKKwkJcHJfZXJyKCJyZWFkcGFnZV9ub3VubG9jayB1
bmxvY2tzICVwICVkXG4iLCBwYWdlLCByKTsKIAlpZiAociA8IDApCiAJCWdvdG8gZmFpbF9ub3Nu
YXA7CiAJZ290byByZXRyeV9sb2NrZWQ7CiBmYWlsX25vc25hcDoKIAl1bmxvY2tfcGFnZShwYWdl
KTsKKwlwcl9lcnIoInVwZGF0ZV93cml0ZWFibGVfcGFnZSBmYWlsZWQgJXAgJWRcbiIsIHBhZ2Us
IHIpOwogCXJldHVybiByOwogfQogCg==
--001a11419fc0b5a95a052714c71e--
