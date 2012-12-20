From: Matthew Anderson <matthewa@base3.com.au>
Subject: OSD's slow down to a crawl
Date: Thu, 20 Dec 2012 15:16:01 +0000
Message-ID: <38A500831D3DE24B90BD200D6C8701351BB15324@Exchange2010-2.corit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.base3.com.au ([27.106.198.3]:8896 "EHLO mail.base3.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913Ab2LTPQH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 10:16:07 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

I've run into an issue where OSD's slow right down to the point that they no longer appear to be processing write IO and everything grinds to a halt. Once they've stopped performing IO they can be brought back to life by restarting them where they continue on for a while before they slow down again and eventually everything stops again. I'm at a total loss to explain the issue because everything appears to be working correctly yet something is clearly very wrong. Running 'ceph -w' reports everything as clean+active and there are never any slow requests logged.

The problem appears to be more pronounced on the newer 3.7 kernel but happened on previous versions in the same fashion. Weird things like OSD's never completing recovery until they are restarted was also happening occasionally. The cluster would be stuck on a certain percentage degraded and restarting the OSD 3-4 times would eventually see it heal itself with the degraded percentage dropping a little each time. I'm testing with both the kernel CephFS client and QEMU 1.3.0 accessing an RBD, both slow down to a stop in the same manner. 

Kernel 3.7.0 mainline (also occurs on 3.7.1 and 3.6.8)
Ceph version 0.55.1-300-g08c6424 (08c64249eb8cd7922de5c398a9426538918db77c) 	(also occurs on 0.55 and 0.55.1)
Total of 3 hosts. Two of them with 4 OSD's on an SSD each. The other with 24x 2TB SATA drives. Each host is running a monitor. I have setup two pools in the CRUSHMAP, one for SATA and one for SSD. Both pools have the same problem.

OSD config:
[osd.24]
        host = KVM04
        osd data = /srv/ceph/osd/$name
        btrfs devs = /dev/sda2
        btrfs options = rw,noatime,ssd
        osd journal = /dev/sda1

The log below is when the OSD has stopped processing IO and was then shutdown cleanly. The QEMU guest was partially responsive but the benchmark had frozen waiting for IO to complete. 

If I can do anymore debugging to help diagnose the problem please let me know.

Thanks
-Matt
-------------------------------------

2012-12-20 22:18:06.809863 7fb9e4ff9700 20 journal write_thread_entry aio throttle: aio num 0 bytes 0 ... exp 0 min_new 1 ... pending 5748
2012-12-20 22:18:06.809871 7fb9e4ff9700 10 journal room 960479231 max_size 960495616 pos 543215616 header.start 543203328 top 4096
2012-12-20 22:18:06.809877 7fb9e4ff9700 10 journal check_for_full at 543215616 : 8192 < 960479231
2012-12-20 22:18:06.809880 7fb9e4ff9700 15 journal prepare_single_write 1 will write 543215616 : seq 2087065 len 5748 -> 8192 (head 40 pre_pad 0 ebl 5748 post_pad 2364 tail 40) (ebl alignment -1)
2012-12-20 22:18:06.809891 7fb9d57fa700 10 journal op_apply_start 2087065 open_ops 0 -> 1
2012-12-20 22:18:06.809897 7fb9d57fa700  5 filestore(/srv/ceph/osd/osd.24) _do_op 0x7fb9b4376570 seq 2087065 osr(6.1fe3 0x21a4f50)/0x21a4f50 start
2012-12-20 22:18:06.809901 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) _do_transaction on 0x7fb9b4f5db40
2012-12-20 22:18:06.809915 7fb9d57fa700 15 filestore(/srv/ceph/osd/osd.24) write meta/a4c1c2a3/pglog_6.1fe3/0//-1 147735~147
2012-12-20 22:18:06.809947 7fb9e4ff9700 20 journal prepare_multi_write queue_pos now 543223808
2012-12-20 22:18:06.809953 7fb9e4ff9700 15 journal do_aio_write writing 543215616~8192
2012-12-20 22:18:06.809975 7fb9e4ff9700 20 journal write_aio_bl 543215616~8192 seq 2087065
2012-12-20 22:18:06.809981 7fb9e4ff9700 20 journal write_aio_bl .. 543215616~8192 in 1
2012-12-20 22:18:06.810051 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) write meta/a4c1c2a3/pglog_6.1fe3/0//-1 147735~147 = 147
2012-12-20 22:18:06.810065 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) collection_setattr /srv/ceph/osd/osd.24/current/6.1fe3_head 'ondisklog' len 34
2012-12-20 22:18:06.810068 7fb9e4ff9700  5 journal put_throttle finished 1 ops and 5748 bytes, now 0 ops and 0 bytes
2012-12-20 22:18:06.810077 7fb9e4ff9700 20 journal write_thread_entry going to sleep
2012-12-20 22:18:06.810103 7fb9d7fff700 20 journal write_finish_thread_entry waiting for aio(s)
2012-12-20 22:18:06.810149 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) collection_setattr /srv/ceph/osd/osd.24/current/6.1fe3_head 'ondisklog' len 34 = 34
2012-12-20 22:18:06.810159 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) collection_setattr /srv/ceph/osd/osd.24/current/6.1fe3_head 'info' len 5
2012-12-20 22:18:06.810191 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) collection_setattr /srv/ceph/osd/osd.24/current/6.1fe3_head 'info' len 5 = 5
2012-12-20 22:18:06.810198 7fb9d57fa700 15 filestore(/srv/ceph/osd/osd.24) truncate meta/8dfefeef/pginfo_6.1fe3/0//-1 size 0
2012-12-20 22:18:06.810307 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) truncate meta/8dfefeef/pginfo_6.1fe3/0//-1 size 0 = 0
2012-12-20 22:18:06.810317 7fb9d57fa700 15 filestore(/srv/ceph/osd/osd.24) write meta/8dfefeef/pginfo_6.1fe3/0//-1 0~504
2012-12-20 22:18:06.810386 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) write meta/8dfefeef/pginfo_6.1fe3/0//-1 0~504 = 504
2012-12-20 22:18:06.810394 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) _do_transaction on 0x7fb9b4f5dab8
2012-12-20 22:18:06.810399 7fb9d57fa700 15 filestore(/srv/ceph/osd/osd.24) write 6.1fe3_head/42463fe3/rb.0.122c.6b8b4567.000000000357/head//6 3522560~4096
2012-12-20 22:18:06.810451 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) write 6.1fe3_head/42463fe3/rb.0.122c.6b8b4567.000000000357/head//6 3522560~4096 = 4096
2012-12-20 22:18:06.810497 7fb9d57fa700 15 filestore(/srv/ceph/osd/osd.24) setattrs 6.1fe3_head/42463fe3/rb.0.122c.6b8b4567.000000000357/head//6
2012-12-20 22:18:06.810576 7fb9d7fff700 10 journal write_finish_thread_entry aio 543215616~8192 done
2012-12-20 22:18:06.810588 7fb9d7fff700 20 journal check_aio_completion
2012-12-20 22:18:06.810590 7fb9d7fff700 20 journal check_aio_completion completed seq 2087065 543215616~8192
2012-12-20 22:18:06.810594 7fb9d7fff700 20 journal check_aio_completion queueing finishers through seq 2087065
2012-12-20 22:18:06.810596 7fb9d7fff700 10 journal queue_completions_thru seq 2087065 queueing seq 2087065 0x7fb9b4f70ac0 lat 0.000761
2012-12-20 22:18:06.810631 7fb9d7fff700 20 journal write_finish_thread_entry sleeping
2012-12-20 22:18:06.810695 7fb9d5ffb700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 luod=3473'23688 lcod 3473'23688 mlcod 3473'23687 active+clean] op_commit repgather(0x7fb9b47d1050 applying 3473'23689 rep_tid=72 wfack=24,31 wfdisk=24,31 op=osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4)
2012-12-20 22:18:06.810720 7fb9d5ffb700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] eval_repop repgather(0x7fb9b47d1050 applying 3473'23689 rep_tid=72 wfack=31 wfdisk=31 op=osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4) wants=ad
2012-12-20 22:18:06.810992 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) setattrs 6.1fe3_head/42463fe3/rb.0.122c.6b8b4567.000000000357/head//6 = 230
2012-12-20 22:18:06.811053 7fb9d57fa700 15 filestore(/srv/ceph/osd/osd.24) setattrs 6.1fe3_head/42463fe3/rb.0.122c.6b8b4567.000000000357/head//6
2012-12-20 22:18:06.811083 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) setattrs 6.1fe3_head/42463fe3/rb.0.122c.6b8b4567.000000000357/head//6 = 31
2012-12-20 22:18:06.811093 7fb9d57fa700 10 journal op_apply_finish 2087065 open_ops 1 -> 0, max_applied_seq 2087064 -> 2087065
2012-12-20 22:18:06.811096 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) _do_op 0x7fb9b4376570 seq 2087065 r = 0, finisher 0x7fb9b5022bb0 0x7fb9b483ce10
2012-12-20 22:18:06.811100 7fb9d57fa700 10 filestore(/srv/ceph/osd/osd.24) _finish_op 0x7fb9b4376570 seq 2087065 osr(6.1fe3 0x21a4f50)/0x21a4f50
2012-12-20 22:18:06.811136 7fb9c37fe700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] op_applied repgather(0x7fb9b47d1050 applying 3473'23689 rep_tid=72 wfack=31 wfdisk=31 op=osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4)
2012-12-20 22:18:06.811205 7fb9c37fe700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] op_applied mode was rmw(wr=1)
2012-12-20 22:18:06.811218 7fb9c37fe700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] op_applied mode now idle(wr=0 WAKE) (finish_write)
2012-12-20 22:18:06.811229 7fb9c37fe700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] put_object_context 0x7fb9b5248020 42463fe3/rb.0.122c.6b8b4567.000000000357/head//6 1 -> 0
2012-12-20 22:18:06.811241 7fb9c37fe700 15 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean]  requeue_ops 
2012-12-20 22:18:06.811251 7fb9c37fe700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] put_snapset_context rb.0.122c.6b8b4567.000000000357 1 -> 0
2012-12-20 22:18:06.811267 7fb9c37fe700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] eval_repop repgather(0x7fb9b47d1050 applied 3473'23689 rep_tid=72 wfack=31 wfdisk=31 op=osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4) wants=ad
2012-12-20 22:18:06.813738 7fb9c0ff9700 20 osd.24 3473 _dispatch 0x7fb9600008f0 osd_sub_op_reply(client.7636.0:100075 6.1fe3 42463fe3/rb.0.122c.6b8b4567.000000000357/head//6 [] ondisk, result = 0) v1
2012-12-20 22:18:06.813850 7fb9c0ff9700 15 osd.24 3473 require_same_or_newer_map 3473 (i am 3473) 0x7fb9600008f0
2012-12-20 22:18:06.813856 7fb9c0ff9700 20 osd.24 3473 _share_map_incoming osd.31 172.16.0.12:6820/2871 3473
2012-12-20 22:18:06.813865 7fb9c0ff9700 15 osd.24 3473 enqueue_op 0x7fb968055650 osd_sub_op_reply(client.7636.0:100075 6.1fe3 42463fe3/rb.0.122c.6b8b4567.000000000357/head//6 [] ondisk,
result= 0) v1
2012-12-20 22:18:06.813934 7fb9bd7f2700 10 osd.24 3473 dequeue_op 0x7fb968055650 osd_sub_op_reply(client.7636.0:100075 6.1fe3 42463fe3/rb.0.122c.6b8b4567.000000000357/head//6 [] ondisk, result = 0) v1 pg pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean]
2012-12-20 22:18:06.814005 7fb9bd7f2700  7 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] repop_ack rep_tid 72 op osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4 result 0 ack_type 4 from osd.31
2012-12-20 22:18:06.814037 7fb9bd7f2700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] eval_repop repgather(0x7fb9b47d1050 applied 3473'23689 rep_tid=72 wfack= wfdisk= op=osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4) wants=ad
2012-12-20 22:18:06.814057 7fb9bd7f2700 15 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] log_op_stats osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4 inb 4239 outb 0 rlat 0.000000 lat 0.005594
2012-12-20 22:18:06.814075 7fb9bd7f2700 15 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean] update_stats 3465'46631
2012-12-20 22:18:06.814088 7fb9bd7f2700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23687 active+clean]  sending commit on repgather(0x7fb9b47d1050 applied 3473'23689 rep_tid=72 wfack= wfdisk= op=osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4) 0x7fb9b4605310
2012-12-20 22:18:06.814122 7fb9bd7f2700 10 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23688 active+clean]  removing repgather(0x7fb9b47d1050 applied 3473'23689 rep_tid=72 wfack= wfdisk= op=osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4)
2012-12-20 22:18:06.814147 7fb9bd7f2700 20 osd.24 pg_epoch: 3473 pg[6.1fe3( v 3473'23689 (3247'22688,3473'23689] local-les=3472 n=12 ec=656 les/c 3472/3473 3465/3465/3465) [24,31] r=0 lpr=3465 mlcod 3473'23688 active+clean]    q front is repgather(0x7fb9b47d1050 applied 3473'23689 rep_tid=72 wfack= wfdisk= op=osd_op(client.7636.0:100075 rb.0.122c.6b8b4567.000000000357 [write 3522560~4096] 6.42463fe3) v4)
2012-12-20 22:18:06.814204 7fb9bd7f2700 10 osd.24 3473 dequeue_op 0x7fb968055650 finish
2012-12-20 22:18:07.030914 7fb9be7f4700 10 monclient: tick
2012-12-20 22:18:07.030929 7fb9be7f4700 10 monclient: _check_auth_rotating renewing rotating keys (they expired before 2012-12-20 22:17:37.030927)
2012-12-20 22:18:07.030952 7fb9be7f4700 10 monclient: renew subs? (now: 2012-12-20 22:18:07.030952; renew after: 2012-12-20 22:18:33.322998) -- no
2012-12-20 22:18:07.172960 7fb9bafed700 20 osd.24 3473 update_osd_stat osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:07.172979 7fb9bafed700  5 osd.24 3473 heartbeat: osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:07.173647 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9b400d440 already has epoch 3473
2012-12-20 22:18:07.173675 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a002f010 already has epoch 3473
2012-12-20 22:18:07.173785 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a00334d0 already has epoch 3473
2012-12-20 22:18:07.173875 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a0033fc0 already has epoch 3473
2012-12-20 22:18:07.479259 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:07.479311 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.36 >= max 0.5 = no, load too high
2012-12-20 22:18:07.479326 7fb9e6ffd700  7 osd.24 3473 do_mon_report
2012-12-20 22:18:07.479329 7fb9e6ffd700 10 osd.24 3473 send_alive up_thru currently 3465 want 3465
2012-12-20 22:18:07.479331 7fb9e6ffd700 20 osd.24 3473 send_pg_stats
2012-12-20 22:18:07.479334 7fb9e6ffd700 10 osd.24 3473 send_pg_stats - 2 pgs updated
2012-12-20 22:18:07.479343 7fb9e6ffd700 10 monclient: _send_mon_message to mon.KVM03 at 172.16.0.12:6789/0
2012-12-20 22:18:07.774794 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9a002f010 already has epoch 3473
2012-12-20 22:18:07.809251 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24) sync_entry woke after 5.000117
2012-12-20 22:18:07.809274 7fb9e57fa700 10 journal commit_start max_applied_seq 2087065, open_ops 0
2012-12-20 22:18:07.809278 7fb9e57fa700 10 journal commit_start blocked, all open_ops have completed
2012-12-20 22:18:07.809279 7fb9e57fa700 10 journal commit_start committing 2087065, still blocked
2012-12-20 22:18:07.809282 7fb9e57fa700 10 journal commit_start
2012-12-20 22:18:07.809291 7fb9e57fa700 15 filestore(/srv/ceph/osd/osd.24) sync_entry committing 2087065 sync_epoch 19
2012-12-20 22:18:07.809339 7fb9e57fa700 10 filestore(/srv/ceph/osd/osd.24) taking async snap 'snap_2087065'
2012-12-20 22:18:07.817045 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24) async snap create 'snap_2087065' transid 96549
2012-12-20 22:18:07.817060 7fb9e57fa700 10 journal commit_started committing 2087065, unblocking
2012-12-20 22:18:07.817069 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24)  waiting for transid 96549 to complete
2012-12-20 22:18:07.836752 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24)  done waiting for transid 96549 to complete
2012-12-20 22:18:07.836767 7fb9e57fa700 10 filestore(/srv/ceph/osd/osd.24) sync_entry commit took 0.027482, interval was 5.027633
2012-12-20 22:18:07.836775 7fb9e57fa700 10 journal commit_finish thru 2087065
2012-12-20 22:18:07.836778 7fb9e57fa700  5 journal committed_thru 2087065 (last_committed_seq 2087063)
2012-12-20 22:18:07.836781 7fb9e57fa700 10 journal header: block_size 4096 alignment 4096 max_size 960495616
2012-12-20 22:18:07.836783 7fb9e57fa700 10 journal header: start 543223808
2012-12-20 22:18:07.836784 7fb9e57fa700 10 journal  write_pos 543223808
2012-12-20 22:18:07.836788 7fb9e57fa700 10 journal committed_thru done
2012-12-20 22:18:07.836793 7fb9e57fa700 10 filestore(/srv/ceph/osd/osd.24) removing snap 'snap_2087061'
2012-12-20 22:18:07.836958 7fb9e57fa700 15 filestore(/srv/ceph/osd/osd.24) sync_entry committed to op_seq 2087065
2012-12-20 22:18:07.836972 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24) sync_entry waiting for max_interval 5.000000
2012-12-20 22:18:07.855890 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9a0033fc0 already has epoch 3473
2012-12-20 22:18:08.221094 7fb9c1ffb700 20 osd.24 3473 _dispatch 0x7fb990002de0 pg_stats_ack(2 pgs tid 18) v1
2012-12-20 22:18:08.221105 7fb9c1ffb700 10 osd.24 3473 handle_pg_stats_ack 
2012-12-20 22:18:08.479450 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:08.479499 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.36 >= max 0.5 = no, load too high
2012-12-20 22:18:09.479581 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:09.479633 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.36 >= max 0.5 = no, load too high
2012-12-20 22:18:10.479743 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:10.479808 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.36 >= max 0.5 = no, load too high
2012-12-20 22:18:11.273304 7fb9bafed700 20 osd.24 3473 update_osd_stat osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:11.273324 7fb9bafed700  5 osd.24 3473 heartbeat: osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:11.274018 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9b400d440 already has epoch 3473
2012-12-20 22:18:11.274081 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a002f010 already has epoch 3473
2012-12-20 22:18:11.274101 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a00334d0 already has epoch 3473
2012-12-20 22:18:11.274249 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a0033fc0 already has epoch 3473
2012-12-20 22:18:11.275112 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9a002f010 already has epoch 3473
2012-12-20 22:18:11.356141 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9a0033fc0 already has epoch 3473
2012-12-20 22:18:11.479927 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:11.479976 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.36 >= max 0.5 = no, load too high
2012-12-20 22:18:12.182095 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9a00334d0 already has epoch 3473
2012-12-20 22:18:12.373677 7fb9bafed700 20 osd.24 3473 update_osd_stat osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:12.373694 7fb9bafed700  5 osd.24 3473 heartbeat: osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:12.374496 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9b400d440 already has epoch 3473
2012-12-20 22:18:12.374523 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a002f010 already has epoch 3473
2012-12-20 22:18:12.374541 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a00334d0 already has epoch 3473
2012-12-20 22:18:12.374564 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a0033fc0 already has epoch 3473
2012-12-20 22:18:12.480076 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:12.480125 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.09 >= max 0.5 = no, load too high
2012-12-20 22:18:12.480140 7fb9e6ffd700  7 osd.24 3473 do_mon_report
2012-12-20 22:18:12.480142 7fb9e6ffd700 10 osd.24 3473 send_alive up_thru currently 3465 want 3465
2012-12-20 22:18:12.480146 7fb9e6ffd700 20 osd.24 3473 send_pg_stats
2012-12-20 22:18:12.701202 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9b400d440 already has epoch 3473
2012-12-20 22:18:12.837067 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24) sync_entry woke after 5.000094
2012-12-20 22:18:12.837089 7fb9e57fa700 10 journal commit_start max_applied_seq 2087065, open_ops 0
2012-12-20 22:18:12.837093 7fb9e57fa700 10 journal commit_start blocked, all open_ops have completed
2012-12-20 22:18:12.837095 7fb9e57fa700 10 journal commit_start nothing to do
2012-12-20 22:18:12.837100 7fb9e57fa700 10 journal commit_start
2012-12-20 22:18:12.837117 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24) sync_entry waiting for max_interval 5.000000
2012-12-20 22:18:13.480239 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:13.480289 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.09 >= max 0.5 = no, load too high
2012-12-20 22:18:14.073917 7fb9bafed700 20 osd.24 3473 update_osd_stat osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:14.073935 7fb9bafed700  5 osd.24 3473 heartbeat: osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:14.074840 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a0033fc0 already has epoch 3473
2012-12-20 22:18:14.074868 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a00334d0 already has epoch 3473
2012-12-20 22:18:14.074886 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9b400d440 already has epoch 3473
2012-12-20 22:18:14.074903 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a002f010 already has epoch 3473
2012-12-20 22:18:14.480386 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:14.480443 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.09 >= max 0.5 = no, load too high
2012-12-20 22:18:15.480571 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:15.480632 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.09 >= max 0.5 = no, load too high
2012-12-20 22:18:16.282625 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9a00334d0 already has epoch 3473
2012-12-20 22:18:16.480714 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:16.480763 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 6.09 >= max 0.5 = no, load too high
2012-12-20 22:18:16.801391 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9b400d440 already has epoch 3473
2012-12-20 22:18:17.031056 7fb9be7f4700 10 monclient: tick
2012-12-20 22:18:17.031082 7fb9be7f4700 10 monclient: _check_auth_rotating renewing rotating keys (they expired before 2012-12-20 22:17:47.031080)
2012-12-20 22:18:17.031124 7fb9be7f4700 10 monclient: renew subs? (now: 2012-12-20 22:18:17.031124; renew after: 2012-12-20 22:18:33.322998) -- no
2012-12-20 22:18:17.175266 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9a002f010 already has epoch 3473
2012-12-20 22:18:17.256256 7fb9bf7f6700 20 osd.24 3473 _share_map_outgoing 0x7fb9a0033fc0 already has epoch 3473
2012-12-20 22:18:17.480898 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:17.480952 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 5.84 >= max 0.5 = no, load too high
2012-12-20 22:18:17.480969 7fb9e6ffd700  7 osd.24 3473 do_mon_report
2012-12-20 22:18:17.480972 7fb9e6ffd700 10 osd.24 3473 send_alive up_thru currently 3465 want 3465
2012-12-20 22:18:17.480975 7fb9e6ffd700 20 osd.24 3473 send_pg_stats
2012-12-20 22:18:17.837232 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24) sync_entry woke after 5.000116
2012-12-20 22:18:17.837254 7fb9e57fa700 10 journal commit_start max_applied_seq 2087065, open_ops 0
2012-12-20 22:18:17.837258 7fb9e57fa700 10 journal commit_start blocked, all open_ops have completed
2012-12-20 22:18:17.837260 7fb9e57fa700 10 journal commit_start nothing to do
2012-12-20 22:18:17.837262 7fb9e57fa700 10 journal commit_start
2012-12-20 22:18:17.837271 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24) sync_entry waiting for max_interval 5.000000
2012-12-20 22:18:18.481073 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:18.481133 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 5.84 >= max 0.5 = no, load too high
2012-12-20 22:18:19.481247 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:19.481308 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 5.84 >= max 0.5 = no, load too high
2012-12-20 22:18:19.974219 7fb9bafed700 20 osd.24 3473 update_osd_stat osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:19.974238 7fb9bafed700  5 osd.24 3473 heartbeat: osd_stat(21111 MB used, 393 GB avail, 431 GB total, peers [28,29,30,31]/[])
2012-12-20 22:18:19.974899 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a002f010 already has epoch 3473
2012-12-20 22:18:19.975070 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a00334d0 already has epoch 3473
2012-12-20 22:18:19.975116 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9a0033fc0 already has epoch 3473
2012-12-20 22:18:19.975207 7fb9bfff7700 20 osd.24 3473 _share_map_outgoing 0x7fb9b400d440 already has epoch 3473
2012-12-20 22:18:20.481425 7fb9e6ffd700  5 osd.24 3473 tick
2012-12-20 22:18:20.481487 7fb9e6ffd700 20 osd.24 3473 scrub_should_schedule loadavg 5.84 >= max 0.5 = no, load too high
2012-12-20 22:18:21.016361 7fb9e77fe700 -1 osd.24 3473 *** Got signal Terminated ***
2012-12-20 22:18:21.016458 7fb9e77fe700 -1 osd.24 3473  pausing thread pools
2012-12-20 22:18:21.016462 7fb9e77fe700 -1 osd.24 3473  flushing io
2012-12-20 22:18:21.016464 7fb9e77fe700 10 filestore(/srv/ceph/osd/osd.24) sync_and_flush
2012-12-20 22:18:21.016467 7fb9e77fe700 10 filestore(/srv/ceph/osd/osd.24) _flush_op_queue draining op tp
2012-12-20 22:18:21.016471 7fb9e77fe700 10 filestore(/srv/ceph/osd/osd.24) _flush_op_queue waiting for apply finisher
2012-12-20 22:18:21.016481 7fb9e77fe700 10 filestore(/srv/ceph/osd/osd.24) start_sync
2012-12-20 22:18:21.016483 7fb9e77fe700 10 filestore(/srv/ceph/osd/osd.24) sync waiting
2012-12-20 22:18:21.016523 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24) sync_entry woke after 3.179252
2012-12-20 22:18:21.016540 7fb9e57fa700 10 journal commit_start max_applied_seq 2087065, open_ops 0
2012-12-20 22:18:21.016543 7fb9e57fa700 10 journal commit_start blocked, all open_ops have completed
2012-12-20 22:18:21.016545 7fb9e57fa700 10 journal commit_start nothing to do
2012-12-20 22:18:21.016548 7fb9e57fa700 10 journal commit_start
2012-12-20 22:18:21.016563 7fb9e57fa700 20 filestore(/srv/ceph/osd/osd.24) sync_entry waiting for max_interval 5.000000
2012-12-20 22:18:21.016563 7fb9e77fe700 10 filestore(/srv/ceph/osd/osd.24) sync done
2012-12-20 22:18:21.016570 7fb9e77fe700 10 filestore(/srv/ceph/osd/osd.24) sync_and_flush done
2012-12-20 22:18:21.016572 7fb9e77fe700 -1 osd.24 3473  removing pid file
2012-12-20 22:18:21.016665 7fb9e77fe700 -1 osd.24 3473  exit



