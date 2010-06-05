From: Thomas Mueller <thomas@chaschperli.ch>
Subject: ceph_dentry_info: Objects remaining on kmem_cache_close()
 (ceph-client-standalone/master-backport on kernel 2.6.32)
Date: Sat, 5 Jun 2010 09:05:21 +0000 (UTC)
Message-ID: <hud40h$j7u$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:37127 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932576Ab0FEJFg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 5 Jun 2010 05:05:36 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OKpJr-0003KU-MR
	for ceph-devel@vger.kernel.org; Sat, 05 Jun 2010 11:05:31 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 11:05:31 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 11:05:31 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

i get the kernel messages below if I do a "modprobe -r ceph".

system: Debian Squeeze
kernel: 2.6.32
kclient: ceph-client-standalone branch master-backport

- Thomas



kernel: [  398.964535] ceph: loaded (mon/mds/osd proto 15/32/24, osdmap 
5/5 5/5)
kernel: [  400.701544] ceph: client4101 fsid 
f233d1fe-24b6-6458-0764-364f3b1e250d
kernel: [  400.701794] ceph: mon1 127.0.0.1:6789 session established
kernel: [ 1427.320842] 
=============================================================================
kernel: [ 1427.320852] BUG ceph_dentry_info: Objects remaining on 
kmem_cache_close()
kernel: [ 1427.320857] 
-----------------------------------------------------------------------------
kernel: [ 1427.320861] 
kernel: [ 1427.320868] INFO: Slab 0xffffea0003b766a8 objects=51 used=4 
fp=0xffff88010fd43fa0 flags=0x200000000000080
kernel: [ 1427.320878] Pid: 25898, comm: modprobe Not tainted 2.6.32-3-
amd64 #1
kernel: [ 1427.320883] Call Trace:
kernel: [ 1427.320899]  [<ffffffff810e3397>] ? slab_err+0xba/0xdf
kernel: [ 1427.320910]  [<ffffffff81064977>] ? bit_waitqueue+0x10/0xa0
kernel: [ 1427.320922]  [<ffffffff81074a3b>] ? generic_exec_single
+0x64/0x7f
kernel: [ 1427.320931]  [<ffffffff810e3db0>] ? flush_cpu_slab+0x0/0x39
kernel: [ 1427.320939]  [<ffffffff810e43dd>] ? list_slab_objects
+0xa3/0x16a
kernel: [ 1427.320947]  [<ffffffff810e3db0>] ? flush_cpu_slab+0x0/0x39
kernel: [ 1427.320955]  [<ffffffff810e3087>] ? add_partial+0x11/0x58
kernel: [ 1427.320963]  [<ffffffff810e3d97>] ? deactivate_slab+0xb4/0xcd
kernel: [ 1427.320973]  [<ffffffff810e78f3>] ? kmem_cache_destroy
+0x105/0x1f6
kernel: [ 1427.320993]  [<ffffffffa04752d1>] ? destroy_caches+0x28/0x36 
[ceph]
kernel: [ 1427.321006]  [<ffffffffa0493cd2>] ? exit_ceph+0x1a/0x26 [ceph]
kernel: [ 1427.321015]  [<ffffffff81078657>] ? sys_delete_module
+0x1d2/0x258
kernel: [ 1427.321025]  [<ffffffff8103289b>] ? do_page_fault+0x266/0x282
kernel: [ 1427.321036]  [<ffffffff8118b1f1>] ? __up_read+0x13/0x8e
kernel: [ 1427.321047]  [<ffffffff81010b42>] ? system_call_fastpath
+0x16/0x1b
kernel: [ 1427.321060] INFO: Object 0xffff88010fd437d0 @offset=2000
kernel: [ 1427.321066] INFO: Object 0xffff88010fd43820 @offset=2080
kernel: [ 1427.321071] INFO: Object 0xffff88010fd43870 @offset=2160
kernel: [ 1427.321076] INFO: Object 0xffff88010fd438c0 @offset=2240
kernel: [ 1427.321083] 
=============================================================================
kernel: [ 1427.321089] BUG ceph_dentry_info: Objects remaining on 
kmem_cache_close()
kernel: [ 1427.321094] 
-----------------------------------------------------------------------------
kernel: [ 1427.321097] 
kernel: [ 1427.321104] INFO: Slab 0xffffea00019228b8 objects=51 used=1 
fp=0xffff880072e717d0 flags=0x100000000000080
kernel: [ 1427.321112] Pid: 25898, comm: modprobe Not tainted 2.6.32-3-
amd64 #1
kernel: [ 1427.321116] Call Trace:
kernel: [ 1427.321123]  [<ffffffff810e3397>] ? slab_err+0xba/0xdf
kernel: [ 1427.321134]  [<ffffffff812ed452>] ? printk+0x4e/0x5c
kernel: [ 1427.321143]  [<ffffffff81074a3b>] ? generic_exec_single
+0x64/0x7f
kernel: [ 1427.321151]  [<ffffffff810e3db0>] ? flush_cpu_slab+0x0/0x39
kernel: [ 1427.321160]  [<ffffffff810e43dd>] ? list_slab_objects
+0xa3/0x16a
kernel: [ 1427.321168]  [<ffffffff810e3db0>] ? flush_cpu_slab+0x0/0x39
kernel: [ 1427.321176]  [<ffffffff810e3087>] ? add_partial+0x11/0x58
kernel: [ 1427.321184]  [<ffffffff810e3d97>] ? deactivate_slab+0xb4/0xcd
kernel: [ 1427.321193]  [<ffffffff810e78f3>] ? kmem_cache_destroy
+0x105/0x1f6
kernel: [ 1427.321207]  [<ffffffffa04752d1>] ? destroy_caches+0x28/0x36 
[ceph]
kernel: [ 1427.321220]  [<ffffffffa0493cd2>] ? exit_ceph+0x1a/0x26 [ceph]
kernel: [ 1427.321228]  [<ffffffff81078657>] ? sys_delete_module
+0x1d2/0x258
kernel: [ 1427.321237]  [<ffffffff8103289b>] ? do_page_fault+0x266/0x282
kernel: [ 1427.321246]  [<ffffffff8118b1f1>] ? __up_read+0x13/0x8e
kernel: [ 1427.321255]  [<ffffffff81010b42>] ? system_call_fastpath
+0x16/0x1b
kernel: [ 1427.321269] INFO: Object 0xffff880072e71460 @offset=1120
kernel: [ 1427.321276] SLUB ceph_dentry_info: kmem_cache_destroy called 
for cache that still has objects.
kernel: [ 1427.321284] Pid: 25898, comm: modprobe Not tainted 2.6.32-3-
amd64 #1
kernel: [ 1427.321288] Call Trace:
kernel: [ 1427.321297]  [<ffffffff810e798a>] ? kmem_cache_destroy
+0x19c/0x1f6
kernel: [ 1427.321311]  [<ffffffffa04752d1>] ? destroy_caches+0x28/0x36 
[ceph]
kernel: [ 1427.321324]  [<ffffffffa0493cd2>] ? exit_ceph+0x1a/0x26 [ceph]
kernel: [ 1427.321332]  [<ffffffff81078657>] ? sys_delete_module
+0x1d2/0x258
kernel: [ 1427.321340]  [<ffffffff8103289b>] ? do_page_fault+0x266/0x282
kernel: [ 1427.321349]  [<ffffffff8118b1f1>] ? __up_read+0x13/0x8e
kernel: [ 1427.321358]  [<ffffffff81010b42>] ? system_call_fastpath
+0x16/0x1b

