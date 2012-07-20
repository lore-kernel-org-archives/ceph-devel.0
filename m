From: George Shuklin <shuklin@selectel.ru>
Subject: Ceph write performance
Date: Fri, 20 Jul 2012 14:24:15 +0400
Message-ID: <500931CF.9040407@selectel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63942 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab2GTKYT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 06:24:19 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so4820033lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 03:24:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Good day.

I've start to play with Ceph... And I found some kinda strange 
performance issues. I'm not sure if this is due ceph limitation or my 
bad setup.

Setup:

osd - xfs on ramdisk (only one osd)
mds - raid0 on 10 disks
mon - second raid0 on 10 disks

I've mount ceph share at localhost and run FIO (randwrite, 4k, iodepth=32)

What I've got: 1900 IOPS on writing (4k block, 1Gb span).

Normally fio shows about 200kIOPS writing on ramdisk.

Why it was so slow? I've  done setup exactly like described here: 
http://ceph.com/docs/master/start/quick-start/#start-the-ceph-cluster 
(but one osd).

Thanks.
