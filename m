From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Issue with Ceph File System and LIO
Date: Fri, 18 Dec 2015 12:05:18 +0800
Message-ID: <CAAM7YAkTA9skmSxyEPVnEWAyykg4hsoLwxxjFp2nJgMbJAC8VQ@mail.gmail.com>
References: <CA+9C14a0E9bc+GL-QiAxPD_B9_PRhEE4PRG2jAa9REWkdNQFiA@mail.gmail.com>
	<CAAM7YAk=U7NqEujuMXAyem00NDJfx-TOYGgJez76f48HS6nt2A@mail.gmail.com>
	<CA+9C14ZOZQcWSGL8ukDeVQAtoTEDRNOLq=CB1ZusiMsx6-seMw@mail.gmail.com>
	<CAAM7YAnktfNvd-EXU+1Eok4kUafWwnvj+CCGocF7ffTcAt-dsA@mail.gmail.com>
	<CA+9C14bbtBjgOD0hpSfapRrsx+Eg_dYyFfV+uXvgB5X7eRidDg@mail.gmail.com>
	<CA+9C14bMs1u80P3g1D4QsDHHzLy5YUvB+KWmcrKa0o5aX9W38g@mail.gmail.com>
	<CAAM7YAm2r+LVPMpE_GbWCJmE-bdi-uXHyzqAR1JgPMXCSx55pQ@mail.gmail.com>
	<CA+9C14bVgWKMxxOe04qiLW6U+baA_TGbFt9RNjY+wPNMiW_R3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c36b046120710527243fa3
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33592 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbbLREFV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 23:05:21 -0500
Received: by mail-lb0-f171.google.com with SMTP id kw15so56979761lbb.0
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 20:05:20 -0800 (PST)
In-Reply-To: <CA+9C14bVgWKMxxOe04qiLW6U+baA_TGbFt9RNjY+wPNMiW_R3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Eastman <eric.eastman@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--001a11c36b046120710527243fa3
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 18, 2015 at 3:49 AM, Eric Eastman
<eric.eastman@keepertech.com> wrote:
> With cephfs.patch and cephfs1.patch applied and I am now seeing:
>
> [Thu Dec 17 14:27:59 2015] ------------[ cut here ]------------
> [Thu Dec 17 14:27:59 2015] WARNING: CPU: 0 PID: 3036 at
> fs/ceph/addr.c:1171 ceph_write_begin+0xfb/0x120 [ceph]()
> [Thu Dec 17 14:27:59 2015] Modules linked in: iscsi_target_mod
> vhost_scsi tcm_qla2xxx ib_srpt tcm_fc tcm_usb_gadget tcm_loop
> target_core_file target_core_iblock target_core_pscsi target_core_user
> target_core_mod ipmi_devintf vhost qla2xxx ib_cm ib_sa ib_mad ib_core
> ib_addr libfc scsi_transport_fc libcomposite udc_core uio configfs ttm
> drm_kms_helper drm ipmi_ssif coretemp gpio_ich i2c_algo_bit kvm
> fb_sys_fops syscopyarea sysfillrect sysimgblt shpchp input_leds ceph
> irqbypass i7core_edac serio_raw hpilo edac_core ipmi_si
> ipmi_msghandler 8250_fintek lpc_ich acpi_power_meter libceph mac_hid
> libcrc32c fscache bonding lp parport mlx4_en vxlan ip6_udp_tunnel
> udp_tunnel ptp pps_core hid_generic usbhid hid mlx4_core hpsa psmouse
> bnx2 fjes scsi_transport_sas [last unloaded: target_core_mod]
> [Thu Dec 17 14:27:59 2015] CPU: 0 PID: 3036 Comm: iscsi_trx Tainted: G
>        W I     4.4.0-rc4-ede2 #1
> [Thu Dec 17 14:27:59 2015] Hardware name: HP ProLiant DL360 G6, BIOS
> P64 01/22/2015
> [Thu Dec 17 14:27:59 2015]  ffffffffc02b2e37 ffff880c0289b958
> ffffffff813ad644 0000000000000000
> [Thu Dec 17 14:27:59 2015]  ffff880c0289b990 ffffffff81079702
> ffff880c0289ba50 0000000846c21000
> [Thu Dec 17 14:27:59 2015]  ffff880c009ea200 0000000000001000
> ffffea00122ed700 ffff880c0289b9a0
> [Thu Dec 17 14:27:59 2015] Call Trace:
> [Thu Dec 17 14:27:59 2015]  [<ffffffff813ad644>] dump_stack+0x44/0x60
> [Thu Dec 17 14:27:59 2015]  [<ffffffff81079702>] warn_slowpath_common+0x82/0xc0
> [Thu Dec 17 14:27:59 2015]  [<ffffffff810797fa>] warn_slowpath_null+0x1a/0x20
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc028b41b>]
> ceph_write_begin+0xfb/0x120 [ceph]
> [Thu Dec 17 14:27:59 2015]  [<ffffffff8117c8df>]
> generic_perform_write+0xbf/0x1a0
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc0285f9c>]
> ceph_write_iter+0xf5c/0x1010 [ceph]
> [Thu Dec 17 14:27:59 2015]  [<ffffffff817c3396>] ? __schedule+0x386/0x9c0
> [Thu Dec 17 14:27:59 2015]  [<ffffffff817c3a05>] ? schedule+0x35/0x80
> [Thu Dec 17 14:27:59 2015]  [<ffffffff811d7c65>] ? __slab_free+0xb5/0x290
> [Thu Dec 17 14:27:59 2015]  [<ffffffff813c0003>] ?
> iov_iter_get_pages+0x113/0x210
> [Thu Dec 17 14:27:59 2015]  [<ffffffff811f6c93>] vfs_iter_write+0x63/0xa0
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc02d2f29>]
> fd_do_rw.isra.5+0xc9/0x1b0 [target_core_file]
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc02d30d5>]
> fd_execute_rw+0xc5/0x2a0 [target_core_file]
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc0430e72>]
> sbc_execute_rw+0x22/0x30 [target_core_mod]
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc042f9cf>]
> __target_execute_cmd+0x1f/0x70 [target_core_mod]
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc0430525>]
> target_execute_cmd+0x195/0x2a0 [target_core_mod]
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc05b778a>]
> iscsit_execute_cmd+0x20a/0x270 [iscsi_target_mod]
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc05c08da>]
> iscsit_sequence_cmd+0xda/0x190 [iscsi_target_mod]
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc05c6c4d>]
> iscsi_target_rx_thread+0x51d/0xe30 [iscsi_target_mod]
> [Thu Dec 17 14:27:59 2015]  [<ffffffff8101463d>] ? __switch_to+0x1cd/0x570
> [Thu Dec 17 14:27:59 2015]  [<ffffffffc05c6730>] ?
> iscsi_target_tx_thread+0x1c0/0x1c0 [iscsi_target_mod]
> [Thu Dec 17 14:27:59 2015]  [<ffffffff810974c9>] kthread+0xc9/0xe0
> [Thu Dec 17 14:27:59 2015]  [<ffffffff81097400>] ?
> kthread_create_on_node+0x180/0x180
> [Thu Dec 17 14:27:59 2015]  [<ffffffff817c794f>] ret_from_fork+0x3f/0x70
> [Thu Dec 17 14:27:59 2015]  [<ffffffff81097400>] ?
> kthread_create_on_node+0x180/0x180
> [Thu Dec 17 14:27:59 2015] ---[ end trace 8346192e3f29ed5d ]---
>

The page gets unlocked mystically. I still don't find any clue. Could
you please try the new patch (not incremental patch). Besides, please
enable CONFIG_DEBUG_VM when compiling the kernel.

Thanks you very much
Yan, Zheng

--001a11c36b046120710527243fa3
Content-Type: application/octet-stream; name="cephfs_new.patch"
Content-Disposition: attachment; filename="cephfs_new.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iib579zs0

ZGlmZiAtLWdpdCBhL2ZzL2NlcGgvYWRkci5jIGIvZnMvY2VwaC9hZGRyLmMKaW5kZXggYjdkMjE4
YS4uM2I2OWY4ZiAxMDA2NDQKLS0tIGEvZnMvY2VwaC9hZGRyLmMKKysrIGIvZnMvY2VwaC9hZGRy
LmMKQEAgLTE5OSw2ICsxOTksOCBAQCBzdGF0aWMgaW50IHJlYWRwYWdlX25vdW5sb2NrKHN0cnVj
dCBmaWxlICpmaWxwLCBzdHJ1Y3QgcGFnZSAqcGFnZSkKIAl1NjQgb2ZmID0gcGFnZV9vZmZzZXQo
cGFnZSk7CiAJdTY0IGxlbiA9IFBBR0VfQ0FDSEVfU0laRTsKIAorCVdBUk5fT04oIVBhZ2VMb2Nr
ZWQocGFnZSkpOworCiAJaWYgKG9mZiA+PSBpX3NpemVfcmVhZChpbm9kZSkpIHsKIAkJemVyb191
c2VyX3NlZ21lbnQocGFnZSwgMCwgUEFHRV9DQUNIRV9TSVpFKTsKIAkJU2V0UGFnZVVwdG9kYXRl
KHBhZ2UpOwpAQCAtNDg3LDYgKzQ4OSw3IEBAIHN0YXRpYyBpbnQgd3JpdGVwYWdlX25vdW5sb2Nr
KHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3Qgd3JpdGViYWNrX2NvbnRyb2wgKndiYykKIAlpbnQg
ZXJyID0gMCwgbGVuID0gUEFHRV9DQUNIRV9TSVpFOwogCiAJZG91dCgid3JpdGVwYWdlICVwIGlk
eCAlbHVcbiIsIHBhZ2UsIHBhZ2UtPmluZGV4KTsKKwlXQVJOX09OKCFQYWdlTG9ja2VkKHBhZ2Up
KTsKIAogCWlmICghcGFnZS0+bWFwcGluZyB8fCAhcGFnZS0+bWFwcGluZy0+aG9zdCkgewogCQlk
b3V0KCJ3cml0ZXBhZ2UgJXAgLSBubyBtYXBwaW5nXG4iLCBwYWdlKTsKQEAgLTEwNTUsOSArMTA1
OCwxNSBAQCBzdGF0aWMgaW50IGNlcGhfdXBkYXRlX3dyaXRlYWJsZV9wYWdlKHN0cnVjdCBmaWxl
ICpmaWxlLAogCWludCByOwogCXN0cnVjdCBjZXBoX3NuYXBfY29udGV4dCAqc25hcGMsICpvbGRl
c3Q7CiAKKwlpbnQgbGFzdF9vcCA9IDA7CiByZXRyeV9sb2NrZWQ6CiAJLyogd3JpdGVwYWdlcyBj
dXJyZW50bHkgaG9sZHMgcGFnZSBsb2NrLCBidXQgaWYgd2UgY2hhbmdlIHRoYXQgbGF0ZXIsICov
CisJV0FSTl9PTihQYWdlV3JpdGViYWNrKHBhZ2UpKTsKKwlpZiAoIVBhZ2VMb2NrZWQocGFnZSkp
CisJCXByX2VycigicGFnZSBpcyB1bmxvY2tlZCBiZWZvcmUgd2FpdCB3cml0ZWJhY2sgJXAsIGxh
c3Qgb3AgJWRcbiIsIHBhZ2UsIGxhc3Rfb3ApOwogCXdhaXRfb25fcGFnZV93cml0ZWJhY2socGFn
ZSk7CisJaWYgKCFQYWdlTG9ja2VkKHBhZ2UpKQorCQlwcl9lcnIoInBhZ2UgaXMgdW5sb2NrZWQg
YWZ0ZXIgd2FpdCB3cml0ZWJhY2sgJXAgbGFzdCBvcCAlZFxuIiwgcGFnZSwgbGFzdF9vcCk7CiAK
IAlzbmFwYyA9IHBhZ2Vfc25hcF9jb250ZXh0KHBhZ2UpOwogCWlmIChzbmFwYyAmJiBzbmFwYyAh
PSBjaS0+aV9oZWFkX3NuYXBjKSB7CkBAIC0xMDgxLDE4ICsxMDkwLDI2IEBAIHJldHJ5X2xvY2tl
ZDoKIAkJCXIgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUoY2ktPmlfY2FwX3dxLAogCQkJICAg
ICAgIGNvbnRleHRfaXNfd3JpdGVhYmxlX29yX3dyaXR0ZW4oaW5vZGUsIHNuYXBjKSk7CiAJCQlj
ZXBoX3B1dF9zbmFwX2NvbnRleHQoc25hcGMpOwotCQkJaWYgKHIgPT0gLUVSRVNUQVJUU1lTKQot
CQkJCXJldHVybiByOwotCQkJcmV0dXJuIC1FQUdBSU47CisJCQlpZiAociAhPSAtRVJFU1RBUlRT
WVMpCisJCQkJciA9IC1FQUdBSU47CisJCQlwcl9lcnIoInVwZGF0ZV93cml0ZWFibGVfcGFnZSBu
byBzbmFwYyAlcCAlZFxuIiwgcGFnZSwgcik7CisJCQlyZXR1cm4gcjsKIAkJfQogCQljZXBoX3B1
dF9zbmFwX2NvbnRleHQob2xkZXN0KTsKIAogCQkvKiB5YXksIHdyaXRlYWJsZSwgZG8gaXQgbm93
ICh3aXRob3V0IGRyb3BwaW5nIHBhZ2UgbG9jaykgKi8KIAkJZG91dCgiIHBhZ2UgJXAgc25hcGMg
JXAgbm90IGN1cnJlbnQsIGJ1dCBvbGRlc3RcbiIsCiAJCSAgICAgcGFnZSwgc25hcGMpOwotCQlp
ZiAoIWNsZWFyX3BhZ2VfZGlydHlfZm9yX2lvKHBhZ2UpKQorCQlpZiAoIWNsZWFyX3BhZ2VfZGly
dHlfZm9yX2lvKHBhZ2UpKSB7CisJCQlsYXN0X29wID0gMTsKKwkJCWlmICghUGFnZUxvY2tlZChw
YWdlKSkKKwkJCQlwcl9lcnIoImNsZWFyX3BhZ2VfZGlydHlfZm9yX2lvIHVubG9ja3MgJXBcbiIs
IHBhZ2UpOwogCQkJZ290byByZXRyeV9sb2NrZWQ7CisJCX0KIAkJciA9IHdyaXRlcGFnZV9ub3Vu
bG9jayhwYWdlLCBOVUxMKTsKKwkJbGFzdF9vcCA9IDI7CisJCWlmICghUGFnZUxvY2tlZChwYWdl
KSkKKwkJCXByX2Vycigid3JpdGVwYWdlX25vdW5sb2NrIHVubG9ja3MgJXAgJWRcbiIsIHBhZ2Us
IHIpOwogCQlpZiAociA8IDApCiAJCQlnb3RvIGZhaWxfbm9zbmFwOwogCQlnb3RvIHJldHJ5X2xv
Y2tlZDsKQEAgLTExMjMsMTEgKzExNDAsMTUgQEAgcmV0cnlfbG9ja2VkOgogCiAJLyogd2UgbmVl
ZCB0byByZWFkIGl0LiAqLwogCXIgPSByZWFkcGFnZV9ub3VubG9jayhmaWxlLCBwYWdlKTsKKwls
YXN0X29wID0gMzsKKwlpZiAoIVBhZ2VMb2NrZWQocGFnZSkpCisJCXByX2VycigicmVhZHBhZ2Vf
bm91bmxvY2sgdW5sb2NrcyAlcCAlZFxuIiwgcGFnZSwgcik7CiAJaWYgKHIgPCAwKQogCQlnb3Rv
IGZhaWxfbm9zbmFwOwogCWdvdG8gcmV0cnlfbG9ja2VkOwogZmFpbF9ub3NuYXA6CiAJdW5sb2Nr
X3BhZ2UocGFnZSk7CisJcHJfZXJyKCJ1cGRhdGVfd3JpdGVhYmxlX3BhZ2UgZmFpbGVkICVwICVk
XG4iLCBwYWdlLCByKTsKIAlyZXR1cm4gcjsKIH0KIApAQCAtMTE0OSwxNiArMTE3MCwxOSBAQCBz
dGF0aWMgaW50IGNlcGhfd3JpdGVfYmVnaW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRy
ZXNzX3NwYWNlICptYXBwaW5nLAogCQlwYWdlID0gZ3JhYl9jYWNoZV9wYWdlX3dyaXRlX2JlZ2lu
KG1hcHBpbmcsIGluZGV4LCAwKTsKIAkJaWYgKCFwYWdlKQogCQkJcmV0dXJuIC1FTk9NRU07CisJ
CVdBUk5fT04oIVBhZ2VMb2NrZWQocGFnZSkpOwogCQkqcGFnZXAgPSBwYWdlOwogCiAJCWRvdXQo
IndyaXRlX2JlZ2luIGZpbGUgJXAgaW5vZGUgJXAgcGFnZSAlcCAlZH4lZFxuIiwgZmlsZSwKIAkJ
ICAgICBpbm9kZSwgcGFnZSwgKGludClwb3MsIChpbnQpbGVuKTsKIAogCQlyID0gY2VwaF91cGRh
dGVfd3JpdGVhYmxlX3BhZ2UoZmlsZSwgcG9zLCBsZW4sIHBhZ2UpOwotCQlpZiAociA8IDApCisJ
CWlmIChyIDwgMCkgewogCQkJcGFnZV9jYWNoZV9yZWxlYXNlKHBhZ2UpOwotCQllbHNlCisJCX0g
ZWxzZSB7CisJCQlXQVJOX09OKCFQYWdlTG9ja2VkKHBhZ2UpKTsKIAkJCSpwYWdlcCA9IHBhZ2U7
CisJCX0KIAl9IHdoaWxlIChyID09IC1FQUdBSU4pOwogCiAJcmV0dXJuIHI7CkBAIC0xMzc4LDEx
ICsxNDAyLDEzIEBAIHN0YXRpYyBpbnQgY2VwaF9wYWdlX21rd3JpdGUoc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEsIHN0cnVjdCB2bV9mYXVsdCAqdm1mKQogCiAJcmV0ID0gVk1fRkFVTFRfTk9Q
QUdFOwogCWlmICgob2ZmID4gc2l6ZSkgfHwKLQkgICAgKHBhZ2UtPm1hcHBpbmcgIT0gaW5vZGUt
PmlfbWFwcGluZykpCisJICAgIChwYWdlLT5tYXBwaW5nICE9IGlub2RlLT5pX21hcHBpbmcpKSB7
CisJCXVubG9ja19wYWdlKHBhZ2UpOwogCQlnb3RvIG91dDsKKwl9CiAKIAlyZXQgPSBjZXBoX3Vw
ZGF0ZV93cml0ZWFibGVfcGFnZSh2bWEtPnZtX2ZpbGUsIG9mZiwgbGVuLCBwYWdlKTsKLQlpZiAo
cmV0ID09IDApIHsKKwlpZiAocmV0ID49IDApIHsKIAkJLyogc3VjY2Vzcy4gIHdlJ2xsIGtlZXAg
dGhlIHBhZ2UgbG9ja2VkLiAqLwogCQlzZXRfcGFnZV9kaXJ0eShwYWdlKTsKIAkJcmV0ID0gVk1f
RkFVTFRfTE9DS0VEOwpAQCAtMTM5Myw4ICsxNDE5LDYgQEAgc3RhdGljIGludCBjZXBoX3BhZ2Vf
bWt3cml0ZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgc3RydWN0IHZtX2ZhdWx0ICp2bWYp
CiAJCQlyZXQgPSBWTV9GQVVMVF9TSUdCVVM7CiAJfQogb3V0OgotCWlmIChyZXQgIT0gVk1fRkFV
TFRfTE9DS0VEKQotCQl1bmxvY2tfcGFnZShwYWdlKTsKIAlpZiAocmV0ID09IFZNX0ZBVUxUX0xP
Q0tFRCB8fAogCSAgICBjaS0+aV9pbmxpbmVfdmVyc2lvbiAhPSBDRVBIX0lOTElORV9OT05FKSB7
CiAJCWludCBkaXJ0eTsK
--001a11c36b046120710527243fa3--
