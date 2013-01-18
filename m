From: David Zafman <david.zafman@inktank.com>
Subject: master branch issue in ceph.git
Date: Thu, 17 Jan 2013 21:25:46 -0800
Message-ID: <FA14C3D4-D9E7-4F74-A39A-C05B68F9294D@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:61436 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab3ARFZt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 00:25:49 -0500
Received: by mail-oa0-f43.google.com with SMTP id k1so3472527oag.16
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 21:25:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


The latest code is hanging trying to start teuthology.  I used teuthology-nuke to clear old state and reboot the machines.  I was using my branch rebased to latest master and when that started failing I switched to the default config.  It still keeps hanging here:

INFO:teuthology.task.ceph:Waiting until ceph is healthy...

$ ceph -s
   health HEALTH_WARN 5 pgs degraded; 108 pgs stuck unclean
   monmap e1: 3 mons at {0=10.214.131.23:6789/0,1=10.214.131.21:6789/0,2=10.214.131.20:6789/0}, election epoch 6, quorum 0,1,2 0,1,2
   osdmap e7: 9 osds: 9 up, 9 in
    pgmap v25: 108 pgs: 103 active+remapped, 5 active+degraded; 0 bytes data, 798 GB used, 3050 GB / 4055 GB avail
   mdsmap e2: 0/0/0 up

David Zafman
Senior Developer
david.zafman@inktank.com



