From: Olivier Bonvalet <ceph.list-PaEMFeTk6C1QFI55V6+gNQ@public.gmane.org>
Subject: general protection fault: 0000 [#1] SMP
Date: Wed, 11 Oct 2017 16:40:40 +0200
Message-ID: <1507732840.2812.10.camel@daevel.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

I had a "general protection fault: 0000" with Ceph RBD kernel client.
Not sure how to read the call, is it Ceph related ?


Oct 11 16:15:11 lorunde kernel: [311418.891238] general protection fault: 0000 [#1] SMP
Oct 11 16:15:11 lorunde kernel: [311418.891855] Modules linked in: cpuid binfmt_misc nls_iso8859_1 nls_cp437 vfat fat tcp_diag inet_diag xt_physdev br_netfilter iptable_filter xen_netback loop xen_blkback cbc rbd libceph xen_gntdev xen_evtchn xenfs xen_privcmd ipmi_ssif intel_rapl iosf_mbi sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul ghash_clmulni_intel iTCO_wdt pcbc iTCO_vendor_support mxm_wmi aesni_intel aes_x86_64 crypto_simd glue_helper cryptd mgag200 i2c_algo_bit drm_kms_helper intel_rapl_perf ttm drm syscopyarea sysfillrect efi_pstore sysimgblt fb_sys_fops lpc_ich efivars mfd_core evdev ioatdma shpchp acpi_power_meter ipmi_si wmi button ipmi_devintf ipmi_msghandler bridge efivarfs ip_tables x_tables autofs4 dm_mod dax raid10 raid456 async_raid6_recov async_
 memcpy async_pq async_xor xor async_tx raid6_pq
Oct 11 16:15:11 lorunde kernel: [311418.895403]  libcrc32c raid1 raid0 multipath linear md_mod hid_generic usbhid i2c_i801 crc32c_intel i2c_core xhci_pci ahci ixgbe xhci_hcd libahci ehci_pci ehci_hcd libata usbcore dca ptp usb_common pps_core mdio
Oct 11 16:15:11 lorunde kernel: [311418.896551] CPU: 1 PID: 4916 Comm: kworker/1:0 Not tainted 4.13-dae-dom0 #2
Oct 11 16:15:11 lorunde kernel: [311418.897134] Hardware name: Intel Corporation S2600CWR/S2600CWR, BIOS SE5C610.86B.01.01.0019.101220160604 10/12/2016
Oct 11 16:15:11 lorunde kernel: [311418.897745] Workqueue: ceph-msgr ceph_con_workfn [libceph]
Oct 11 16:15:11 lorunde kernel: [311418.898355] task: ffff8801ce434280 task.stack: ffffc900151bc000
Oct 11 16:15:11 lorunde kernel: [311418.899007] RIP: e030:memcpy_erms+0x6/0x10
Oct 11 16:15:11 lorunde kernel: [311418.899616] RSP: e02b:ffffc900151bfac0 EFLAGS: 00010202
Oct 11 16:15:11 lorunde kernel: [311418.900228] RAX: ffff8801b63df000 RBX: ffff88021b41be00 RCX: 0000000004df0000
Oct 11 16:15:11 lorunde kernel: [311418.900848] RDX: 0000000004df0000 RSI: 4450736e24806564 RDI: ffff8801b63df000
Oct 11 16:15:11 lorunde kernel: [311418.901479] RBP: ffffea0005fdd8c8 R08: ffff88028545d618 R09: 0000000000000010
Oct 11 16:15:11 lorunde kernel: [311418.902104] R10: 0000000000000000 R11: ffff880215815000 R12: 0000000000000000
Oct 11 16:15:11 lorunde kernel: [311418.902723] R13: ffff8802158156c0 R14: 0000000000000000 R15: ffff8801ce434280
Oct 11 16:15:11 lorunde kernel: [311418.903359] FS:  0000000000000000(0000) GS:ffff880285440000(0000) knlGS:ffff880285440000
Oct 11 16:15:11 lorunde kernel: [311418.903994] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 11 16:15:11 lorunde kernel: [311418.904627] CR2: 000055a8461cfc20 CR3: 0000000001809000 CR4: 0000000000042660
Oct 11 16:15:11 lorunde kernel: [311418.905271] Call Trace:
Oct 11 16:15:11 lorunde kernel: [311418.905909]  ? skb_copy_ubufs+0xef/0x290
Oct 11 16:15:11 lorunde kernel: [311418.906548]  ? skb_clone+0x82/0x90
Oct 11 16:15:11 lorunde kernel: [311418.907225]  ? tcp_transmit_skb+0x74/0x930
Oct 11 16:15:11 lorunde kernel: [311418.907858]  ? tcp_write_xmit+0x1bd/0xfb0
Oct 11 16:15:11 lorunde kernel: [311418.908490]  ? __sk_mem_raise_allocated+0x4e/0x220
Oct 11 16:15:11 lorunde kernel: [311418.909122]  ? __tcp_push_pending_frames+0x28/0x90
Oct 11 16:15:11 lorunde kernel: [311418.909755]  ? do_tcp_sendpages+0x4fc/0x590
Oct 11 16:15:11 lorunde kernel: [311418.910386]  ? tcp_sendpage+0x7c/0xa0
Oct 11 16:15:11 lorunde kernel: [311418.911026]  ? inet_sendpage+0x37/0xe0
Oct 11 16:15:11 lorunde kernel: [311418.911655]  ? kernel_sendpage+0x12/0x20
Oct 11 16:15:11 lorunde kernel: [311418.912297]  ? ceph_tcp_sendpage+0x5c/0xc0 [libceph]
Oct 11 16:15:11 lorunde kernel: [311418.912926]  ? ceph_tcp_recvmsg+0x53/0x70 [libceph]
Oct 11 16:15:11 lorunde kernel: [311418.913553]  ? ceph_con_workfn+0xd08/0x22a0 [libceph]
Oct 11 16:15:11 lorunde kernel: [311418.914179]  ? ceph_osdc_start_request+0x23/0x30 [libceph]
Oct 11 16:15:11 lorunde kernel: [311418.914807]  ? rbd_img_obj_request_submit+0x1ac/0x3c0 [rbd]
Oct 11 16:15:11 lorunde kernel: [311418.915458]  ? process_one_work+0x1ad/0x340
Oct 11 16:15:11 lorunde kernel: [311418.916083]  ? worker_thread+0x45/0x3f0
Oct 11 16:15:11 lorunde kernel: [311418.916706]  ? kthread+0xf2/0x130
Oct 11 16:15:11 lorunde kernel: [311418.917327]  ? process_one_work+0x340/0x340
Oct 11 16:15:11 lorunde kernel: [311418.917946]  ? kthread_create_on_node+0x40/0x40
Oct 11 16:15:11 lorunde kernel: [311418.918565]  ? do_group_exit+0x35/0xa0
Oct 11 16:15:11 lorunde kernel: [311418.919215]  ? ret_from_fork+0x25/0x30
Oct 11 16:15:11 lorunde kernel: [311418.919826] Code: 43 4e 5b eb ec eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 
Oct 11 16:15:11 lorunde kernel: [311418.921094] RIP: memcpy_erms+0x6/0x10 RSP: ffffc900151bfac0
Oct 11 16:15:11 lorunde kernel: [311418.921970] ---[ end trace 904278a63cb49fca ]---
