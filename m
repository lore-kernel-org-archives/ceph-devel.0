From: huang jun <hjwsm1989@gmail.com>
Subject: fuse problem
Date: Thu, 19 May 2011 19:12:54 +0800
Message-ID: <BANLkTimJGtnfQPa4LkgbfKx5HZ7drG9u5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41159 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307Ab1ESLM4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2011 07:12:56 -0400
Received: by wwa36 with SMTP id 36so2756660wwa.1
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2011 04:12:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi, all
i just encountered a problem about cfuse:
i mount cfsue successfully on /mnt by using
   "cfuse -m 192.168.0.170:6789 /mnt"
but when i enter /mnt directory, it shows that:
   [root@localhost mnt]# ll
   ls: .: Transport endpoint is not connected
my cfuse client is on centos5, it kernel version is 2.6.18
and OSD cluster is on debian5, 2.6.35
i don't know whether it related to SimpleMessenger,so anyone can give
me some prompts?

thanks!
