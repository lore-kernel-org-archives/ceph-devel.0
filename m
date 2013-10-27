From: huang jun <hjwsm1989@gmail.com>
Subject: how to start daemons on remote host in ceph using upstart
Date: Sun, 27 Oct 2013 09:45:45 +0800
Message-ID: <CABAwU-akRV1o0keCEQnAV=5Y2S+9Rrb53L1B5R3t++2__mGkUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35338 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab3J0Bpq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Oct 2013 21:45:46 -0400
Received: by mail-lb0-f174.google.com with SMTP id q8so1813072lbi.5
        for <ceph-devel@vger.kernel.org>; Sat, 26 Oct 2013 18:45:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

After looking into the upstart, a few questions:
1) /etc/init.d/ceph and /etc/rc2.d/S20ceph still exist after installed the
ceph, , does this will conflict with the upstart? For the /etc/init/rc.conf
also in the /etc/init/.
2) how can I stop all daemons on different nodes in a single cluster? On
centos, we can use "/etc/init.d/ceph -a stop" to stopping remote daemons
3) what to do if I want to use sysvinit only on Ubuntu ? just move the files
/etc/init/ceph*?

Thanks!

-- 
thanks
huangjun
