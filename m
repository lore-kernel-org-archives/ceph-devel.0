From: Willem Jan Withagen <wjw@digiware.nl>
Subject: OSD not coming back up again
Date: Thu, 11 Aug 2016 02:40:45 +0200
Message-ID: <bdb93e87-8338-e485-a68d-f988d00f6785@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:20029 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbcHKAkx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Aug 2016 20:40:53 -0400
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 0970A253BE
	for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2016 02:40:47 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

During testing with cephtool-test-mon.sh

3 OSDs are started, and then the code executes:
====
  ceph osd set noup
  ceph osd down 0
  ceph osd dump | grep 'osd.0 down'
  ceph osd unset noup
====

And in 1000 secs osd.0 is not coming back up.

Below some details, but where should I start looking?

Thanx
--WjW


ceph -s gives:

    cluster 9b2500f8-44fb-40d1-91bc-ed522e9db5c6
     health HEALTH_WARN
            8 pgs degraded
            8 pgs stuck unclean
            8 pgs undersized
     monmap e1: 3 mons at
{a=127.0.0.1:7202/0,b=127.0.0.1:7203/0,c=127.0.0.1:7204/0}
            election epoch 6, quorum 0,1,2 a,b,c
     osdmap e179: 3 osds: 2 up, 2 in; 8 remapped pgs
            flags sortbitwise,require_jewel_osds,require_kraken_osds
      pgmap v384: 8 pgs, 1 pools, 0 bytes data, 0 objects
            248 GB used, 198 GB / 446 GB avail
                   8 active+undersized+degraded

And the pgmap version is slowly growing.....

This set of lines is repeated over and over in the osd.0.log

2016-08-11 02:31:48.710152 b2f4d00  1 -- 127.0.0.1:0/25528 -->
127.0.0.1:6806/25709 -- osd_ping(ping e175 stamp 2016-08-11
02:31:48.710144) v2 -- ?+0 0xb42bc00 con 0xb12ba40
2016-08-11 02:31:48.710188 b2f4d00  1 -- 127.0.0.1:0/25528 -->
127.0.0.1:6807/25709 -- osd_ping(ping e175 stamp 2016-08-11
02:31:48.710144) v2 -- ?+0 0xb42cc00 con 0xb12bb20
2016-08-11 02:31:48.710214 b2f4d00  1 -- 127.0.0.1:0/25528 -->
127.0.0.1:6810/25910 -- osd_ping(ping e175 stamp 2016-08-11
02:31:48.710144) v2 -- ?+0 0xb42a400 con 0xb12bc00
2016-08-11 02:31:48.710240 b2f4d00  1 -- 127.0.0.1:0/25528 -->
127.0.0.1:6811/25910 -- osd_ping(ping e175 stamp 2016-08-11
02:31:48.710144) v2 -- ?+0 0xb42c000 con 0xb12c140
2016-08-11 02:31:48.710604 b412480  1 -- 127.0.0.1:0/25528 <== osd.1
127.0.0.1:6806/25709 284 ==== osd_ping(ping_reply e179 stamp 2016-08-11
02:31:48.710144) v2 ==== 47+0+0 (281956571 0 0) 0xb42d800 con 0xb12ba40
2016-08-11 02:31:48.710665 b486900  1 -- 127.0.0.1:0/25528 <== osd.2
127.0.0.1:6810/25910 283 ==== osd_ping(ping_reply e179 stamp 2016-08-11
02:31:48.710144) v2 ==== 47+0+0 (281956571 0 0) 0xb42d200 con 0xb12bc00
2016-08-11 02:31:48.710683 b412480  1 -- 127.0.0.1:0/25528 <== osd.1
127.0.0.1:6806/25709 285 ==== osd_ping(you_died e179 stamp 2016-08-11
02:31:48.710144) v2 ==== 47+0+0 (1545205378 0 0) 0xb42d800 con 0xb12ba40
2016-08-11 02:31:48.710780 b412000  1 -- 127.0.0.1:0/25528 <== osd.1
127.0.0.1:6807/25709 284 ==== osd_ping(ping_reply e179 stamp 2016-08-11
02:31:48.710144) v2 ==== 47+0+0 (281956571 0 0) 0xb42da00 con 0xb12bb20
2016-08-11 02:31:48.710789 b486900  1 -- 127.0.0.1:0/25528 <== osd.2
127.0.0.1:6810/25910 284 ==== osd_ping(you_died e179 stamp 2016-08-11
02:31:48.710144) v2 ==== 47+0+0 (1545205378 0 0) 0xb42d200 con 0xb12bc00
2016-08-11 02:31:48.710821 b486d80  1 -- 127.0.0.1:0/25528 <== osd.2
127.0.0.1:6811/25910 283 ==== osd_ping(ping_reply e179 stamp 2016-08-11
02:31:48.710144) v2 ==== 47+0+0 (281956571 0 0) 0xb42d400 con 0xb12c140
2016-08-11 02:31:48.710973 b412000  1 -- 127.0.0.1:0/25528 <== osd.1
127.0.0.1:6807/25709 285 ==== osd_ping(you_died e179 stamp 2016-08-11
02:31:48.710144) v2 ==== 47+0+0 (1545205378 0 0) 0xb42da00 con 0xb12bb20
2016-08-11 02:31:48.711028 b486d80  1 -- 127.0.0.1:0/25528 <== osd.2
127.0.0.1:6811/25910 284 ==== osd_ping(you_died e179 stamp 2016-08-11
02:31:48.710144) v2 ==== 47+0+0 (1545205378 0 0) 0xb42d400 con 0xb12c140
