From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 17 Feb 2011 23:13:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37120 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab1BRHM3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 02:12:29 -0500
In-Reply-To: <1297985503.25491.175.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 17 Feb 2011, Jim Schutt wrote:
> Check out the result:
> 
> osd.68.log:256027:2011-02-17 15:44:50.141378 7fd42ad57940 osd68 5 tick
> osd.68.log:256028:2011-02-17 15:44:50.141464 7fd42ad57940 osd68 5 tick getting read lock on map_lock
> osd.68.log:256029:2011-02-17 15:44:50.141472 7fd42ad57940 osd68 5 tick got read lock on map_lock
> osd.68.log:256031:2011-02-17 15:44:50.141612 7fd42ad57940 osd68 5 tick sending mon report
> osd.68.log:256032:2011-02-17 15:44:50.141619 7fd42ad57940 osd68 5 tick removing stray pgs
> osd.68.log:256033:2011-02-17 15:44:50.141626 7fd42ad57940 osd68 5 tick sending log to logclient
> osd.68.log:256034:2011-02-17 15:44:50.141633 7fd42ad57940 osd68 5 tick arming timer for next tick     <==
> osd.68.log:256277:2011-02-17 15:45:18.481656 7fd42ad57940 osd68 5 tick checking dispatch queue status <== 28 second gap
> osd.68.log:256278:2011-02-17 15:45:18.481669 7fd42ad57940 osd68 5 tick done
> osd.68.log:256279:2011-02-17 15:45:18.481691 7fd42ad57940 osd68 5 tick
> osd.68.log:256280:2011-02-17 15:45:18.481705 7fd42ad57940 osd68 5 tick getting read lock on map_lock
> osd.68.log:256281:2011-02-17 15:45:18.481712 7fd42ad57940 osd68 5 tick got read lock on map_lock
> osd.68.log:256688:2011-02-17 15:45:20.010705 7fd42ad57940 osd68 5 tick sending mon report
> osd.68.log:256753:2011-02-17 15:45:20.012950 7fd42ad57940 osd68 5 tick removing stray pgs
> osd.68.log:256754:2011-02-17 15:45:20.012959 7fd42ad57940 osd68 5 tick sending log to logclient
> osd.68.log:256755:2011-02-17 15:45:20.012965 7fd42ad57940 osd68 5 tick arming timer for next tick
> osd.68.log:256756:2011-02-17 15:45:20.012976 7fd42ad57940 osd68 5 tick checking dispatch queue status
> osd.68.log:256757:2011-02-17 15:45:20.012993 7fd42ad57940 osd68 5 tick done
> 
> Why should it take 28 seconds to add a new timer event?

Huh.. that is pretty weird.  I see multiple sync in there, too, so it's 
not like something was somehow blocking on a btrfs commit.

Anybody else have ideas?  :/

sage

> 
> Here's the full log spanning that 28 second gap in tick():
> 
> osd.68.log:256027:2011-02-17 15:44:50.141378 7fd42ad57940 osd68 5 tick
> osd.68.log-256028-2011-02-17 15:44:50.141464 7fd42ad57940 osd68 5 tick getting read lock on map_lock
> osd.68.log-256029-2011-02-17 15:44:50.141472 7fd42ad57940 osd68 5 tick got read lock on map_lock
> osd.68.log-256030-2011-02-17 15:44:50.141540 7fd42ad57940 osd68 5 scrub_should_schedule loadavg 32.73 >= max 1.25 = no, load too high
> osd.68.log-256031-2011-02-17 15:44:50.141612 7fd42ad57940 osd68 5 tick sending mon report
> osd.68.log-256032-2011-02-17 15:44:50.141619 7fd42ad57940 osd68 5 tick removing stray pgs
> osd.68.log-256033-2011-02-17 15:44:50.141626 7fd42ad57940 osd68 5 tick sending log to logclient
> osd.68.log-256034-2011-02-17 15:44:50.141633 7fd42ad57940 osd68 5 tick arming timer for next tick
> osd.68.log-256035-2011-02-17 15:44:52.813591 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry woke after 5.002862
> osd.68.log-256036-2011-02-17 15:44:52.813653 7fd429554940 journal commit_start op_seq 3082, applied_seq 3082, committed_seq 3069
> osd.68.log-256037-2011-02-17 15:44:52.813661 7fd429554940 journal commit_start committing 3082, still blocked
> osd.68.log-256038-2011-02-17 15:44:52.813666 7fd429554940 journal commit_start
> osd.68.log-256039-2011-02-17 15:44:52.813672 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry committing 3082 sync_epoch 48
> osd.68.log-256040-2011-02-17 15:44:52.813945 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) taking async snap 'snap_3082'
> osd.68.log-256041-2011-02-17 15:44:53.693394 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) async snap create 'snap_3082' transid 65 got 0 Success
> osd.68.log-256042-2011-02-17 15:44:53.693437 7fd429554940 journal commit_started committing 3082, unblocking
> osd.68.log-256043-2011-02-17 15:44:53.693445 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068)  waiting for transid 65 to complete
> osd.68.log-256044-2011-02-17 15:44:53.751214 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068)  done waiting for transid 65 to complete
> osd.68.log-256045-2011-02-17 15:44:53.751286 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry commit took 0.937614
> osd.68.log-256046-2011-02-17 15:44:53.751295 7fd429554940 journal commit_finish thru 3082
> osd.68.log-256047-2011-02-17 15:44:55.793734 7fd42554c940 -- 172.17.40.29:6814/12558 <== osd29 172.17.40.24:6817/11926 286 ==== osd_ping(e5 as_of 5) v1 ==== 61+0+0 (4012807742 0 0) 0x7fd404061cf0 con 0xeef270
> osd.68.log-256048-2011-02-17 15:44:55.793804 7fd42554c940 osd68 5 heartbeat_dispatch 0x7fd404061cf0
> osd.68.log-256049-2011-02-17 15:44:55.793811 7fd42554c940 osd68 5 handle_osd_ping from osd29 got stat stat(2011-02-17 15:44:49.760084 oprate=7.39631 qlen=0 recent_qlen=0 rdlat=0 / 0 fshedin=0)
> osd.68.log-256050-2011-02-17 15:44:55.936072 7fd42a556940 journal write_thread_entry going to sleep
> osd.68.log-256051-2011-02-17 15:44:55.936131 7fd429554940 journal committed_thru 3082 (last_committed_seq 3069)
> osd.68.log-256052-2011-02-17 15:44:55.936142 7fd429554940 journal header: block_size 4096 alignment 4096 max_size 526385152
> osd.68.log-256053-2011-02-17 15:44:55.936149 7fd429554940 journal header: start 499519488
> osd.68.log-256054-2011-02-17 15:44:55.936154 7fd429554940 journal  write_pos 499519488
> osd.68.log-256055-2011-02-17 15:44:55.936160 7fd429554940 journal committed_thru done
> osd.68.log-256056-2011-02-17 15:44:55.936175 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) removing snap 'snap_3038'
> osd.68.log-256057-2011-02-17 15:44:56.030632 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry committed to op_seq 3082
> osd.68.log-256058-2011-02-17 15:44:56.030670 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry waiting for max_interval 5.000000
> osd.68.log-256059-2011-02-17 15:44:57.763019 7fd425d4d940 -- 172.17.40.29:6813/12558 <== osd31 172.17.40.24:6822/12076 34 ==== osd_sub_op_reply(client4196.1:143 0.b03 100000003e9.0000008e/head [] ack = 0) v1 ==== 127+0+0 (603260922 0 0) 0x7fd41c005fe0 con 0xe2ec20
> osd.68.log-256060-2011-02-17 15:45:01.030890 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry woke after 5.000218
> osd.68.log-256061-2011-02-17 15:45:01.030964 7fd429554940 journal commit_start op_seq 3082, applied_seq 3082, committed_seq 3082
> osd.68.log-256062-2011-02-17 15:45:01.030970 7fd429554940 journal commit_start nothing to do
> osd.68.log-256063-2011-02-17 15:45:01.030976 7fd429554940 journal commit_start
> osd.68.log-256064-2011-02-17 15:45:01.030986 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry waiting for max_interval 5.000000
> osd.68.log-256065-2011-02-17 15:45:06.031075 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry woke after 5.000087
> osd.68.log-256066-2011-02-17 15:45:06.031104 7fd429554940 journal commit_start op_seq 3082, applied_seq 3082, committed_seq 3082
> osd.68.log-256067-2011-02-17 15:45:06.031114 7fd429554940 journal commit_start nothing to do
> osd.68.log-256068-2011-02-17 15:45:06.031122 7fd429554940 journal commit_start
> osd.68.log-256069-2011-02-17 15:45:06.031134 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry waiting for max_interval 5.000000
> osd.68.log-256070-2011-02-17 15:45:10.642177 7fd40adee940 -- 172.17.40.29:6812/12558 >> 172.17.40.58:0/3091507398 pipe(0x7fd3fc0ed010 sd=214 pgs=90 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256071-2011-02-17 15:45:10.642274 7fd40adee940 -- 172.17.40.29:6812/12558 >> 172.17.40.58:0/3091507398 pipe(0x7fd3fc0ed010 sd=214 pgs=90 cs=1 l=1).fault 0: Success
> osd.68.log-256072-2011-02-17 15:45:10.642431 7fd40aff0940 -- 172.17.40.29:6812/12558 >> 172.17.40.74:0/2165351138 pipe(0xdbac20 sd=156 pgs=6 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256073-2011-02-17 15:45:10.642461 7fd40aff0940 -- 172.17.40.29:6812/12558 >> 172.17.40.74:0/2165351138 pipe(0xdbac20 sd=156 pgs=6 cs=1 l=1).fault 0: Success
> osd.68.log-256074-2011-02-17 15:45:10.642606 7fd3fb0f2940 -- 172.17.40.29:6812/12558 >> 172.17.40.57:0/579985139 pipe(0x105ec30 sd=198 pgs=65 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256075-2011-02-17 15:45:10.642670 7fd3fb0f2940 -- 172.17.40.29:6812/12558 >> 172.17.40.57:0/579985139 pipe(0x105ec30 sd=198 pgs=65 cs=1 l=1).fault 0: Success
> osd.68.log-256076-2011-02-17 15:45:10.642790 7fd408cd9940 -- 172.17.40.29:6812/12558 >> 172.17.40.65:0/2115694822 pipe(0x1032d20 sd=161 pgs=10 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256077-2011-02-17 15:45:10.642818 7fd408cd9940 -- 172.17.40.29:6812/12558 >> 172.17.40.65:0/2115694822 pipe(0x1032d20 sd=161 pgs=10 cs=1 l=1).fault 0: Success
> osd.68.log-256078-2011-02-17 15:45:10.643238 7fd3faff1940 -- 172.17.40.29:6812/12558 >> 172.17.40.66:0/892415451 pipe(0xc7fe50 sd=199 pgs=69 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256079-2011-02-17 15:45:10.643268 7fd3faff1940 -- 172.17.40.29:6812/12558 >> 172.17.40.66:0/892415451 pipe(0xc7fe50 sd=199 pgs=69 cs=1 l=1).fault 0: Success
> osd.68.log-256080-2011-02-17 15:45:10.643291 7fd4025e5940 -- 172.17.40.29:6812/12558 >> 172.17.40.70:0/2135188772 pipe(0xf88c20 sd=176 pgs=44 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256081-2011-02-17 15:45:10.643362 7fd4025e5940 -- 172.17.40.29:6812/12558 >> 172.17.40.70:0/2135188772 pipe(0xf88c20 sd=176 pgs=44 cs=1 l=1).fault 0: Success
> osd.68.log-256082-2011-02-17 15:45:10.643507 7fd40a4e9940 -- 172.17.40.29:6812/12558 >> 172.17.40.62:0/59132854 pipe(0xd72cf0 sd=157 pgs=5 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256083-2011-02-17 15:45:10.643622 7fd40a4e9940 -- 172.17.40.29:6812/12558 >> 172.17.40.62:0/59132854 pipe(0xd72cf0 sd=157 pgs=5 cs=1 l=1).fault 0: Success
> osd.68.log-256084-2011-02-17 15:45:10.643870 7fd409ce3940 -- 172.17.40.29:6812/12558 >> 172.17.40.84:0/103596728 pipe(0xca56a0 sd=159 pgs=5 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256085-2011-02-17 15:45:10.643902 7fd409ce3940 -- 172.17.40.29:6812/12558 >> 172.17.40.84:0/103596728 pipe(0xca56a0 sd=159 pgs=5 cs=1 l=1).fault 0: Success
> osd.68.log-256086-2011-02-17 15:45:10.644044 7fd3f88d2940 -- 172.17.40.29:6812/12558 >> 172.17.40.77:0/3894807147 pipe(0x7fd3fc008fc0 sd=210 pgs=83 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256087-2011-02-17 15:45:10.644084 7fd3f88d2940 -- 172.17.40.29:6812/12558 >> 172.17.40.77:0/3894807147 pipe(0x7fd3fc008fc0 sd=210 pgs=83 cs=1 l=1).fault 0: Success
> osd.68.log-256088-2011-02-17 15:45:10.644274 7fd4009c9940 -- 172.17.40.29:6812/12558 >> 172.17.40.63:0/118294342 pipe(0xd53c20 sd=190 pgs=44 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256089-2011-02-17 15:45:10.644302 7fd4009c9940 -- 172.17.40.29:6812/12558 >> 172.17.40.63:0/118294342 pipe(0xd53c20 sd=190 pgs=44 cs=1 l=1).fault 0: Success
> osd.68.log-256090-2011-02-17 15:45:10.644446 7fd40abec940 -- 172.17.40.29:6812/12558 >> 172.17.40.76:0/3517121089 pipe(0x7fd3fc5de370 sd=215 pgs=86 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256091-2011-02-17 15:45:10.644509 7fd40abec940 -- 172.17.40.29:6812/12558 >> 172.17.40.76:0/3517121089 pipe(0x7fd3fc5de370 sd=215 pgs=86 cs=1 l=1).fault 0: Success
> osd.68.log-256092-2011-02-17 15:45:10.644602 7fd3f9bdd940 -- 172.17.40.29:6812/12558 >> 172.17.40.55:0/1343812630 pipe(0x7fd3fc008250 sd=209 pgs=75 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256093-2011-02-17 15:45:10.644636 7fd3f9bdd940 -- 172.17.40.29:6812/12558 >> 172.17.40.55:0/1343812630 pipe(0x7fd3fc008250 sd=209 pgs=75 cs=1 l=1).fault 0: Success
> osd.68.log-256094-2011-02-17 15:45:10.645375 7fd401bdb940 -- 172.17.40.29:6812/12558 >> 172.17.40.72:0/658453639 pipe(0xe3ad20 sd=182 pgs=28 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256095-2011-02-17 15:45:10.645394 7fd401bdb940 -- 172.17.40.29:6812/12558 >> 172.17.40.72:0/658453639 pipe(0xe3ad20 sd=182 pgs=28 cs=1 l=1).fault 0: Success
> osd.68.log-256096-2011-02-17 15:45:10.645714 7fd4033f3940 -- 172.17.40.29:6812/12558 >> 172.17.40.85:0/2266176512 pipe(0x1028c50 sd=169 pgs=9 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256097-2011-02-17 15:45:10.645740 7fd4033f3940 -- 172.17.40.29:6812/12558 >> 172.17.40.85:0/2266176512 pipe(0x1028c50 sd=169 pgs=9 cs=1 l=1).fault 0: Success
> osd.68.log-256098-2011-02-17 15:45:10.646231 7fd3fa0e2940 -- 172.17.40.29:6812/12558 >> 172.17.40.103:0/1723900743 pipe(0x7fd3fc002d70 sd=206 pgs=85 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256099-2011-02-17 15:45:10.646304 7fd3fa0e2940 -- 172.17.40.29:6812/12558 >> 172.17.40.103:0/1723900743 pipe(0x7fd3fc002d70 sd=206 pgs=85 cs=1 l=1).fault 0: Success
> osd.68.log-256100-2011-02-17 15:45:10.646372 7fd3f42ae940 -- 172.17.40.29:6812/12558 >> 172.17.40.101:0/1743123736 pipe(0x7fd3fc019720 sd=211 pgs=40 cs=1 l=1).reader couldn't read tag, Success
> osd.68.log-256101-2011-02-17 15:45:10.646397 7fd3f42ae940 -- 172.17.40.29:6812/12558 >> 172.17.40.101:0/1743123736 pipe(0x7fd3fc019720 sd=211 pgs=40 cs=1 l=1).fault 0: Success
> osd.68.log-256102-2011-02-17 15:45:10.844357 7fd410747940 -- 172.17.40.29:6813/12558 >> 172.17.40.21:6822/11833 pipe(0x7fd41c03bc20 sd=115 pgs=65 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256103-2011-02-17 15:45:10.844395 7fd410747940 -- 172.17.40.29:6813/12558 >> 172.17.40.21:6822/11833 pipe(0x7fd41c03bc20 sd=115 pgs=65 cs=1 l=0).fault 0: Success
> osd.68.log-256104-2011-02-17 15:45:10.844418 7fd410747940 -- 172.17.40.29:6813/12558 >> 172.17.40.21:6822/11833 pipe(0x7fd41c03bc20 sd=115 pgs=65 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256105-2011-02-17 15:45:11.031203 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry woke after 5.000067
> osd.68.log-256106-2011-02-17 15:45:11.031233 7fd429554940 journal commit_start op_seq 3082, applied_seq 3082, committed_seq 3082
> osd.68.log-256107-2011-02-17 15:45:11.031240 7fd429554940 journal commit_start nothing to do
> osd.68.log-256108-2011-02-17 15:45:11.031246 7fd429554940 journal commit_start
> osd.68.log-256109-2011-02-17 15:45:11.031254 7fd429554940 filestore(/ram/mnt/ceph/data.osd.0068) sync_entry waiting for max_interval 5.000000
> osd.68.log-256110-2011-02-17 15:45:11.193386 7fd4183c3940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6801/12830 pipe(0xeba000 sd=55 pgs=53 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256111-2011-02-17 15:45:11.193424 7fd4183c3940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6801/12830 pipe(0xeba000 sd=55 pgs=53 cs=1 l=0).fault 0: Success
> osd.68.log-256112-2011-02-17 15:45:11.193451 7fd4183c3940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6801/12830 pipe(0xeba000 sd=55 pgs=53 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256113-2011-02-17 15:45:11.291656 7fd4199d9940 -- 172.17.40.29:6813/12558 >> 172.17.40.31:6810/12606 pipe(0xec3c20 sd=43 pgs=48 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256114-2011-02-17 15:45:11.291738 7fd4199d9940 -- 172.17.40.29:6813/12558 >> 172.17.40.31:6810/12606 pipe(0xec3c20 sd=43 pgs=48 cs=1 l=0).fault 0: Success
> osd.68.log-256115-2011-02-17 15:45:11.291766 7fd4199d9940 -- 172.17.40.29:6813/12558 >> 172.17.40.31:6810/12606 pipe(0xec3c20 sd=43 pgs=48 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256116-2011-02-17 15:45:11.699576 7fd40b3f4940 -- 172.17.40.29:6814/12558 >> 172.17.40.31:6820/12848 pipe(0x7fd41c095d30 sd=150 pgs=110 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256117-2011-02-17 15:45:15.907490 7fd40b3f4940 -- 172.17.40.29:6814/12558 >> 172.17.40.31:6820/12848 pipe(0x7fd41c095d30 sd=150 pgs=110 cs=1 l=0).fault 0: Success
> osd.68.log-256118-2011-02-17 15:45:15.907579 7fd40b3f4940 -- 172.17.40.29:6814/12558 >> 172.17.40.31:6820/12848 pipe(0x7fd41c095d30 sd=150 pgs=110 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256119-2011-02-17 15:45:15.907594 7fd416faf940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6804/12907 pipe(0xeef800 sd=65 pgs=59 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256120-2011-02-17 15:45:15.907616 7fd416faf940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6804/12907 pipe(0xeef800 sd=65 pgs=59 cs=1 l=0).fault 0: Success
> osd.68.log-256121-2011-02-17 15:45:15.907637 7fd416faf940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6804/12907 pipe(0xeef800 sd=65 pgs=59 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256122-2011-02-17 15:45:15.907655 7fd417ebe940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6813/13164 pipe(0xed7260 sd=59 pgs=60 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256123-2011-02-17 15:45:15.907675 7fd417ebe940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6813/13164 pipe(0xed7260 sd=59 pgs=60 cs=1 l=0).fault 0: Success
> osd.68.log-256124-2011-02-17 15:45:15.907695 7fd417ebe940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6813/13164 pipe(0xed7260 sd=59 pgs=60 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256125-2011-02-17 15:45:15.907734 7fd412363940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6814/13164 pipe(0x7fd41c116c30 sd=70 pgs=127 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256126-2011-02-17 15:45:15.907763 7fd412363940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6814/13164 pipe(0x7fd41c116c30 sd=70 pgs=127 cs=1 l=0).fault 0: Success
> osd.68.log-256127-2011-02-17 15:45:15.907814 7fd412363940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6814/13164 pipe(0x7fd41c116c30 sd=70 pgs=127 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256128-2011-02-17 15:45:15.907829 7fd420433940 -- 172.17.40.29:6813/12558 >> 172.17.40.26:6819/11475 pipe(0xd4fd40 sd=23 pgs=54 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256129-2011-02-17 15:45:15.907850 7fd420433940 -- 172.17.40.29:6813/12558 >> 172.17.40.26:6819/11475 pipe(0xd4fd40 sd=23 pgs=54 cs=1 l=0).fault 0: Success
> osd.68.log-256130-2011-02-17 15:45:15.907871 7fd420433940 -- 172.17.40.29:6813/12558 >> 172.17.40.26:6819/11475 pipe(0xd4fd40 sd=23 pgs=54 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256131-2011-02-17 15:45:15.909670 7fd40cc0c940 -- 172.17.40.29:6814/12558 >> 172.17.40.25:6805/12657 pipe(0x7fd41c378cc0 sd=82 pgs=111 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256132-2011-02-17 15:45:15.910080 7fd40cc0c940 -- 172.17.40.29:6814/12558 >> 172.17.40.25:6805/12657 pipe(0x7fd41c378cc0 sd=82 pgs=111 cs=1 l=0).fault 0: Success
> osd.68.log-256133-2011-02-17 15:45:15.910108 7fd40cc0c940 -- 172.17.40.29:6814/12558 >> 172.17.40.25:6805/12657 pipe(0x7fd41c378cc0 sd=82 pgs=111 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256134-2011-02-17 15:45:15.910127 7fd411e5e940 -- 172.17.40.29:6814/12558 >> 172.17.40.26:6820/11475 pipe(0x7fd41c161d60 sd=86 pgs=131 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256135-2011-02-17 15:45:15.910194 7fd411e5e940 -- 172.17.40.29:6814/12558 >> 172.17.40.26:6820/11475 pipe(0x7fd41c161d60 sd=86 pgs=131 cs=1 l=0).fault 0: Success
> osd.68.log-256136-2011-02-17 15:45:15.910215 7fd411e5e940 -- 172.17.40.29:6814/12558 >> 172.17.40.26:6820/11475 pipe(0x7fd41c161d60 sd=86 pgs=131 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256137-2011-02-17 15:45:15.910228 7fd420938940 -- 172.17.40.29:6813/12558 >> 172.17.40.26:6810/11227 pipe(0xf20c30 sd=20 pgs=57 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256138-2011-02-17 15:45:15.910247 7fd420938940 -- 172.17.40.29:6813/12558 >> 172.17.40.26:6810/11227 pipe(0xf20c30 sd=20 pgs=57 cs=1 l=0).fault 0: Success
> osd.68.log-256139-2011-02-17 15:45:15.910266 7fd420938940 -- 172.17.40.29:6813/12558 >> 172.17.40.26:6810/11227 pipe(0xf20c30 sd=20 pgs=57 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256140-2011-02-17 15:45:15.910291 7fd410040940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6816/13237 pipe(0x7fd41c31ac20 sd=116 pgs=70 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256141-2011-02-17 15:45:15.910311 7fd410040940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6816/13237 pipe(0x7fd41c31ac20 sd=116 pgs=70 cs=1 l=0).fault 0: Success
> osd.68.log-256142-2011-02-17 15:45:15.910332 7fd410040940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6816/13237 pipe(0x7fd41c31ac20 sd=116 pgs=70 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256143-2011-02-17 15:45:15.910350 7fd40bafb940 -- 172.17.40.29:6814/12558 >> 172.17.40.28:6802/12017 pipe(0x7fd41c02db90 sd=143 pgs=129 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256144-2011-02-17 15:45:15.910597 7fd40bafb940 -- 172.17.40.29:6814/12558 >> 172.17.40.28:6802/12017 pipe(0x7fd41c02db90 sd=143 pgs=129 cs=1 l=0).fault 0: Success
> osd.68.log-256145-2011-02-17 15:45:15.910618 7fd40bafb940 -- 172.17.40.29:6814/12558 >> 172.17.40.28:6802/12017 pipe(0x7fd41c02db90 sd=143 pgs=129 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256146-2011-02-17 15:45:15.910667 7fd40c909940 -- 172.17.40.29:6814/12558 >> 172.17.40.24:6820/11999 pipe(0x7fd41c141ce0 sd=110 pgs=106 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256147-2011-02-17 15:45:15.912873 7fd40c909940 -- 172.17.40.29:6814/12558 >> 172.17.40.24:6820/11999 pipe(0x7fd41c141ce0 sd=110 pgs=106 cs=1 l=0).fault 0: Success
> osd.68.log-256148-2011-02-17 15:45:15.912926 7fd40c909940 -- 172.17.40.29:6814/12558 >> 172.17.40.24:6820/11999 pipe(0x7fd41c141ce0 sd=110 pgs=106 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256149-2011-02-17 15:45:15.912944 7fd41befe940 -- 172.17.40.29:6813/12558 >> 172.17.40.26:6822/11561 pipe(0xd70c20 sd=25 pgs=58 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256150-2011-02-17 15:45:15.912965 7fd41befe940 -- 172.17.40.29:6813/12558 >> 172.17.40.26:6822/11561 pipe(0xd70c20 sd=25 pgs=58 cs=1 l=0).fault 0: Success
> osd.68.log-256151-2011-02-17 15:45:15.912986 7fd41befe940 -- 172.17.40.29:6813/12558 >> 172.17.40.26:6822/11561 pipe(0xd70c20 sd=25 pgs=58 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256152-2011-02-17 15:45:15.913111 7fd4195d5940 -- 172.17.40.29:6813/12558 >> 172.17.40.24:6822/12076 pipe(0xc72d50 sd=46 pgs=58 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256153-2011-02-17 15:45:15.913133 7fd4195d5940 -- 172.17.40.29:6813/12558 >> 172.17.40.24:6822/12076 pipe(0xc72d50 sd=46 pgs=58 cs=1 l=0).fault 0: Success
> osd.68.log-256154-2011-02-17 15:45:15.913156 7fd4195d5940 -- 172.17.40.29:6813/12558 >> 172.17.40.24:6822/12076 pipe(0xc72d50 sd=46 pgs=58 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256155-2011-02-17 15:45:15.913184 7fd40b8f9940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6820/13948 pipe(0x7fd41c10fb90 sd=142 pgs=129 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256156-2011-02-17 15:45:15.914376 7fd40b8f9940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6820/13948 pipe(0x7fd41c10fb90 sd=142 pgs=129 cs=1 l=0).fault 0: Success
> osd.68.log-256157-2011-02-17 15:45:15.914399 7fd40b8f9940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6820/13948 pipe(0x7fd41c10fb90 sd=142 pgs=129 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256158-2011-02-17 15:45:15.914423 7fd412c6c940 -- 172.17.40.29:6813/12558 >> 172.17.40.32:6816/12882 pipe(0xea1f90 sd=98 pgs=61 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256159-2011-02-17 15:45:15.914443 7fd412c6c940 -- 172.17.40.29:6813/12558 >> 172.17.40.32:6816/12882 pipe(0xea1f90 sd=98 pgs=61 cs=1 l=0).fault 0: Success
> osd.68.log-256160-2011-02-17 15:45:15.914462 7fd412c6c940 -- 172.17.40.29:6813/12558 >> 172.17.40.32:6816/12882 pipe(0xea1f90 sd=98 pgs=61 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256161-2011-02-17 15:45:15.914479 7fd40f838940 -- 172.17.40.29:6813/12558 >> 172.17.40.23:6804/13532 pipe(0x7fd41c06bc20 sd=119 pgs=71 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256162-2011-02-17 15:45:15.914499 7fd40f838940 -- 172.17.40.29:6813/12558 >> 172.17.40.23:6804/13532 pipe(0x7fd41c06bc20 sd=119 pgs=71 cs=1 l=0).fault 0: Success
> osd.68.log-256163-2011-02-17 15:45:15.914519 7fd40f838940 -- 172.17.40.29:6813/12558 >> 172.17.40.23:6804/13532 pipe(0x7fd41c06bc20 sd=119 pgs=71 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256164-2011-02-17 15:45:15.914532 7fd40bbfc940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6817/12882 pipe(0x7fd41c1fad30 sd=136 pgs=119 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256165-2011-02-17 15:45:15.914935 7fd40bbfc940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6817/12882 pipe(0x7fd41c1fad30 sd=136 pgs=119 cs=1 l=0).fault 0: Success
> osd.68.log-256166-2011-02-17 15:45:15.914957 7fd40bbfc940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6817/12882 pipe(0x7fd41c1fad30 sd=136 pgs=119 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256167-2011-02-17 15:45:15.914971 7fd40b6f7940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6817/13853 pipe(0x7fd41c186ba0 sd=137 pgs=132 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256168-2011-02-17 15:45:15.915453 7fd40b6f7940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6817/13853 pipe(0x7fd41c186ba0 sd=137 pgs=132 cs=1 l=0).fault 0: Success
> osd.68.log-256169-2011-02-17 15:45:15.915467 7fd41a6e6940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6808/12993 pipe(0xe14c20 sd=37 pgs=90 cs=1 l=0).fault 0: Success
> osd.68.log-256170-2011-02-17 15:45:15.915507 7fd41a6e6940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6808/12993 pipe(0xe14c20 sd=37 pgs=90 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256171-2011-02-17 15:45:15.915542 7fd421241940 -- 172.17.40.29:6814/12558 >> 172.17.40.21:6808/11429 pipe(0xc63000 sd=15 pgs=136 cs=1 l=0).fault 107: Transport endpoint is not connected
> osd.68.log-256172-2011-02-17 15:45:15.915574 7fd421241940 -- 172.17.40.29:6814/12558 >> 172.17.40.21:6808/11429 pipe(0xc63000 sd=15 pgs=136 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256173-2011-02-17 15:45:15.915644 7fd421140940 -- 172.17.40.29:6813/12558 >> 172.17.40.29:6810/12473 pipe(0xcb0300 sd=14 pgs=1 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256174-2011-02-17 15:45:15.915778 7fd421140940 -- 172.17.40.29:6813/12558 >> 172.17.40.29:6810/12473 pipe(0xcb0300 sd=14 pgs=1 cs=1 l=0).fault 0: Success
> osd.68.log-256175-2011-02-17 15:45:15.915826 7fd421140940 -- 172.17.40.29:6813/12558 >> 172.17.40.29:6810/12473 pipe(0xcb0300 sd=14 pgs=1 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256176-2011-02-17 15:45:15.915927 7fd40e929940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6802/13458 pipe(0x7fd41c228c20 sd=135 pgs=121 cs=1 l=0).fault 0: Success
> osd.68.log-256177-2011-02-17 15:45:15.915964 7fd40e929940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6802/13458 pipe(0x7fd41c228c20 sd=135 pgs=121 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256178-2011-02-17 15:45:15.915994 7fd415797940 -- 172.17.40.29:6814/12558 >> 172.17.40.21:6805/11346 pipe(0x7fd41c28fc20 sd=60 pgs=120 cs=1 l=0).fault 0: Success
> osd.68.log-256179-2011-02-17 15:45:15.916021 7fd415797940 -- 172.17.40.29:6814/12558 >> 172.17.40.21:6805/11346 pipe(0x7fd41c28fc20 sd=60 pgs=120 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256180-2011-02-17 15:45:15.916283 7fd413676940 -- 172.17.40.29:6814/12558 >> 172.17.40.24:6811/11754 pipe(0x7fd41c265c20 sd=41 pgs=112 cs=1 l=0).fault 0: Success
> osd.68.log-256181-2011-02-17 15:45:15.916313 7fd413676940 -- 172.17.40.29:6814/12558 >> 172.17.40.24:6811/11754 pipe(0x7fd41c265c20 sd=41 pgs=112 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256182-2011-02-17 15:45:15.916456 7fd415595940 -- 172.17.40.29:6813/12558 >> 172.17.40.23:6807/13607 pipe(0x7fd41c033c20 sd=120 pgs=77 cs=1 l=0).fault 0: Success
> osd.68.log-256183-2011-02-17 15:45:15.916480 7fd415595940 -- 172.17.40.29:6813/12558 >> 172.17.40.23:6807/13607 pipe(0x7fd41c033c20 sd=120 pgs=77 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256184-2011-02-17 15:45:15.918620 7fd4197d7940 -- 172.17.40.29:6814/12558 >> 172.17.40.24:6823/12076 pipe(0xcafc20 sd=45 pgs=94 cs=1 l=0).fault 0: Success
> osd.68.log-256185-2011-02-17 15:45:15.920192 7fd4197d7940 -- 172.17.40.29:6814/12558 >> 172.17.40.24:6823/12076 pipe(0xcafc20 sd=45 pgs=94 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256186-2011-02-17 15:45:15.920214 7fd41aaea940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6807/12993 pipe(0xdd4c20 sd=35 pgs=54 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256187-2011-02-17 15:45:15.920234 7fd41aaea940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6807/12993 pipe(0xdd4c20 sd=35 pgs=54 cs=1 l=0).fault 0: Success
> osd.68.log-256188-2011-02-17 15:45:15.920254 7fd41aaea940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6807/12993 pipe(0xdd4c20 sd=35 pgs=54 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256189-2011-02-17 15:45:15.920276 7fd40ca0a940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6808/12636 pipe(0x7fd41c32ac20 sd=107 pgs=120 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256190-2011-02-17 15:45:15.920303 7fd40ca0a940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6808/12636 pipe(0x7fd41c32ac20 sd=107 pgs=120 cs=1 l=0).fault 0: Success
> osd.68.log-256191-2011-02-17 15:45:15.920323 7fd40ca0a940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6808/12636 pipe(0x7fd41c32ac20 sd=107 pgs=120 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256192-2011-02-17 15:45:15.924700 7fd4176b6940 -- 172.17.40.29:6813/12558 >> 172.17.40.25:6804/12657 pipe(0xee10c0 sd=61 pgs=61 cs=1 l=0).fault 0: Success
> osd.68.log-256193-2011-02-17 15:45:15.924802 7fd4176b6940 -- 172.17.40.29:6813/12558 >> 172.17.40.25:6804/12657 pipe(0xee10c0 sd=61 pgs=61 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256194-2011-02-17 15:45:15.924854 7fd412565940 -- 172.17.40.29:6813/12558 >> 172.17.40.31:6819/12848 pipe(0xd35b90 sd=101 pgs=58 cs=1 l=0).fault 0: Success
> osd.68.log-256195-2011-02-17 15:45:15.924875 7fd412565940 -- 172.17.40.29:6813/12558 >> 172.17.40.31:6819/12848 pipe(0xd35b90 sd=101 pgs=58 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256196-2011-02-17 15:45:15.925126 7fd4015d5940 -- 172.17.40.29:6812/12558 >> 172.17.40.50:0/2223503458 pipe(0xec9940 sd=185 pgs=40 cs=1 l=1).fault 0: Success
> osd.68.log-256197-2011-02-17 15:45:15.926469 7fd4171b1940 -- 172.17.40.29:6814/12558 >> 172.17.40.24:6817/11926 pipe(0xeef000 sd=64 pgs=84 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256198-2011-02-17 15:45:18.465361 7fd40b7f8940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6814/12798 pipe(0x7fd41c3c0d30 sd=152 pgs=116 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256199-2011-02-17 15:45:18.472367 7fd40b7f8940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6814/12798 pipe(0x7fd41c3c0d30 sd=152 pgs=116 cs=1 l=0).fault 0: Success
> osd.68.log-256200-2011-02-17 15:45:18.472401 7fd40b7f8940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6814/12798 pipe(0x7fd41c3c0d30 sd=152 pgs=116 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256201-2011-02-17 15:45:18.472450 7fd418fcf940 -- 172.17.40.29:6813/12558 >> 172.17.40.28:6810/12265 pipe(0xf1b050 sd=51 pgs=64 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256202-2011-02-17 15:45:18.472472 7fd418fcf940 -- 172.17.40.29:6813/12558 >> 172.17.40.28:6810/12265 pipe(0xf1b050 sd=51 pgs=64 cs=1 l=0).fault 0: Success
> osd.68.log-256203-2011-02-17 15:45:18.472523 7fd418fcf940 -- 172.17.40.29:6813/12558 >> 172.17.40.28:6810/12265 pipe(0xf1b050 sd=51 pgs=64 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256204-2011-02-17 15:45:18.472547 7fd411a5a940 -- 172.17.40.29:6814/12558 >> 172.17.40.28:6811/12265 pipe(0x7fd41c169cb0 sd=77 pgs=129 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256205-2011-02-17 15:45:18.472580 7fd411a5a940 -- 172.17.40.29:6814/12558 >> 172.17.40.28:6811/12265 pipe(0x7fd41c169cb0 sd=77 pgs=129 cs=1 l=0).fault 0: Success
> osd.68.log-256206-2011-02-17 15:45:18.472602 7fd411a5a940 -- 172.17.40.29:6814/12558 >> 172.17.40.28:6811/12265 pipe(0x7fd41c169cb0 sd=77 pgs=129 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256207-2011-02-17 15:45:18.472615 7fd40b9fa940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6823/13041 pipe(0x7fd41c1ceb60 sd=138 pgs=111 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256208-2011-02-17 15:45:18.474761 7fd40b9fa940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6823/13041 pipe(0x7fd41c1ceb60 sd=138 pgs=111 cs=1 l=0).fault 0: Success
> osd.68.log-256209-2011-02-17 15:45:18.474810 7fd40b9fa940 -- 172.17.40.29:6814/12558 >> 172.17.40.32:6823/13041 pipe(0x7fd41c1ceb60 sd=138 pgs=111 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256210-2011-02-17 15:45:18.477408 7fd42654e940 -- 172.17.40.29:6812/12558 <== client4240 172.17.40.73:0/3624355571 1 ==== osd_op(client4240.1:111 10000004e34.0000006e [write 0~4194304 [1@-1]] 0.a156 snapc 1=[]) ==== 128+0+4194304 (2756195295 0 0) 0xe43f80 con 0x7fd3fc001c00
> osd.68.log-256211-2011-02-17 15:45:18.479547 7fd413c7c940 -- 172.17.40.29:6814/12558 >> 172.17.40.27:6823/13093 pipe(0x7fd41c15fc30 sd=90 pgs=97 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256212-2011-02-17 15:45:18.479635 7fd40e626940 -- 172.17.40.29:6813/12558 >> 172.17.40.21:6804/11346 pipe(0x7fd41c13cc20 sd=113 pgs=72 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256213-2011-02-17 15:45:18.479736 7fd40e626940 -- 172.17.40.29:6813/12558 >> 172.17.40.21:6804/11346 pipe(0x7fd41c13cc20 sd=113 pgs=72 cs=1 l=0).fault 0: Success
> osd.68.log-256214-2011-02-17 15:45:18.479759 7fd40e626940 -- 172.17.40.29:6813/12558 >> 172.17.40.21:6804/11346 pipe(0x7fd41c13cc20 sd=113 pgs=72 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256215-2011-02-17 15:45:18.479776 7fd420d3c940 -- 172.17.40.29:6813/12558 >> 172.17.40.21:6807/11429 pipe(0xc63870 sd=17 pgs=4 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256216-2011-02-17 15:45:18.479805 7fd420d3c940 -- 172.17.40.29:6813/12558 >> 172.17.40.21:6807/11429 pipe(0xc63870 sd=17 pgs=4 cs=1 l=0).fault 0: Success
> osd.68.log-256217-2011-02-17 15:45:18.479827 7fd420d3c940 -- 172.17.40.29:6813/12558 >> 172.17.40.21:6807/11429 pipe(0xc63870 sd=17 pgs=4 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256218-2011-02-17 15:45:18.479846 7fd419cdc940 -- 172.17.40.29:6813/12558 >> 172.17.40.31:6822/12924 pipe(0xe8fc20 sd=42 pgs=58 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256219-2011-02-17 15:45:18.479867 7fd419cdc940 -- 172.17.40.29:6813/12558 >> 172.17.40.31:6822/12924 pipe(0xe8fc20 sd=42 pgs=58 cs=1 l=0).fault 0: Success
> osd.68.log-256220-2011-02-17 15:45:18.479898 7fd419cdc940 -- 172.17.40.29:6813/12558 >> 172.17.40.31:6822/12924 pipe(0xe8fc20 sd=42 pgs=58 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256221-2011-02-17 15:45:18.479915 7fd40f333940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6819/13310 pipe(0x7fd41c007c20 sd=117 pgs=75 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256222-2011-02-17 15:45:18.479936 7fd40f333940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6819/13310 pipe(0x7fd41c007c20 sd=117 pgs=75 cs=1 l=0).fault 0: Success
> osd.68.log-256223-2011-02-17 15:45:18.479955 7fd40f333940 -- 172.17.40.29:6813/12558 >> 172.17.40.22:6819/13310 pipe(0x7fd41c007c20 sd=117 pgs=75 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256224-2011-02-17 15:45:18.479973 7fd41a2e2940 -- 172.17.40.29:6813/12558 >> 172.17.40.24:6804/11594 pipe(0x7fd41c154c20 sd=122 pgs=71 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256225-2011-02-17 15:45:18.480025 7fd41a2e2940 -- 172.17.40.29:6813/12558 >> 172.17.40.24:6804/11594 pipe(0x7fd41c154c20 sd=122 pgs=71 cs=1 l=0).fault 0: Success
> osd.68.log-256226-2011-02-17 15:45:18.480044 7fd41a2e2940 -- 172.17.40.29:6813/12558 >> 172.17.40.24:6804/11594 pipe(0x7fd41c154c20 sd=122 pgs=71 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256227-2011-02-17 15:45:18.480074 7fd40d212940 -- 172.17.40.29:6814/12558 >> 172.17.40.31:6823/12924 pipe(0x7fd41c3fcc30 sd=104 pgs=120 cs=1 l=0).reader couldn't read tag, Success
> osd.68.log-256228-2011-02-17 15:45:18.480107 7fd40d212940 -- 172.17.40.29:6814/12558 >> 172.17.40.31:6823/12924 pipe(0x7fd41c3fcc30 sd=104 pgs=120 cs=1 l=0).fault 0: Success
> osd.68.log-256229-2011-02-17 15:45:18.480127 7fd40d212940 -- 172.17.40.29:6814/12558 >> 172.17.40.31:6823/12924 pipe(0x7fd41c3fcc30 sd=104 pgs=120 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256230-2011-02-17 15:45:18.480154 7fd427550940 osd68 5 pg[0.7fc( v 5'1 (0'0,5'1] n=1 ec=2 les=4 3/3/3) [3,68] r=1 luod=0'0 lcod 0'0 active] sub_op_modify_applied on 0x7fd404067010 op osd_sub_op(client4258.1:35 0.7fc 10000008109.00000022/head [] v 5'1 snapset=0=[]:[] snapc=0=[]) v3
> osd.68.log-256231-2011-02-17 15:45:18.480271 7fd427550940 osd68 5 pg[0.680( v 5'1 (0'0,5'1] n=1 ec=2 les=4 3/3/3) [90,68] r=1 luod=0'0 lcod 0'0 active] sub_op_modify_applied on 0x7fd404031e40 op osd_sub_op(client4224.1:33 0.680 1000000ac0c.00000020/head [] v 5'1 snapset=0=[]:[] snapc=0=[]) v3
> osd.68.log-256232-2011-02-17 15:45:18.480310 7fd427550940 osd68 5 pg[0.588( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,27] r=0 mlcod 0'0 active+clean] op_applied repgather(0x7fd3fc0eb480 applying 5'2 rep_tid=174 wfack=27,68 wfdisk=27 op=osd_op(client4244.1:126 1000000dee1.0000007d [write 0~4194304 [1@-1]] 0.588 snapc 1=[]))
> osd.68.log-256233-2011-02-17 15:45:18.480356 7fd427550940 osd68 5 pg[0.588( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,27] r=0 mlcod 0'0 active+clean] op_applied mode was rmw(wr=1)
> osd.68.log-256234-2011-02-17 15:45:18.480371 7fd427550940 osd68 5 pg[0.588( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,27] r=0 mlcod 0'0 active+clean] op_applied mode now idle(wr=0 WAKE) (finish_write)
> osd.68.log-256235-2011-02-17 15:45:18.480384 7fd427550940 osd68 5 pg[0.588( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,27] r=0 mlcod 0'0 active+clean] put_object_context 1000000dee1.0000007d/head 1 -> 0
> osd.68.log-256236-2011-02-17 15:45:18.480399 7fd427550940 osd68 5 pg[0.588( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,27] r=0 mlcod 0'0 active+clean] put_snapset_context 1000000dee1.0000007d 1 -> 0
> osd.68.log-256237-2011-02-17 15:45:18.480435 7fd427550940 osd68 5 pg[0.588( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,27] r=0 mlcod 0'0 active+clean] update_stats 3'13
> osd.68.log-256238-2011-02-17 15:45:18.480451 7fd427550940 osd68 5 pg[0.588( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,27] r=0 mlcod 0'0 active+clean] eval_repop repgather(0x7fd3fc0eb480 applied 5'2 rep_tid=174 wfack=27 wfdisk=27 op=osd_op(client4244.1:126 1000000dee1.0000007d [write 0~4194304 [1@-1]] 0.588 snapc 1=[])) wants=d
> osd.68.log-256239-2011-02-17 15:45:18.480471 7fd427550940 osd68 5 pg[0.b03( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,31] r=0 mlcod 0'0 active+clean] op_applied repgather(0x7fd404013bf0 applying 5'2 rep_tid=175 wfack=31,68 wfdisk=31 op=osd_op(client4220.1:59 1000000ea9c.0000003a [write 0~4194304 [1@-1]] 0.cb03 snapc 1=[]))
> osd.68.log-256240-2011-02-17 15:45:18.480497 7fd427550940 osd68 5 pg[0.b03( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,31] r=0 mlcod 0'0 active+clean] op_applied mode was rmw(wr=1)
> osd.68.log-256241-2011-02-17 15:45:18.480510 7fd427550940 osd68 5 pg[0.b03( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,31] r=0 mlcod 0'0 active+clean] op_applied mode now idle(wr=0 WAKE) (finish_write)
> osd.68.log-256242-2011-02-17 15:45:18.480523 7fd427550940 osd68 5 pg[0.b03( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,31] r=0 mlcod 0'0 active+clean] put_object_context 1000000ea9c.0000003a/head 1 -> 0
> osd.68.log-256243-2011-02-17 15:45:18.480536 7fd427550940 osd68 5 pg[0.b03( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,31] r=0 mlcod 0'0 active+clean] put_snapset_context 1000000ea9c.0000003a 1 -> 0
> osd.68.log-256244-2011-02-17 15:45:18.480555 7fd427550940 osd68 5 pg[0.b03( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,31] r=0 mlcod 0'0 active+clean] update_stats 3'13
> osd.68.log-256245-2011-02-17 15:45:18.480593 7fd427550940 osd68 5 pg[0.b03( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,31] r=0 mlcod 0'0 active+clean] eval_repop repgather(0x7fd404013bf0 applied 5'2 rep_tid=175 wfack=31 wfdisk=31 op=osd_op(client4220.1:59 1000000ea9c.0000003a [write 0~4194304 [1@-1]] 0.cb03 snapc 1=[])) wants=d
> osd.68.log-256246-2011-02-17 15:45:18.480612 7fd427550940 osd68 5 pg[0.b45( v 5'1 (0'0,5'1] n=1 ec=2 les=4 3/3/3) [76,68] r=1 luod=0'0 lcod 0'0 active] sub_op_modify_applied on 0x7fd3fc031200 op osd_sub_op(client4221.1:17 0.b45 1000000aff5.00000010/head [] v 5'1 snapset=0=[]:[] snapc=0=[]) v3
> osd.68.log-256247-2011-02-17 15:45:18.480652 7fd427550940 osd68 5 pg[0.bcb( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,55] r=0 mlcod 0'0 active+clean] op_applied repgather(0x7fd404021370 applying 5'2 rep_tid=176 wfack=55,68 wfdisk=55 op=osd_op(client4246.1:15 10000007165.0000000e [write 0~4194304 [1@-1]] 0.4bcb snapc 1=[]))
> osd.68.log-256248-2011-02-17 15:45:18.480681 7fd427550940 osd68 5 pg[0.bcb( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,55] r=0 mlcod 0'0 active+clean] op_applied mode was rmw(wr=1)
> osd.68.log-256249-2011-02-17 15:45:18.480694 7fd427550940 osd68 5 pg[0.bcb( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,55] r=0 mlcod 0'0 active+clean] op_applied mode now idle(wr=0 WAKE) (finish_write)
> osd.68.log-256250-2011-02-17 15:45:18.480706 7fd427550940 osd68 5 pg[0.bcb( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,55] r=0 mlcod 0'0 active+clean] put_object_context 10000007165.0000000e/head 1 -> 0
> osd.68.log-256251-2011-02-17 15:45:18.480719 7fd427550940 osd68 5 pg[0.bcb( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,55] r=0 mlcod 0'0 active+clean] put_snapset_context 10000007165.0000000e 1 -> 0
> osd.68.log-256252-2011-02-17 15:45:18.480738 7fd427550940 osd68 5 pg[0.bcb( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,55] r=0 mlcod 0'0 active+clean] update_stats 3'13
> osd.68.log-256253-2011-02-17 15:45:18.480752 7fd427550940 osd68 5 pg[0.bcb( v 5'2 (0'0,5'2] n=2 ec=2 les=4 3/3/3) [68,55] r=0 mlcod 0'0 active+clean] eval_repop repgather(0x7fd404021370 applied 5'2 rep_tid=176 wfack=55 wfdisk=55 op=osd_op(client4246.1:15 10000007165.0000000e [write 0~4194304 [1@-1]] 0.4bcb snapc 1=[])) wants=d
> osd.68.log-256254-2011-02-17 15:45:18.480770 7fd427550940 osd68 5 pg[0.36b( v 5'1 (0'0,5'1] n=1 ec=2 les=4 3/3/3) [21,68] r=1 luod=0'0 lcod 0'0 active] sub_op_modify_applied on 0x7fd3fc0a9050 op osd_sub_op(client4213.1:82 0.36b 10000005dd8.00000051/head [] v 5'1 snapset=0=[]:[] snapc=0=[]) v3
> osd.68.log-256255-2011-02-17 15:45:18.480811 7fd427550940 osd68 5 pg[0.38d( v 5'1 (0'0,5'1] n=1 ec=2 les=4 3/3/3) [5,68] r=1 luod=0'0 lcod 0'0 active] sub_op_modify_applied on 0x7fd40403f770 op osd_sub_op(client4256.1:52 0.38d 1000000b7c7.00000033/head [] v 5'1 snapset=0=[]:[] snapc=0=[]) v3
> osd.68.log-256256-2011-02-17 15:45:18.480901 7fd40db1b940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6820/13310 pipe(0xf5dc30 sd=133 pgs=123 cs=1 l=0).reader couldn't read tag, Transport endpoint is not connected
> osd.68.log-256257-2011-02-17 15:45:18.480929 7fd40db1b940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6820/13310 pipe(0xf5dc30 sd=133 pgs=123 cs=1 l=0).fault 107: Transport endpoint is not connected
> osd.68.log-256258-2011-02-17 15:45:18.480949 7fd40db1b940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6820/13310 pipe(0xf5dc30 sd=133 pgs=123 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256259-2011-02-17 15:45:18.481001 7fd4167a7940 -- 172.17.40.29:6814/12558 >> 172.17.40.26:6805/11056 pipe(0xf06700 sd=68 pgs=90 cs=1 l=0).fault 0: Success
> osd.68.log-256260-2011-02-17 15:45:18.481037 7fd4167a7940 -- 172.17.40.29:6814/12558 >> 172.17.40.26:6805/11056 pipe(0xf06700 sd=68 pgs=90 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256261-2011-02-17 15:45:18.481059 7fd413979940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6817/13237 pipe(0x7fd41c1fcc00 sd=34 pgs=124 cs=1 l=0).fault 0: Success
> osd.68.log-256262-2011-02-17 15:45:18.481085 7fd413979940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6817/13237 pipe(0x7fd41c1fcc00 sd=34 pgs=124 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256263-2011-02-17 15:45:18.481107 7fd40d919940 -- 172.17.40.29:6814/12558 >> 172.17.40.21:6823/11833 pipe(0x7fd41c37cc20 sd=146 pgs=116 cs=1 l=0).fault 0: Success
> osd.68.log-256264-2011-02-17 15:45:18.481139 7fd40d919940 -- 172.17.40.29:6814/12558 >> 172.17.40.21:6823/11833 pipe(0x7fd41c37cc20 sd=146 pgs=116 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256265-2011-02-17 15:45:18.481174 7fd4182c2940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6802/12830 pipe(0xebaaf0 sd=56 pgs=94 cs=1 l=0).fault 0: Success
> osd.68.log-256266-2011-02-17 15:45:18.481207 7fd4182c2940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6802/12830 pipe(0xebaaf0 sd=56 pgs=94 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256267-2011-02-17 15:45:18.481228 7fd41b3f3940 -- 172.17.40.29:6814/12558 >> 172.17.40.25:6802/12569 pipe(0xd2bd50 sd=30 pgs=87 cs=1 l=0).fault 0: Success
> osd.68.log-256268-2011-02-17 15:45:18.481262 7fd41b3f3940 -- 172.17.40.29:6814/12558 >> 172.17.40.25:6802/12569 pipe(0xd2bd50 sd=30 pgs=87 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256269-2011-02-17 15:45:18.481284 7fd41a4e4940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6811/13703 pipe(0xe40d50 sd=39 pgs=89 cs=1 l=0).fault 0: Success
> osd.68.log-256270-2011-02-17 15:45:18.481316 7fd41a4e4940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6811/13703 pipe(0xe40d50 sd=39 pgs=89 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256271-2011-02-17 15:45:18.481337 7fd4194d4940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6808/13607 pipe(0x7fd41c1f6be0 sd=26 pgs=134 cs=1 l=0).fault 0: Success
> osd.68.log-256272-2011-02-17 15:45:18.481372 7fd4194d4940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6808/13607 pipe(0x7fd41c1f6be0 sd=26 pgs=134 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256273-2011-02-17 15:45:18.481393 7fd414282940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6811/13069 pipe(0x7fd41c053c20 sd=88 pgs=97 cs=1 l=0).fault 0: Success
> osd.68.log-256274-2011-02-17 15:45:18.481426 7fd414282940 -- 172.17.40.29:6814/12558 >> 172.17.40.22:6811/13069 pipe(0x7fd41c053c20 sd=88 pgs=97 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256275-2011-02-17 15:45:18.481591 7fd412767940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6823/14021 pipe(0x7fd41c1b7c30 sd=100 pgs=87 cs=1 l=0).fault 0: Success
> osd.68.log-256276-2011-02-17 15:45:18.481633 7fd412767940 -- 172.17.40.29:6814/12558 >> 172.17.40.23:6823/14021 pipe(0x7fd41c1b7c30 sd=100 pgs=87 cs=1 l=0).fault with nothing to send, going to standby
> osd.68.log-256277-2011-02-17 15:45:18.481656 7fd42ad57940 osd68 5 tick checking dispatch queue status
> osd.68.log-256278-2011-02-17 15:45:18.481669 7fd42ad57940 osd68 5 tick done
> 
> 
> See anything useful in there?
> 
> Let me know if there's anything I can do to get you more information about this.
> 
> > 
> > Thanks for looking at this!
> 
> No problem :)
> 
> -- Jim
> 
> > sage
> > 
> > 
> > 
> > > 
> > > -- Jim
> > > 
> > > > 
> > > > sage
> > > > 
> > > 
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
