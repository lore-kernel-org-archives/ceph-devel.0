From: "hjwsm1989-gmail" <hjwsm1989@gmail.com>
Subject: set mds message priority to MSG_PRIO_HIGH
Date: Sat, 19 Oct 2013 20:58:46 +0800
Message-ID: <004001ceccca$f7e0fba0$e7a2f2e0$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:39952 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab3JSM67 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Oct 2013 08:58:59 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so5813474pad.7
        for <ceph-devel@vger.kernel.org>; Sat, 19 Oct 2013 05:58:59 -0700 (PDT)
Received: from huangjun ([111.173.83.95])
        by mx.google.com with ESMTPSA id ry4sm11629046pab.4.2013.10.19.05.58.54
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Oct 2013 05:58:57 -0700 (PDT)
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, 
I'm testing ceph with samba.
I have 20 OSD nodes on 4 hosts
dy01:1MON, 5 OSDs, 1 samba server
dy02: 1MDS, 5OSDs, 1 samba server
dy03: 5 OSDs, 1 samba server
dy04:5 OSDs, 1 samba server
every samba server exports the ceph kclient mount point.

When I set 3 samba clients connect to a samba server(dy01), and each write a
single 18GB file, gets 110MB/s speed each.
But when I use 4 clients, the cluster will report 'slow request' msg, and
this time I list files in samba client dir, it gets stuck.
And the test tool reports frame losing.
For the list operation related to MDS, I think the MDS op messages should
have higher priority than clients op.
Have I understood correctly? 

thanks


