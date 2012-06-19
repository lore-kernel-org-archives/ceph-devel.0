From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal, normal behaviour ?
Date: Tue, 19 Jun 2012 09:09:58 +0200 (CEST)
Message-ID: <2709e9e7-eed5-49c4-b7d2-9b0c7b0b9c3c@mailpro>
References: <4FDF4641.4070405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:51940 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab2FSHKV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 03:10:21 -0400
In-Reply-To: <4FDF4641.4070405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi, more infos, I have active filestore debug = 20, min interval 29 and max interval 30. 

I see sync_entry each 30s, so it seem work as expected.

cat ceph-osd.0.log |grep sync_entry 
2012-06-19 07:56:00.084622 7fd09233b700 20 filestore(/srv/osd.0) sync_entry woke after 26.550294 
2012-06-19 07:56:00.084641 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for another 2.449706 to reach min interval 29.000000 
2012-06-19 07:56:02.534432 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committing 18717 sync_epoch 5 
2012-06-19 07:56:02.534481 7fd09233b700 15 filestore(/srv/osd.0) sync_entry doing a full sync (syncfs(2) if possible) 
2012-06-19 07:56:02.963302 7fd09233b700 10 filestore(/srv/osd.0) sync_entry commit took 0.428878, interval was 29.428974 
2012-06-19 07:56:02.963332 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committed to op_seq 18717 
2012-06-19 07:56:02.963341 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for max_interval 30.000000 
2012-06-19 07:56:12.066002 7fd09233b700 20 filestore(/srv/osd.0) sync_entry woke after 9.102662 
2012-06-19 07:56:12.066024 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for another 19.897338 to reach min interval 29.000000 
2012-06-19 07:56:31.963460 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committing 18935 sync_epoch 6 
2012-06-19 07:56:31.963510 7fd09233b700 15 filestore(/srv/osd.0) sync_entry doing a full sync (syncfs(2) if possible) 
2012-06-19 07:56:32.279737 7fd09233b700 10 filestore(/srv/osd.0) sync_entry commit took 0.316285, interval was 29.316396 
2012-06-19 07:56:32.279778 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committed to op_seq 18935 
2012-06-19 07:56:32.279786 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for max_interval 30.000000 
2012-06-19 07:56:44.837731 7fd09233b700 20 filestore(/srv/osd.0) sync_entry woke after 12.557945 
2012-06-19 07:56:44.837757 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for another 16.442055 to reach min interval 29.000000 
2012-06-19 07:57:01.279894 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committing 19125 sync_epoch 7 
2012-06-19 07:57:01.279939 7fd09233b700 15 filestore(/srv/osd.0) sync_entry doing a full sync (syncfs(2) if possible) 
2012-06-19 07:57:01.558240 7fd09233b700 10 filestore(/srv/osd.0) sync_entry commit took 0.278354, interval was 29.278455 
2012-06-19 07:57:01.558282 7fd09233b700 15 filestore(/srv/osd.0) sync_entry committed to op_seq 19125 
2012-06-19 07:57:01.558291 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for max_interval 30.000000 
2012-06-19 07:57:31.558394 7fd09233b700 20 filestore(/srv/osd.0) sync_entry woke after 30.000104 
2012-06-19 07:57:31.558414 7fd09233b700 20 filestore(/srv/osd.0) sync_entry waiting for max_interval 30.000000 


But during all the time of the bench, I have flusher_entry logs. 
What is exactly flush_entry vs sync_entry? 

full osd0.log is available here:

http:/odisoweb1.odiso.net/ceph-osd.0.log


cat ceph-osd.0.log |grep flush

2012-06-19 07:55:51.380114 7fd08fb36700 10 filestore(/srv/osd.0) queue_flusher ep 4 fd 35 5185~126 qlen 1 
2012-06-19 07:55:51.380153 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry awoke 
2012-06-19 07:55:51.380177 7fd08f335700 10 filestore(/srv/osd.0) flusher_entry flushing+closing 35 ep 4 
2012-06-19 07:55:51.380241 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry sleeping 
2012-06-19 07:55:51.380477 7fd08fb36700 10 filestore(/srv/osd.0) queue_flusher ep 4 fd 35 0~8 qlen 1 
2012-06-19 07:55:51.380489 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry awoke 
2012-06-19 07:55:51.380495 7fd08f335700 10 filestore(/srv/osd.0) flusher_entry flushing+closing 35 ep 4 
2012-06-19 07:55:51.380744 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry sleeping 
2012-06-19 07:55:51.386321 7fd08fb36700 10 filestore(/srv/osd.0) queue_flusher ep 4 fd 36 0~4194304 qlen 1 
2012-06-19 07:55:51.386375 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry awoke 
2012-06-19 07:55:51.386381 7fd08f335700 10 filestore(/srv/osd.0) flusher_entry flushing+closing 36 ep 4 
2012-06-19 07:55:51.387645 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry sleeping 
2012-06-19 07:55:51.534692 7fd090337700 10 filestore(/srv/osd.0) queue_flusher ep 4 fd 35 4270~126 qlen 1 
2012-06-19 07:55:51.534711 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry awoke 
2012-06-19 07:55:51.534716 7fd08f335700 10 filestore(/srv/osd.0) flusher_entry flushing+closing 35 ep 4 
2012-06-19 07:55:51.534749 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry sleeping 
2012-06-19 07:55:51.535012 7fd090337700 10 filestore(/srv/osd.0) queue_flusher ep 4 fd 35 0~8 qlen 1 
2012-06-19 07:55:51.535024 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry awoke 
2012-06-19 07:55:51.535031 7fd08f335700 10 filestore(/srv/osd.0) flusher_entry flushing+closing 35 ep 4 
2012-06-19 07:55:51.535150 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry sleeping 
2012-06-19 07:55:51.541146 7fd090337700 10 filestore(/srv/osd.0) queue_flusher ep 4 fd 36 0~4194304 qlen 1 
2012-06-19 07:55:51.541188 7fd08f335700 20 filestore(/srv/osd.0) flusher_entry awoke 
... 
... 
