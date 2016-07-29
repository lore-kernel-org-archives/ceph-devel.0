From: David Disseldorp <ddiss@suse.de>
Subject: Re: Compare And Write against unwritten ranges
Date: Fri, 29 Jul 2016 13:09:52 +0200
Message-ID: <20160729130952.146214fd@echidna.suse.de>
References: <20160726141409.14135a00@echidna.suse.de>
 <5797ABEF.1040101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34403 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbcG2LJz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Jul 2016 07:09:55 -0400
In-Reply-To: <5797ABEF.1040101@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On Tue, 26 Jul 2016 13:29:03 -0500, Mike Christie wrote:

> Did you already try the multi op zero/truncate approach? Did you have to
> make changes to the OSD code too?

I'm a little stumped by the OSD handling of these requests once truncate
is added to the mix...
As mentioned, with set-alloc-hint+cmpext(512~512)+write(512~512), the
cmpext/sync_read obtains an empty read buffer against the unwritten
range.
With set-alloc-hint+truncate(4194304)+cmpext(512~512)+write(512~512),
the cmpext/sync_read gets ENOENT from the filestore. The truncate
immediately prior doesn't appear to hit the filestore - vstart logs
below.

Cheers, David

7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean] do_op 0:841a7acf:::rbd_data.100e74b0dc51.0000000000000000:head [set-alloc-hint object_size 4194304 write_size 4194304,truncate 4194304,cmpext 512~512,write 512~512] ov 0'0 av 11'1 snapc 0=[] snapset 0=[]:[]
7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean]  taking ondisk_read_lock
7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean] do_osd_op 0:841a7acf:::rbd_data.100e74b0dc51.0000000000000000:head [set-alloc-hint object_size 4194304 write_size 4194304,truncate 4194304,cmpext 512~512,write 512~512]
7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean] do_osd_op  set-alloc-hint object_size 4194304 write_size 4194304
7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean] do_osd_op  truncate 4194304
7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean] do_osd_op  cmpext 512~512
7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean] do_osd_op 0:841a7acf:::rbd_data.100e74b0dc51.0000000000000000:head [sync_read 512~512]
7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean] do_osd_op  sync_read 512~512
7fd9bbfff700 15 filestore(/home/ddiss/isms/ceph/src/dev/osd2) read 0.1_head/#0:841a7acf:::rbd_data.100e74b0dc51.0000000000000000:head# 512~512
7fd9bbfff700 10 filestore(/home/ddiss/isms/ceph/src/dev/osd2) error opening file /home/ddiss/isms/ceph/src/dev/osd2/current/0.1_head/rbd\udata.100e74b0dc51.0000000000000000__head_F35E5821__0 with flags=2: (2) No such file or directory
7fd9bbfff700 10 filestore(/home/ddiss/isms/ceph/src/dev/osd2) FileStore::read(0.1_head/#0:841a7acf:::rbd_data.100e74b0dc51.0000000000000000:head#) open error: (2) No such file or directory
7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean]  read got -2 / 0 bytes from obj 0:841a7acf:::rbd_data.100e74b0dc51.0000000000000000:head
7fd9bbfff700 -1 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean] do_extent_cmp do_osd_ops failed -2
7fd9bbfff700 10 osd.2 pg_epoch: 11 pg[0.1( empty local-les=9 n=0 ec=1 les/c/f 9/9/0 8/8/8) [2,0,1] r=0 lpr=8 crt=0'0 mlcod 0'0 active+clean]  dropping ondisk_read_lock
7fd9bbfff700  1 -- 192.168.155.1:6808/7807 --> 192.168.155.101:0/3185149525 -- osd_op_reply(78 rbd_data.100e74b0dc51.0000000000000000 [set-alloc-hint object_size 4194304 write_size 4194304,truncate 4194304,cmpext 512~512,write 512~512] v0'0 uv0 ondisk = -2 ((2) No such file or directory)) v7 -- ?+0 0x7fd9d002bde0 con 0x7fda08006230

