From: Robert LeBlanc <robert@leblancnet.us>
Subject: Where is the systemd files?
Date: Thu, 26 Mar 2015 23:13:37 -0600
Message-ID: <CAANLjFoVm7a7e2Mbx-OruUCaMSYpOFpES_N_vfUP9-AbS8vcwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36630 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbC0FNi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 01:13:38 -0400
Received: by wibg7 with SMTP id g7so13405567wib.1
        for <ceph-devel@vger.kernel.org>; Thu, 26 Mar 2015 22:13:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

I understand that Giant should have systemd service files, but I don't
see them in the CentOS 7 packages.

https://github.com/ceph/ceph/tree/giant/systemd

[ulhglive-root@mon1 systemd]# rpm -qa | grep --color=always ceph
ceph-common-0.93-0.el7.centos.x86_64
python-cephfs-0.93-0.el7.centos.x86_64
libcephfs1-0.93-0.el7.centos.x86_64
ceph-0.93-0.el7.centos.x86_64
ceph-deploy-1.5.22-0.noarch
[ulhglive-root@mon1 systemd]# for i in $(rpm -qa | grep ceph); do rpm
-ql $i | grep -i --color=always systemd; done
[nothing returned]

Thanks,
Robert LeBlanc
