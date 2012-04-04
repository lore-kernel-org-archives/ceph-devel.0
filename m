From: Damien Churchill <damoxc@gmail.com>
Subject: pgs stuck inactive
Date: Wed, 4 Apr 2012 09:12:09 +0100
Message-ID: <CAFtEh-dcEKQ2AzcVmu1G5i-zFHgim5SLZvEmNtDsvkHt+JnzLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43555 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab2DDIMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Apr 2012 04:12:10 -0400
Received: by gghe5 with SMTP id e5so8ggh.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Apr 2012 01:12:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm having some trouble getting some pgs to stop being inactive. The
cluster is running 0.44.1 and the kernel version is 3.2.x.

ceph -s reports:
2012-04-04 09:08:57.816029    pg v188540: 990 pgs: 223 inactive, 767
active+clean; 205 GB data, 1013 GB used, 8204 GB / 9315 GB avail
2012-04-04 09:08:57.817970   mds e2198: 1/1/1 up {0=node24=up:active},
4 up:standby
2012-04-04 09:08:57.818024   osd e5910: 5 osds: 5 up, 5 in
2012-04-04 09:08:57.818201   log 2012-04-04 09:04:03.838358 osd.3
172.22.10.24:6801/30000 159 : [INF] 0.13d scrub ok
2012-04-04 09:08:57.818280   mon e7: 3 mons at
{node21=172.22.10.21:6789/0,node22=172.22.10.22:6789/0,node23=172.22.10.23:6789/0}

ceph health says:
2012-04-04 09:09:01.651053 mon <- [health]
2012-04-04 09:09:01.666585 mon.1 -> 'HEALTH_WARN 223 pgs stuck
inactive; 223 pgs stuck unclean' (0)

I was wondering if anyone has any suggestions about how to resolve
this, or things to look for. I've tried restarted the ceph daemons on
the various nodes a few times to no-avail. I don't think that there is
anything wrong with any of the nodes either.

Thanks in advance,
Damien
