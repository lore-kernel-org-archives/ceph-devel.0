From: Thomas Mueller <thomas@chaschperli.ch>
Subject: multi-mds hangs on bonnie++ test
Date: Mon, 27 Sep 2010 16:02:14 +0000 (UTC)
Message-ID: <i7qf66$644$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55625 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759058Ab0I0QC1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Sep 2010 12:02:27 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1P0G9p-0002bt-Ln
	for ceph-devel@vger.kernel.org; Mon, 27 Sep 2010 18:02:25 +0200
Received: from 194.230.155.17 ([194.230.155.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 27 Sep 2010 18:02:25 +0200
Received: from thomas by 194.230.155.17 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 27 Sep 2010 18:02:25 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

encouraged by the roadmap mail I started my tests with 
CEPH_NUM_MDS=3 (mon,osd: just one instance). OS is Debian Squeeze with 
kernel 2.56.35.4

bonnie++ hangs after this output:

Using uid:0, gid:0.
Writing a byte at a time...done
Writing intelligently...done
Rewriting...done
Reading a byte at a time...done
Reading intelligently...done
start 'em...done...done...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...
<end of output>


after killing the bonnie++ processes, the other tests go on. mds1 
crashed shortly after killing bonnie++.

output from mds(0|1|2) logs:


tail -n50  mds0 mds1 mds2 
==> mds0 <==
10.09.27_17:54:18.368536 7f6408fb9710 mds0.server find_idle_sessions.  laggy until 10.09.27_17:32:21.264349
10.09.27_17:54:18.368574 7f6408fb9710 mds0.server laggiest active session is client4106 127.0.0.1:0/2526971580
10.09.27_17:54:18.368619 7f6408fb9710 mds0.server laggiest active session is client4106 127.0.0.1:0/2526971580 and sufficiently new (10.09.27_17:54:17.469337)
10.09.27_17:54:18.368663 7f6408fb9710 mds0.bal tick last_sample now 10.09.27_17:54:18.368662
10.09.27_17:54:18.368698 7f6408fb9710 mds0.snap check_osd_map - version unchanged
10.09.27_17:54:21.336439 7f6408fb9710 mds0.1 beacon_send up:active seq 405 (currently up:active)
10.09.27_17:54:21.336593 7f6408fb9710 -- 127.0.0.1:6802/8911 --> mon0 127.0.0.1:6789/0 -- mdsbeacon(4101/a up:active seq 405 v23) v1 -- ?+0 0x7f63fd73ccb0
10.09.27_17:54:21.337957 7f640a0bc710 -- 127.0.0.1:6802/8911 <== mon0 127.0.0.1:6789/0 446 ==== mdsbeacon(4101/a up:active seq 405 v23) v1 ==== 67+0+0 (2491526233 0 0) 0x7f6405266b20
10.09.27_17:54:21.338066 7f640a0bc710 mds0.1 handle_mds_beacon up:active seq 405 rtt 0.001481
10.09.27_17:54:23.364549 7f6408fb9710 mds0.cache trim max=100000  cur=19857
10.09.27_17:54:23.364684 7f6408fb9710 mds0.cache trim_client_leases
10.09.27_17:54:23.368296 7f6408fb9710 mds0.cache check_memory_usage total 343980, rss 236972, heap 264484, malloc 6545 mmap 0, baseline 68332, buffers 12, max 1048576, 4 / 15030 inodes have caps, 4 caps, 0.000266134 caps per inode
10.09.27_17:54:23.368416 7f6408fb9710 mds0.log trim 2 / 2 segments, 2932 / -1 events, 0 (0) expiring, 0 (0) expired
10.09.27_17:54:23.368551 7f6408fb9710 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97>
10.09.27_17:54:23.368651 7f6408fb9710 mds0.locker scatter_tick
10.09.27_17:54:23.368691 7f6408fb9710 mds0.server find_idle_sessions.  laggy until 10.09.27_17:32:21.264349
10.09.27_17:54:23.368730 7f6408fb9710 mds0.server laggiest active session is client4106 127.0.0.1:0/2526971580
10.09.27_17:54:23.368833 7f6408fb9710 mds0.server laggiest active session is client4106 127.0.0.1:0/2526971580 and sufficiently new (10.09.27_17:54:17.469337)
10.09.27_17:54:23.368880 7f6408fb9710 mds0.bal tick last_sample now 10.09.27_17:54:23.368878
10.09.27_17:54:23.368981 7f6408fb9710 mds0.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97>
10.09.27_17:54:23.369087 7f6408fb9710 mds0.bal mds0 epoch 155 load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97>
10.09.27_17:54:23.369178 7f6408fb9710 -- 127.0.0.1:6802/8911 --> mds1 127.0.0.1:6803/8922 -- HB v1 -- ?+0 0x7f63fd0d4370
10.09.27_17:54:23.369286 7f6408fb9710 -- 127.0.0.1:6802/8911 --> mds2 127.0.0.1:6804/8976 -- HB v1 -- ?+0 0x7f63fd42c530
10.09.27_17:54:23.370670 7f6408fb9710 mds0.snap check_osd_map - version unchanged
10.09.27_17:54:23.370751 7f640a0bc710 -- 127.0.0.1:6802/8911 <== mds2 127.0.0.1:6804/8976 162 ==== HB v1 ==== 293+0+0 (3861444616 0 0) 0x15f09d0
10.09.27_17:54:23.371689 7f640a0bc710 -- 127.0.0.1:6802/8911 <== mds1 127.0.0.1:6803/8922 11790 ==== HB v1 ==== 301+0+0 (611334387 0 0) 0x7f63fcdee2d0
10.09.27_17:54:23.371786 7f640a0bc710 mds0.bal  prep_rebalance: cluster loads are
10.09.27_17:54:23.371824 7f640a0bc710 mds0.bal   mds0 mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97> = 0 ~ 0
10.09.27_17:54:23.371887 7f640a0bc710 mds0.bal   mds1 mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97> = 0 ~ 0
10.09.27_17:54:23.371948 7f640a0bc710 mds0.bal   mds2 mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97> = 0 ~ 0
10.09.27_17:54:23.372008 7f640a0bc710 mds0.bal prep_rebalance:  my load 0   target 0   total 0
10.09.27_17:54:23.372050 7f640a0bc710 mds0.bal   i am sufficiently overloaded
10.09.27_17:54:23.372081 7f640a0bc710 mds0.bal    mds0 is exporter
10.09.27_17:54:23.372114 7f640a0bc710 mds0.bal    mds1 is exporter
10.09.27_17:54:23.372147 7f640a0bc710 mds0.bal    mds2 is exporter
10.09.27_17:54:23.372180 7f640a0bc710 mds0.bal   matching exporters to import sources
10.09.27_17:54:23.372216 7f640a0bc710 mds0.bal   matching big exporters to big importers
10.09.27_17:54:23.372251 7f640a0bc710 mds0.bal check_targets have  need  want 
10.09.27_17:54:23.372290 7f640a0bc710 mds0.bal   map: i imported [dir 1 / [2,head] auth{1=2,2=1} v=429 cv=105/105 REP dir_auth=0 state=1610612738|complete f(v0 m10.09.27_17:27:27.693959 2=0+2) n(v23 rc10.09.27_17:44:13.353094 12681=12678+3)/n(v23 rc10.09.27_17:44:12.500187 12735=12732+3) hs=2+7,ss=0+0 dirty=1 | child subtree replicated dirty 0x7f6404020a70] from 0
10.09.27_17:54:23.372360 7f640a0bc710 mds0.bal   map: i imported [dir 100 ~mds0/ [2,head] auth{1=2325} v=7387 cv=11/11 dir_auth=0 state=1610612738|complete f(v0 2=1+1) n(v10 rc10.09.27_17:44:13.353094 b317718528 3694=3693+1) hs=2+0,ss=0+0 dirty=1 | child subtree replicated dirty 0x7f6404021660] from 0
10.09.27_17:54:23.372421 7f640a0bc710 mds0.bal rebalance done
10.09.27_17:54:23.372456 7f640a0bc710 mds0.cache show_subtrees
10.09.27_17:54:23.372504 7f640a0bc710 mds0.cache |____ 1     rep [dir 101 ~mds1/ [2,head] rep@1.1135 dir_auth=1 state=0 f(v0 2=1+1) n(v32 rc10.09.27_17:48:47.474184 1137=1136+1)/n(v32 rc10.09.27_17:47:45.334701 1136=1135+1) hs=1+0,ss=0+0 | child subtree 0x7f6404022e40]
10.09.27_17:54:23.372570 7f640a0bc710 mds0.cache |_.__ 0    auth [dir 1 / [2,head] auth{1=2,2=1} v=429 cv=105/105 REP dir_auth=0 state=1610612738|complete f(v0 m10.09.27_17:27:27.693959 2=0+2) n(v23 rc10.09.27_17:44:13.353094 12681=12678+3)/n(v23 rc10.09.27_17:44:12.500187 12735=12732+3) hs=2+7,ss=0+0 dirty=1 | child subtree replicated dirty 0x7f6404020a70]
10.09.27_17:54:23.372657 7f640a0bc710 mds0.cache | |__ 1     rep [dir 10000000002 /bonnie-1/ [2,head] rep@1.1 dir_auth=1 state=0 f(v0 m10.09.27_17:28:47.481995 1=0+1) n(v30 rc10.09.27_17:48:47.474184 11562=11561+1)/n(v30 rc10.09.27_17:47:45.334701 11563=11562+1) hs=1+0,ss=0+0 | child subtree 0x7f6404022250]
10.09.27_17:54:23.372726 7f640a0bc710 mds0.cache |____ 0    auth [dir 100 ~mds0/ [2,head] auth{1=2325} v=7387 cv=11/11 dir_auth=0 state=1610612738|complete f(v0 2=1+1) n(v10 rc10.09.27_17:44:13.353094 b317718528 3694=3693+1) hs=2+0,ss=0+0 dirty=1 | child subtree replicated dirty 0x7f6404021660]
10.09.27_17:54:25.336784 7f6408fb9710 mds0.1 beacon_send up:active seq 406 (currently up:active)
10.09.27_17:54:25.336848 7f6408fb9710 -- 127.0.0.1:6802/8911 --> mon0 127.0.0.1:6789/0 -- mdsbeacon(4101/a up:active seq 406 v23) v1 -- ?+0 0x7f63fc4ce3b0
10.09.27_17:54:25.337427 7f640a0bc710 -- 127.0.0.1:6802/8911 <== mon0 127.0.0.1:6789/0 447 ==== mdsbeacon(4101/a up:active seq 406 v23) v1 ==== 67+0+0 (2208246382 0 0) 0x7f640406eb70
10.09.27_17:54:25.337464 7f640a0bc710 mds0.1 handle_mds_beacon up:active seq 406 rtt 0.000620

==> mds1 <==
10.09.27_17:54:22.005935 7f3087808710 -- 127.0.0.1:6803/8922 --> mon0 127.0.0.1:6789/0 -- mdsbeacon(4102/b up:active seq 408 v23) v1 -- ?+0 0x7f3079071050
10.09.27_17:54:22.007110 7f308890b710 -- 127.0.0.1:6803/8922 <== mon0 127.0.0.1:6789/0 448 ==== mdsbeacon(4102/b up:active seq 408 v23) v1 ==== 67+0+0 (840284208 0 0) 0x7f3081fc2980
10.09.27_17:54:22.007184 7f308890b710 mds1.1 handle_mds_beacon up:active seq 408 rtt 0.001256
10.09.27_17:54:23.369581 7f308890b710 -- 127.0.0.1:6803/8922 <== mds0 127.0.0.1:6802/8911 15361 ==== HB v1 ==== 293+0+0 (3861444616 0 0) 0x2537420
10.09.27_17:54:23.369689 7f308890b710 mds1.bal  from mds0, new epoch
10.09.27_17:54:23.369817 7f308890b710 mds1.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97>
10.09.27_17:54:23.369935 7f308890b710 mds1.bal mds1 epoch 155 load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97>
10.09.27_17:54:23.369996 7f308890b710 mds1.bal   import_map from 0 -> 0
10.09.27_17:54:23.370067 7f308890b710 -- 127.0.0.1:6803/8922 --> mds0 127.0.0.1:6802/8911 -- HB v1 -- ?+0 0x2103e30
10.09.27_17:54:23.370158 7f308890b710 -- 127.0.0.1:6803/8922 --> mds2 127.0.0.1:6804/8976 -- HB v1 -- ?+0 0x269df00
10.09.27_17:54:23.370225 7f308890b710 mds1.cache show_subtrees
10.09.27_17:54:23.370274 7f308890b710 mds1.cache |____ 1    auth [dir 101 ~mds1/ [2,head] auth{0=1135} v=2271 cv=1/1 dir_auth=1 ap=0+1+1 state=1610612738|complete f(v0 2=1+1) n(v33 rc10.09.27_17:48:47.474184 1137=1136+1) hs=2+0,ss=0+0 dirty=1 | child subtree replicated dirty 0x20daa70]
10.09.27_17:54:23.370357 7f308890b710 mds1.cache |_.__ 0     rep [dir 1 / [2,head] rep@0.2 REP dir_auth=0 state=0 f(v0 m10.09.27_17:27:27.693959 2=0+2) n(v19 rc10.09.27_17:32:34.739657 15172=15169+3)/n(v19 rc10.09.27_17:30:59.890194 16387=16384+3) hs=1+0,ss=0+0 | child subtree 0x20db660]
10.09.27_17:54:23.370425 7f308890b710 mds1.cache | |__ 1    auth [dir 10000000002 /bonnie-1/ [2,head] auth{0=1} v=75219 cv=11951/11951 dir_auth=1 ap=0+1+2 state=1610612738|complete f(v0 m10.09.27_17:28:47.481995 1=0+1) n(v30 rc10.09.27_17:48:47.474184 11562=11561+1) hs=1+0,ss=0+0 dirty=1 | child subtree replicated dirty 0x20dbc58]
10.09.27_17:54:23.370492 7f308890b710 mds1.cache |____ 0     rep [dir 100 ~mds0/ [2,head] rep@0.2325 dir_auth=0 state=0 f(v0 2=1+1) n(v9 rc10.09.27_17:44:13.353094 b317718528 3694=3693+1)/n(v9 rc10.09.27_17:44:13.337098 b317718528 3693=3692+1) hs=1+0,ss=0+0 | child subtree 0x20dc848]
10.09.27_17:54:23.370618 7f308890b710 -- 127.0.0.1:6803/8922 <== mds2 127.0.0.1:6804/8976 155 ==== HB v1 ==== 293+0+0 (3861444616 0 0) 0x27bbf20
10.09.27_17:54:23.370701 7f308890b710 mds1.bal  prep_rebalance: cluster loads are
10.09.27_17:54:23.370739 7f308890b710 mds1.bal prep_rebalance:  my load 0   target 0   total 0
10.09.27_17:54:23.370781 7f308890b710 mds1.bal   i am sufficiently overloaded
10.09.27_17:54:23.370813 7f308890b710 mds1.bal    mds0 is exporter
10.09.27_17:54:23.370845 7f308890b710 mds1.bal    mds1 is exporter
10.09.27_17:54:23.370875 7f308890b710 mds1.bal    mds2 is exporter
10.09.27_17:54:23.370906 7f308890b710 mds1.bal   matching exporters to import sources
10.09.27_17:54:23.370940 7f308890b710 mds1.bal   matching big exporters to big importers
10.09.27_17:54:23.370974 7f308890b710 mds1.bal check_targets have  need  want 
10.09.27_17:54:23.371010 7f308890b710 mds1.bal   map: i imported [dir 101 ~mds1/ [2,head] auth{0=1135} v=2271 cv=1/1 dir_auth=1 ap=0+1+1 state=1610612738|complete f(v0 2=1+1) n(v33 rc10.09.27_17:48:47.474184 1137=1136+1) hs=2+0,ss=0+0 dirty=1 | child subtree replicated dirty 0x20daa70] from 1
10.09.27_17:54:23.371071 7f308890b710 mds1.bal   map: i imported [dir 10000000002 /bonnie-1/ [2,head] auth{0=1} v=75219 cv=11951/11951 dir_auth=1 ap=0+1+2 state=1610612738|complete f(v0 m10.09.27_17:28:47.481995 1=0+1) n(v30 rc10.09.27_17:48:47.474184 11562=11561+1) hs=1+0,ss=0+0 dirty=1 | child subtree replicated dirty 0x20dbc58] from 0
10.09.27_17:54:23.371131 7f308890b710 mds1.bal rebalance done
10.09.27_17:54:23.371163 7f308890b710 mds1.cache show_subtrees
10.09.27_17:54:23.371204 7f308890b710 mds1.cache |____ 1    auth [dir 101 ~mds1/ [2,head] auth{0=1135} v=2271 cv=1/1 dir_auth=1 ap=0+1+1 state=1610612738|complete f(v0 2=1+1) n(v33 rc10.09.27_17:48:47.474184 1137=1136+1) hs=2+0,ss=0+0 dirty=1 | child subtree replicated dirty 0x20daa70]
10.09.27_17:54:23.371266 7f308890b710 mds1.cache |_.__ 0     rep [dir 1 / [2,head] rep@0.2 REP dir_auth=0 state=0 f(v0 m10.09.27_17:27:27.693959 2=0+2) n(v19 rc10.09.27_17:32:34.739657 15172=15169+3)/n(v19 rc10.09.27_17:30:59.890194 16387=16384+3) hs=1+0,ss=0+0 | child subtree 0x20db660]
10.09.27_17:54:23.371330 7f308890b710 mds1.cache | |__ 1    auth [dir 10000000002 /bonnie-1/ [2,head] auth{0=1} v=75219 cv=11951/11951 dir_auth=1 ap=0+1+2 state=1610612738|complete f(v0 m10.09.27_17:28:47.481995 1=0+1) n(v30 rc10.09.27_17:48:47.474184 11562=11561+1) hs=1+0,ss=0+0 dirty=1 | child subtree replicated dirty 0x20dbc58]
10.09.27_17:54:23.371395 7f308890b710 mds1.cache |____ 0     rep [dir 100 ~mds0/ [2,head] rep@0.2325 dir_auth=0 state=0 f(v0 2=1+1) n(v9 rc10.09.27_17:44:13.353094 b317718528 3694=3693+1)/n(v9 rc10.09.27_17:44:13.337098 b317718528 3693=3692+1) hs=1+0,ss=0+0 | child subtree 0x20dc848]
10.09.27_17:54:26.006242 7f3087808710 mds1.1 beacon_send up:active seq 409 (currently up:active)
10.09.27_17:54:26.006383 7f3087808710 -- 127.0.0.1:6803/8922 --> mon0 127.0.0.1:6789/0 -- mdsbeacon(4102/b up:active seq 409 v23) v1 -- ?+0 0x7f30780c1050
10.09.27_17:54:26.007438 7f308890b710 -- 127.0.0.1:6803/8922 <== mon0 127.0.0.1:6789/0 449 ==== mdsbeacon(4102/b up:active seq 409 v23) v1 ==== 67+0+0 (1059046877 0 0) 0x7f3082187930
10.09.27_17:54:26.007525 7f308890b710 mds1.1 handle_mds_beacon up:active seq 409 rtt 0.001154
10.09.27_17:54:26.412460 7f308810a710 monclient: tick
10.09.27_17:54:26.412512 7f308810a710 monclient: _check_auth_rotating renewing rotating keys (they expired before 10.09.27_17:53:56.412507)
10.09.27_17:54:26.896477 7f3087808710 mds1.cache trim max=100000  cur=19852
10.09.27_17:54:26.896620 7f3087808710 mds1.cache trim_client_leases
10.09.27_17:54:26.903895 7f3087808710 mds1.cache check_memory_usage total 300252, rss 169964, heap 217496, malloc 4387 mmap 0, baseline 63924, buffers 16, max 1048576, 5023 / 15029 inodes have caps, 5023 caps, 0.33422 caps per inode
10.09.27_17:54:26.904014 7f3087808710 mds1.log trim 2 / 2 segments, 3283 / -1 events, 0 (0) expiring, 0 (0) expired
10.09.27_17:54:26.904157 7f3087808710 mds1.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97>
10.09.27_17:54:26.904258 7f3087808710 mds1.locker scatter_tick
10.09.27_17:54:26.904297 7f3087808710 mds1.server find_idle_sessions.  laggy until 10.09.27_17:31:56.287539
10.09.27_17:54:26.904335 7f3087808710 mds1.server laggiest active session is client4106 127.0.0.1:0/2526971580
10.09.27_17:54:26.904380 7f3087808710 mds1.server laggiest active session is client4106 127.0.0.1:0/2526971580 and sufficiently new (10.09.27_17:54:17.469303)
10.09.27_17:54:26.904423 7f3087808710 mds1.bal tick last_sample now 10.09.27_17:54:26.904422
10.09.27_17:54:26.904457 7f3087808710 mds1.snap check_osd_map - version unchanged

==> mds2 <==
10.09.27_17:54:17.793981 7f402c9db710 mds2.snap check_osd_map - version unchanged
10.09.27_17:54:18.592119 7f402c9db710 mds2.1 beacon_send up:active seq 407 (currently up:active)
10.09.27_17:54:18.592177 7f402c9db710 -- 127.0.0.1:6804/8976 --> mon0 127.0.0.1:6789/0 -- mdsbeacon(4105/c up:active seq 407 v23) v1 -- ?+0 0x22b7c70
10.09.27_17:54:18.592618 7f402dade710 -- 127.0.0.1:6804/8976 <== mon0 127.0.0.1:6789/0 446 ==== mdsbeacon(4105/c up:active seq 407 v23) v1 ==== 67+0+0 (3558728501 0 0) 0x22b7c70
10.09.27_17:54:18.592642 7f402dade710 mds2.1 handle_mds_beacon up:active seq 407 rtt 0.000470
10.09.27_17:54:21.734219 7f402d2dd710 monclient: tick
10.09.27_17:54:21.734360 7f402d2dd710 monclient: _check_auth_rotating renewing rotating keys (they expired before 10.09.27_17:53:51.734353)
10.09.27_17:54:22.592563 7f402c9db710 mds2.1 beacon_send up:active seq 408 (currently up:active)
10.09.27_17:54:22.592713 7f402c9db710 -- 127.0.0.1:6804/8976 --> mon0 127.0.0.1:6789/0 -- mdsbeacon(4105/c up:active seq 408 v23) v1 -- ?+0 0x22b7c70
10.09.27_17:54:22.593839 7f402dade710 -- 127.0.0.1:6804/8976 <== mon0 127.0.0.1:6789/0 447 ==== mdsbeacon(4105/c up:active seq 408 v23) v1 ==== 67+0+0 (2675539422 0 0) 0x22b7c70
10.09.27_17:54:22.593909 7f402dade710 mds2.1 handle_mds_beacon up:active seq 408 rtt 0.001204
10.09.27_17:54:22.792649 7f402c9db710 mds2.cache trim max=100000  cur=2
10.09.27_17:54:22.792777 7f402c9db710 mds2.cache trim_client_leases
10.09.27_17:54:22.793645 7f402c9db710 mds2.cache check_memory_usage total 158748, rss 3264, heap 68068, malloc 262 mmap 0, baseline 63972, buffers 16, max 1048576, 0 / 4 inodes have caps, 0 caps, 0 caps per inode
10.09.27_17:54:22.793730 7f402c9db710 mds2.log trim 2 / 2 segments, 3 / -1 events, 0 (0) expiring, 0 (0) expired
10.09.27_17:54:22.793853 7f402c9db710 mds2.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97>
10.09.27_17:54:22.793950 7f402c9db710 mds2.locker scatter_tick
10.09.27_17:54:22.793985 7f402c9db710 mds2.server find_idle_sessions.  laggy until 10.09.27_17:31:56.287459
10.09.27_17:54:22.794021 7f402c9db710 mds2.server laggiest active session is client4106 127.0.0.1:0/2526971580
10.09.27_17:54:22.794064 7f402c9db710 mds2.server laggiest active session is client4106 127.0.0.1:0/2526971580 and sufficiently new (10.09.27_17:54:17.469662)
10.09.27_17:54:22.794106 7f402c9db710 mds2.bal tick last_sample now 10.09.27_17:54:22.794104
10.09.27_17:54:22.794139 7f402c9db710 mds2.snap check_osd_map - version unchanged
10.09.27_17:54:23.369577 7f402dade710 -- 127.0.0.1:6804/8976 <== mds0 127.0.0.1:6802/8911 167 ==== HB v1 ==== 293+0+0 (3861444616 0 0) 0x7f402800c970
10.09.27_17:54:23.369677 7f402dade710 mds2.bal  from mds0, new epoch
10.09.27_17:54:23.369795 7f402dade710 mds2.bal get_load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97>
10.09.27_17:54:23.369895 7f402dade710 mds2.bal mds2 epoch 155 load mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 1.97>
10.09.27_17:54:23.369980 7f402dade710 -- 127.0.0.1:6804/8976 --> mds0 127.0.0.1:6802/8911 -- HB v1 -- ?+0 0x7f4028022080
10.09.27_17:54:23.370088 7f402dade710 -- 127.0.0.1:6804/8976 --> mds1 127.0.0.1:6803/8922 -- HB v1 -- ?+0 0x7f4028012f00
10.09.27_17:54:23.370152 7f402dade710 mds2.cache show_subtrees
10.09.27_17:54:23.370196 7f402dade710 mds2.cache |__ 2    auth [dir 102 ~mds2/ [2,head] auth v=1 cv=1/1 dir_auth=2 state=1073741826|complete f(v0 2=1+1) n(v0 2=1+1) hs=2+0,ss=0+0 | child subtree 0x22a5a70]
10.09.27_17:54:23.370254 7f402dade710 mds2.cache |__ 0     rep [dir 1 / [2,head] rep@0.1 REP dir_auth=0 state=0 f(v0 1=0+1) n(v0 1=0+1) hs=0+0,ss=0+0 | subtree 0x22a6660]
10.09.27_17:54:23.371052 7f402dade710 -- 127.0.0.1:6804/8976 <== mds1 127.0.0.1:6803/8922 155 ==== HB v1 ==== 301+0+0 (611334387 0 0) 0x7f4028012f00
10.09.27_17:54:23.371139 7f402dade710 mds2.bal  prep_rebalance: cluster loads are
10.09.27_17:54:23.371175 7f402dade710 mds2.bal prep_rebalance:  my load 0   target 0   total 0
10.09.27_17:54:23.371216 7f402dade710 mds2.bal   i am sufficiently overloaded
10.09.27_17:54:23.371246 7f402dade710 mds2.bal    mds0 is exporter
10.09.27_17:54:23.371277 7f402dade710 mds2.bal    mds1 is exporter
10.09.27_17:54:23.371307 7f402dade710 mds2.bal    mds2 is exporter
10.09.27_17:54:23.371339 7f402dade710 mds2.bal   matching exporters to import sources
10.09.27_17:54:23.371371 7f402dade710 mds2.bal   matching big exporters to big importers
10.09.27_17:54:23.371405 7f402dade710 mds2.bal check_targets have  need  want 
10.09.27_17:54:23.371441 7f402dade710 mds2.bal   map: i imported [dir 102 ~mds2/ [2,head] auth v=1 cv=1/1 dir_auth=2 state=1073741826|complete f(v0 2=1+1) n(v0 2=1+1) hs=2+0,ss=0+0 | child subtree 0x22a5a70] from 2
10.09.27_17:54:23.371491 7f402dade710 mds2.bal rebalance done
10.09.27_17:54:23.371521 7f402dade710 mds2.cache show_subtrees
10.09.27_17:54:23.371560 7f402dade710 mds2.cache |__ 2    auth [dir 102 ~mds2/ [2,head] auth v=1 cv=1/1 dir_auth=2 state=1073741826|complete f(v0 2=1+1) n(v0 2=1+1) hs=2+0,ss=0+0 | child subtree 0x22a5a70]
10.09.27_17:54:23.371611 7f402dade710 mds2.cache |__ 0     rep [dir 1 / [2,head] rep@0.1 REP dir_auth=0 state=0 f(v0 1=0+1) n(v0 1=0+1) hs=0+0,ss=0+0 | subtree 0x22a6660]
10.09.27_17:54:26.593011 7f402c9db710 mds2.1 beacon_send up:active seq 409 (currently up:active)
10.09.27_17:54:26.593153 7f402c9db710 -- 127.0.0.1:6804/8976 --> mon0 127.0.0.1:6789/0 -- mdsbeacon(4105/c up:active seq 409 v23) v1 -- ?+0 0x22b7c70
10.09.27_17:54:26.594365 7f402dade710 -- 127.0.0.1:6804/8976 <== mon0 127.0.0.1:6789/0 448 ==== mdsbeacon(4105/c up:active seq 409 v23) v1 ==== 67+0+0 (2457010227 0 0) 0x22b7c70
10.09.27_17:54:26.594435 7f402dade710 mds2.1 handle_mds_beacon up:active seq 409 rtt 0.001290




crash log mds1:

10.09.27_17:59:10.919524 7f308890b710 -- 127.0.0.1:6803/8922 --> 127.0.0.1:0/2526971580 -- client_reply(???:27106 = 0 Success safe) v1 -- ?+0 0x7f30786e1940
10.09.27_17:59:10.919587 7f308890b710 mds1.cache request_finish request(client4106:27106 cr=0x257df80)
10.09.27_17:59:10.919602 7f308890b710 mds1.cache request_cleanup request(client4106:27106 cr=0x257df80)
10.09.27_17:59:10.919614 7f308890b710 mds1.cache.dir(10000004007) auth_unpin by 0x7f307858f420 on [dir 10000004007 /pdj-fstest/ [2,head] auth{0=1,2=1} pv=1084 v=1076 cv=0/0 dir_auth=1 ap=2+5+6 state=1610612738|complete f(v0 m10.09.27_17:59:08.101591 2=0+2) n(v12 rc10.09.27_17:59:08.369770 a1 5=1+4)/n(v12 rc10.09.27_17:59:06.736919 4=1+3) hs=2+21,ss=0+0 dirty=23 | child subtree replicated dirty authpin 0x20dd438] count now 2 + 6
10.09.27_17:59:10.919637 7f308890b710 mds1.cache.dir(20000000024) auth_unpin by 0x7f307858f420 on [dir 20000000024 /pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/ [2,head] auth pv=21 v=13 cv=0/0 ap=2+14+14 state=1610612738|complete f(v0 m10.09.27_17:59:08.369770 2=2+0) n(v0 rc10.09.27_17:59:08.369770 a1 1=1+0) hs=2+1,ss=0+0 dirty=2 | child dirty authpin 0x412f238] count now 2 + 14
10.09.27_17:59:10.919657 7f308890b710 mds1.cache.den(20000000024 fstest_ffcfc88e0314fba04973becf5e2e1b3a) auth_unpin by 0x7f307858f420 on [dentry #1/pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/fstest_ffcfc88e0314fba04973becf5e2e1b3a [2,head] auth (dn xlockdone x=1) (dversion lock w=1 last_client=4106) pv=15 v=11 inode=0x7f307f410740 state=new | lock inodepin dirty authpin 0x7f307e390360] now 2+5
10.09.27_17:59:10.919674 7f308890b710 mds1.cache.dir(20000000024) adjust_nested_auth_pins -1/-1 on [dir 20000000024 /pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/ [2,head] auth pv=21 v=13 cv=0/0 ap=2+13+13 state=1610612738|complete f(v0 m10.09.27_17:59:08.369770 2=2+0) n(v0 rc10.09.27_17:59:08.369770 a1 1=1+0) hs=2+1,ss=0+0 dirty=2 | child dirty authpin 0x412f238] count now 2 + 13
10.09.27_17:59:10.919694 7f308890b710 mds1.cache.den(20000000024 fstest_9375c104a59d0a566790fa94fa218ce8) auth_unpin by 0x7f307858f420 on [dentry #1/pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/fstest_9375c104a59d0a566790fa94fa218ce8 [2,head] auth REMOTE(reg) (dn xlockdone x=1) (dversion lock w=1 last_client=4106) pv=18 v=10 inode=0x7f307f410740 | request lock dirty authpin 0x7f307e390700] now 2+0
10.09.27_17:59:10.919711 7f308890b710 mds1.cache.dir(20000000024) adjust_nested_auth_pins -1/-1 on [dir 20000000024 /pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/ [2,head] auth pv=21 v=13 cv=0/0 ap=2+12+12 state=1610612738|complete f(v0 m10.09.27_17:59:08.369770 2=2+0) n(v0 rc10.09.27_17:59:08.369770 a1 1=1+0) hs=2+1,ss=0+0 dirty=2 | child dirty authpin 0x412f238] count now 2 + 12
10.09.27_17:59:10.919731 7f308890b710 mds1.cache.den(10000004007 fstest_9cf0007492ebc0dad8e3f785a4872ec4) auth_unpin by 0x7f307858f420 on [dentry #1/pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4 [2,head] auth (dn sync l=1) (dversion lock) pv=1083 v=1075 inode=0x7f307f410d90 | inodepin dirty clientlease 0x7f307e3908d0] now 0+5
10.09.27_17:59:10.919747 7f308890b710 mds1.cache.dir(10000004007) adjust_nested_auth_pins -1/-1 on [dir 10000004007 /pdj-fstest/ [2,head] auth{0=1,2=1} pv=1084 v=1076 cv=0/0 dir_auth=1 ap=2+4+5 state=1610612738|complete f(v0 m10.09.27_17:59:08.101591 2=0+2) n(v12 rc10.09.27_17:59:08.369770 a1 5=1+4)/n(v12 rc10.09.27_17:59:06.736919 4=1+3) hs=2+21,ss=0+0 dirty=23 | child subtree replicated dirty authpin 0x20dd438] count now 2 + 5
10.09.27_17:59:10.919774 7f308890b710 mds1.cache.ino(20000000025) auth_unpin by 0x7f307858f420 on [inode 20000000025 [...2,head] {/pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/fstest_ffcfc88e0314fba04973becf5e2e1b3a /pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/fstest_7d9c480019648afc36612e7a56dda934} auth v11 pv19 ap=4 anc s=0 nl=2 n(v0 a1 1=1+0) (iauth excl) (ilink xlock x=3 by 0x7f30782abc60) (ifile sync) (ixattr excl) (iversion lock w=3 last_client=4106) caps={4106=pAsxXsxFscr/pFscr@5},l=4106 | request lock caps remoteparent dirty authpin 0x7f307f410740] now 4+0
10.09.27_17:59:10.919800 7f308890b710 mds1.cache.dir(20000000024) adjust_nested_auth_pins -1/-1 on [dir 20000000024 /pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/ [2,head] auth pv=21 v=13 cv=0/0 ap=2+11+11 state=1610612738|complete f(v0 m10.09.27_17:59:08.369770 2=2+0) n(v0 rc10.09.27_17:59:08.369770 a1 1=1+0) hs=2+1,ss=0+0 dirty=2 | child dirty authpin 0x412f238] count now 2 + 11
10.09.27_17:59:10.919820 7f308890b710 mds1.cache.ino(20000000024) auth_unpin by 0x7f307858f420 on [inode 20000000024 [...2,head] /pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/ auth v1075 pv1083 ap=3 f(v0 m10.09.27_17:59:08.369770 2=2+0) n(v0 rc10.09.27_17:59:08.369770 a1 2=1+1) (iauth sync) (ilink sync) (idft sync) (isnap sync r=1) (inest mix w=3) (ifile excl w=3) (ixattr excl) (iversion lock w=2 last_client=4106) caps={4106=pAsLsXsxFsx/p@13},l=4106 | lock dirfrag caps dirty authpin 0x7f307f410d90] now 3+1
10.09.27_17:59:10.919846 7f308890b710 mds1.cache.dir(10000004007) adjust_nested_auth_pins -1/-1 on [dir 10000004007 /pdj-fstest/ [2,head] auth{0=1,2=1} pv=1084 v=1076 cv=0/0 dir_auth=1 ap=2+3+4 state=1610612738|complete f(v0 m10.09.27_17:59:08.101591 2=0+2) n(v12 rc10.09.27_17:59:08.369770 a1 5=1+4)/n(v12 rc10.09.27_17:59:06.736919 4=1+3) hs=2+21,ss=0+0 dirty=23 | child subtree replicated dirty authpin 0x20dd438] count now 2 + 4
10.09.27_17:59:10.919883 7f308890b710 mds1.tableclient(anchortable) _logged_ack 55
10.09.27_17:59:10.919895 7f308890b710 mds1.server _rename_finish request(client4106:27108 cr=0x2217480)
10.09.27_17:59:10.919906 7f308890b710 mds1.server _rename_apply request(client4106:27108 cr=0x2217480) [dentry #1/pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/fstest_ffcfc88e0314fba04973becf5e2e1b3a [2,head] auth (dn xlockdone x=1) (dversion lock w=1 last_client=4106) pv=15 v=11 inode=0x7f307f410740 state=new | lock inodepin dirty authpin 0x7f307e390360] [dentry #1/pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/fstest_7d9c480019648afc36612e7a56dda934 [2,head] auth NULL (dn xlock x=2 by 0x7f30782abc60) (dversion lock w=2 last_client=4106) pv=19 v=13 inode=0 | request lock authpin 0x7f307e38fc20]
10.09.27_17:59:10.919938 7f308890b710 mds1.server  pvs {0x7f307e38fc20=14,0x7f307e390360=15}
10.09.27_17:59:10.919950 7f308890b710 mds1.cache.dir(20000000024) unlink_inode [dentry #1/pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/fstest_ffcfc88e0314fba04973becf5e2e1b3a [2,head] auth (dn xlockdone x=1) (dversion lock w=1 last_client=4106) pv=15 v=11 inode=0x7f307f410740 state=new | lock inodepin dirty authpin 0x7f307e390360] [inode 20000000025 [...2,head] {/pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/fstest_ffcfc88e0314fba04973becf5e2e1b3a /pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/fstest_7d9c480019648afc36612e7a56dda934} auth v11 pv19 ap=4 anc s=0 nl=2 n(v0 a1 1=1+0) (iauth excl) (ilink xlock x=3 by 0x7f30782abc60) (ifile sync) (ixattr excl) (iversion lock w=3 last_client=4106) caps={4106=pAsxXsxFscr/pFscr@5},l=4106 | request lock caps remoteparent dirty authpi
 n 0x7f307f410740]
10.09.27_17:59:10.919981 7f308890b710 mds1.cache.dir(20000000024) adjust_nested_auth_pins -4/-4 on [dir 20000000024 /pdj-fstest/fstest_9cf0007492ebc0dad8e3f785a4872ec4/ [2,head] auth pv=21 v=13 cv=0/0 ap=2+7+7 state=1610612738|complete f(v0 m10.09.27_17:59:08.369770 2=2+0) n(v0 rc10.09.27_17:59:08.369770 a1 1=1+0) hs=2+1,ss=0+0 dirty=2 | child dirty authpin 0x412f238] count now 2 + 7
10.09.27_17:59:10.920006 7f308890b710 mds1.cache.den(20000000024 fstest_ffcfc88e0314fba04973becf5e2e1b3a) adjust_nested_anchors by -1 -> -1
mds/CDentry.cc: In function 'void CDentry::adjust_nested_anchors(int)':
mds/CDentry.cc:399: FAILED assert(nested_anchors >= 0)
 1: (CDir::unlink_inode_work(CDentry*)+0x13a) [0x5b09da]
 2: (CDir::unlink_inode(CDentry*)+0x44) [0x5b16c4]
 3: (Server::_rename_apply(MDRequest*, CDentry*, CDentry*, CDentry*)+0x307) [0x4d93d7]
 4: (Server::_rename_finish(MDRequest*, CDentry*, CDentry*, CDentry*)+0x47) [0x4dd537]
 5: (finish_contexts(std::list<Context*, std::allocator<Context*> >&, int)+0x6e) [0x561abe]
 6: (Journaler::_finish_flush(int, long, utime_t, bool)+0x51b) [0x64536b]
 7: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0x701) [0x62eff1]
 8: (MDS::_dispatch(Message*)+0x26b6) [0x499a86]
 9: (MDS::ms_dispatch(Message*)+0x57) [0x499ae7]
 10: (SimpleMessenger::dispatch_entry()+0x693) [0x47baf3]
 11: (SimpleMessenger::DispatchThread::entry()+0x4d) [0x47693d]
 12: (Thread::_entry_func(void*)+0x7) [0x48a807]
 13: (()+0x68ba) [0x7f308abdd8ba]
 14: (clone()+0x6d) [0x7f3089df802d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.




