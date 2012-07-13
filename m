From: Andrey Korolyov <andrey@xdel.ru>
Subject: ceph status reporting non-existing osd
Date: Fri, 13 Jul 2012 12:17:47 +0400
Message-ID: <4FFFD9AB.40608@xdel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60879 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab2GMIRz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 04:17:55 -0400
Received: by lbbgm6 with SMTP id gm6so5459652lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 01:17:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Recently I`ve reduced my test suite from 6 to 4 osds at ~60% usage on
six-node,
and I have removed a bunch of rbd objects during recovery to avoid
overfill.
Right now I`m constantly receiving a warn about nearfull state on
non-existing osd:

   health HEALTH_WARN 1 near full osd(s)
   monmap e3: 3 mons at
{0=192.168.10.129:6789/0,1=192.168.10.128:6789/0,2=192.168.10.127:6789/0},
election epoch 240, quorum 0,1,2 0,1,2
   osdmap e2098: 4 osds: 4 up, 4 in
    pgmap v518696: 464 pgs: 464 active+clean; 61070 MB data, 181 GB
used, 143 GB / 324 GB avail
   mdsmap e181: 1/1/1 up {0=a=up:active}

HEALTH_WARN 1 near full osd(s)
osd.4 is near full at 89%

Needless to say, osd.4 remains only in ceph.conf, but not at crushmap.
Reducing has been done 'on-line', e.g. without restart entire cluster.
