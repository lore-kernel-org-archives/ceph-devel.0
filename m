From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: writes-starving-reads problem
Date: Fri, 30 Jul 2010 17:40:11 +0800
Message-ID: <AANLkTimDmPzWMBHKmgkRoE5LHqWL3-6_=R+PxZokqxVN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42761 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381Ab0G3JkM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 05:40:12 -0400
Received: by pvc7 with SMTP id 7so443907pvc.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 02:40:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I ran into "writes-starving-reads" problem on a machine with 48G RAM.

I have two processes running concurrently:
Process 1 copies an 8 GB file from local disk to CEPH.
Process 2 copies an 8 GB file from CEPH to local disk.

Process 1 finished quickly since the data were cached in memory first.
Process 2 was blocked until all the cached data have been written to OSD.
(Maybe not all the cached data, but I waited for a long time.)

I don't have this problem on a machine with 8G RAM.

Has anyone experienced this before or any idea why?

Thanks,
Henry
