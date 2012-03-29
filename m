From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: ceph-osd and ceph-mon
Date: Thu, 29 Mar 2012 14:40:25 +0200
Message-ID: <CAMvP8PCiyciY8keCKbmOzv+Ay+LY+oUfaTow37xMBKhKz7ik2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44939 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016Ab2C2Mkr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Mar 2012 08:40:47 -0400
Received: by gghe5 with SMTP id e5so1403054ggh.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Mar 2012 05:40:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'am working on improving security level for ceph (osd and mon). Are
there any specific consideratons to run ceph-osd and ceph-mon as non
root user with apparmor profile ?


-- 
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
