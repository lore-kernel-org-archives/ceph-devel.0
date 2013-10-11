From: "hjwsm1989-gmail" <hjwsm1989@gmail.com>
Subject: can't stop ceph(v0.69) osd daemon on ubuntu13.04
Date: Fri, 11 Oct 2013 18:14:27 +0800
Message-ID: <01fb01cec66a$af6d1e00$0e475a00$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42371 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab3JKKOj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Oct 2013 06:14:39 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so4013655pdi.13
        for <ceph-devel@vger.kernel.org>; Fri, 11 Oct 2013 03:14:37 -0700 (PDT)
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,all

We can't stop osd daemon on Ubuntu 13.04 by using "/ect/init.d/ceph stop
osd",

After debug by bashdb, we found that after setup the osd daemon, the pid
file on /var/run/ceph/osd.N.pid doesn't exists.

Then try to stop osd by "kill pid-of-osd", the osd daemon was killed but
then start again.


Thanks!



