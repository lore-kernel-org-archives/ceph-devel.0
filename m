From: =?UTF-8?B?5byg5bmz?= <alan.zhang@linux.com>
Subject: cephx disable to enable cause kernel bug
Date: Fri, 8 Apr 2016 12:11:04 +0800
Message-ID: <BLU436-SMTP13708EF493613240113CA7485910@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s23.hotmail.com ([65.55.111.162]:62430 "EHLO
	BLU004-OMC4S23.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750758AbcDHEOw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 00:14:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sweil@redhat.com

Hi,

I change cephx  disable to enable, when restart ceph luster it will be cause some osd node host kernel panic.
Maybe it is a bug.

OS: Ubuntu 14.04.4
Kernel : 4.2.0-34-generic
Ceph Version: 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)

/var/log/syslog:
Apr  8 11:41:30 mon01 kernel: [262666.476487] libceph: osd63 up
Apr  8 11:41:30 mon01 kernel: [262666.476488] libceph: osd64 up
Apr  8 11:41:30 mon01 kernel: [262666.476488] libceph: osd66 up
Apr  8 11:41:30 mon01 kernel: [262666.476489] libceph: osd67 up
Apr  8 11:41:30 mon01 kernel: [262666.476490] libceph: osd68 up
Apr  8 11:41:30 mon01 kernel: [262666.476491] libceph: osd69 up
Apr  8 11:41:30 mon01 kernel: [262666.476491] libceph: osd70 up
Apr  8 11:41:30 mon01 kernel: [262666.476508] libceph: mon2 172.24.1.60:6789 session established
Apr  8 11:41:35 mon01 kernel: [262671.341710] libceph: osd35 172.24.1.63:6820 socket closed (con state CONNECTING)
Apr  8 11:41:39 mon01 kernel: [262671.478117] libceph: osd5 down
Apr  8 11:41:39 mon01 kernel: [262671.478136] libceph: osd5 up
Apr  8 11:41:39 mon01 kernel: [262671.478137] libceph: osd11 down
Apr  8 11:41:39 mon01 kernel: [262671.478138] libceph: osd29 down
Apr  8 11:41:39 mon01 kernel: [262671.478139] libceph: osd35 down
Apr  8 11:41:39 mon01 kernel: [262671.478140] libceph: osd47 down
Apr  8 11:41:39 mon01 kernel: [262671.478140] libceph: osd65 down
Apr  8 11:41:39 mon01 kernel: [262671.478162] BUG: unable to handle kernel paging request at ffffebe000000000
Apr  8 11:41:39 mon01 kernel: [262671.531460] IP: [<ffffffff811cd04a>] kfree+0x5a/0x130
Apr  8 11:41:39 mon01 kernel: [262671.584334] PGD 0 
Apr  8 11:41:39 mon01 kernel: [262671.635847] Oops: 0000 [#1] SMP 
Apr  8 11:41:39 mon01 kernel: [262671.686779] Modules linked in: rbd libceph xfs libcrc32c iptable_filter ip_tables ip6table_filter ip6_tables x_tables x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipmi_ssif kvm ipmi_devintf crct10dif_pclmul crc32_pclmul aesni_intel aes_x86_64 lrw gf128mul glue_helper dcdbas ablk_helper cryptd mei_me sb_edac joydev input_leds lpc_ich wmi edac_core shpchp mei ipmi_si 8250_fintek ipmi_msghandler acpi_power_meter acpi_pad mac_hid bonding hid_generic usbhid hid ahci libahci igb i2c_algo_bit megaraid_sas dca ptp pps_core
Apr  8 11:41:39 mon01 kernel: [262672.055841] CPU: 22 PID: 2961272 Comm: kworker/22:2 Not tainted 4.2.0-34-generic #39~14.04.1-Ubuntu
Apr  8 11:41:39 mon01 kernel: [262672.162338] Hardware name: Dell Inc. PowerEdge R720/068CDY, BIOS 2.4.3 07/09/2014
Apr  8 11:41:39 mon01 kernel: [262672.268937] Workqueue: ceph-msgr con_work [libceph]
Apr  8 11:41:39 mon01 kernel: [262672.322290] task: ffff88081c2d0dc0 ti: ffff880149ae8000 task.ti: ffff880149ae8000
Apr  8 11:41:39 mon01 kernel: [262672.428330] RIP: 0010:[<ffffffff811cd04a>]  [<ffffffff811cd04a>] kfree+0x5a/0x130
Apr  8 11:41:39 mon01 kernel: [262672.535880] RSP: 0018:ffff880149aeba58  EFLAGS: 00010286
Apr  8 11:41:39 mon01 kernel: [262672.589486] RAX: 000001e000000000 RBX: 0000000000000012 RCX: ffff8807e7461018
Apr  8 11:41:39 mon01 kernel: [262672.695980] RDX: 000077ff80000000 RSI: ffff88081af2be04 RDI: 0000000000000012
Apr  8 11:41:39 mon01 kernel: [262672.803668] RBP: ffff880149aeba78 R08: 0000000000000000 R09: 0000000000000000
Apr  8 11:41:39 mon01 kernel: [262672.912299] R10: ffffebe000000000 R11: ffff880819a60e78 R12: ffff8800aec8df40
Apr  8 11:41:39 mon01 kernel: [262673.021769] R13: ffffffffc035f70f R14: ffff8807e5b138e0 R15: ffff880da9785840
Apr  8 11:41:39 mon01 kernel: [262673.131722] FS:  0000000000000000(0000) GS:ffff88081fac0000(0000) knlGS:0000000000000000
Apr  8 11:41:39 mon01 kernel: [262673.245377] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr  8 11:41:39 mon01 kernel: [262673.303281] CR2: ffffebe000000000 CR3: 0000000001c0d000 CR4: 00000000001406e0
Apr  8 11:41:39 mon01 kernel: [262673.417556] Stack:
Apr  8 11:41:39 mon01 kernel: [262673.472943]  ffff880149aeba88 ffff88081af2be04 ffff8800aec8df40 ffff88081af2be04
Apr  8 11:41:39 mon01 kernel: [262673.583767]  ffff880149aeba98 ffffffffc035f70f ffff880149aebac8 ffff8800aec8df00
Apr  8 11:41:39 mon01 kernel: [262673.694546]  ffff880149aebac8 ffffffffc035c89e ffff8807e5b138e0 ffff8805b047f800
Apr  8 11:41:39 mon01 kernel: [262673.805230] Call Trace:
Apr  8 11:41:39 mon01 kernel: [262673.859116]  [<ffffffffc035f70f>] ceph_x_destroy_authorizer+0x1f/0x50 [libceph]
Apr  8 11:41:39 mon01 kernel: [262673.968705]  [<ffffffffc035c89e>] ceph_auth_destroy_authorizer+0x3e/0x60 [libceph]
Apr  8 11:41:39 mon01 kernel: [262674.078852]  [<ffffffffc0352805>] put_osd+0x45/0x80 [libceph]
Apr  8 11:41:39 mon01 kernel: [262674.134249]  [<ffffffffc035290e>] remove_osd+0xae/0x140 [libceph]
Apr  8 11:41:39 mon01 kernel: [262674.189124]  [<ffffffffc0352aa3>] __reset_osd+0x103/0x150 [libceph]
Apr  8 11:41:39 mon01 kernel: [262674.243749]  [<ffffffffc0354703>] kick_requests+0x223/0x460 [libceph]
Apr  8 11:41:39 mon01 kernel: [262674.297485]  [<ffffffffc03559e2>] ceph_osdc_handle_map+0x282/0x5e0 [libceph]
Apr  8 11:41:39 mon01 kernel: [262674.350813]  [<ffffffffc035022e>] dispatch+0x4e/0x720 [libceph]
Apr  8 11:41:39 mon01 kernel: [262674.403312]  [<ffffffffc034bd91>] try_read+0x3d1/0x1090 [libceph]
Apr  8 11:41:39 mon01 kernel: [262674.454712]  [<ffffffff810ab7c2>] ? dequeue_entity+0x152/0x690
Apr  8 11:41:39 mon01 kernel: [262674.505096]  [<ffffffffc034cb1b>] con_work+0xcb/0x1300 [libceph]
Apr  8 11:41:39 mon01 kernel: [262674.555104]  [<ffffffff8108fb3e>] process_one_work+0x14e/0x3d0
Apr  8 11:41:39 mon01 kernel: [262674.604072]  [<ffffffff810901ea>] worker_thread+0x11a/0x470
Apr  8 11:41:39 mon01 kernel: [262674.652187]  [<ffffffff810900d0>] ? rescuer_thread+0x310/0x310
Apr  8 11:41:39 mon01 kernel: [262674.699022]  [<ffffffff810957a2>] kthread+0xd2/0xf0
Apr  8 11:41:39 mon01 kernel: [262674.744494]  [<ffffffff810956d0>] ? kthread_create_on_node+0x1c0/0x1c0
Apr  8 11:41:39 mon01 kernel: [262674.789543]  [<ffffffff817bd81f>] ret_from_fork+0x3f/0x70
Apr  8 11:41:39 mon01 kernel: [262674.834094]  [<ffffffff810956d0>] ? kthread_create_on_node+0x1c0/0x1c0
Apr  8 11:41:39 mon01 kernel: [262674.878868] Code: 00 00 00 80 ff 77 00 00 49 ba 00 00 00 00 00 ea ff ff 48 01 d8 48 0f 42 15 d4 6f a4 00 48 01 d0 48 c1 e8 0c 48 c1 e0 06 49 01 c2 <49> 8b 02 f6 c4 80 0f 85 b5 00 00 00 49 8b 02 a8 80 0f 84 89 00 
Apr  8 11:41:39 mon01 kernel: [262675.015731] RIP  [<ffffffff811cd04a>] kfree+0x5a/0x130
Apr  8 11:41:39 mon01 kernel: [262675.060095]  RSP <ffff880149aeba58>
Apr  8 11:41:39 mon01 kernel: [262675.103075] CR2: ffffebe000000000
Apr  8 11:41:39 mon01 kernel: [262675.208862] ---[ end trace 4bb1e8c377c75d32 ]---




Very appreciated to get your reply!



