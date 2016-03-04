From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: ceph-mon - mon daemon issues
Date: Sat, 5 Mar 2016 00:18:10 +0530
Message-ID: <CANA9Uk5h16Nmzm3s4YirdCDn9fMcLV+O4H1X855+K5_xTQUy9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35479 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbcCDSsL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 13:48:11 -0500
Received: by mail-vk0-f46.google.com with SMTP id e6so62850090vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2016 10:48:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@ceph.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
I have couple of questions on ceph-mon with mon daemon:

Q1:   Working command:  /etc/init.d/ceph status mon
         Not working          : status ceph-mon id=node-13

       Why first command is working and why not the 2nd command nto working
====

status ceph-mon id=node-13
status: Unknown instance: ceph/node-13

node-13:~# /etc/init.d/ceph status mon
=== mon.node-13 ===
mon.node-13: running {"version":"0.80.7"}
===

Q2:

   In ceph-mon command running with --pid-file
   Not seen the --pid-file option in neither ceph doc or ceph-mon help?
   Why --pid-file option required? if it not passed what was the
default for this option?

===
node-13:~# ps -ef | grep ceph-mon

root     43508     1  1 18:31 ?        00:00:04 /usr/bin/ceph-mon -i
node-13 --pid-file /var/run/ceph/mon.node-13.pid -c
/etc/ceph/ceph.conf --cluster ceph
====
