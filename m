From: Qian Wei <hzqianwei@gmail.com>
Subject: Can't creat file on client
Date: Mon, 28 Feb 2011 21:41:10 +0800
Message-ID: <AANLkTimjVL0t6ayQJWp1suwS25fW9pf3dcL3ESc_kyDo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38699 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1B1NlL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Feb 2011 08:41:11 -0500
Received: by vxi39 with SMTP id 39so3092823vxi.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Feb 2011 05:41:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Recently,I install ceph on to two fedoras on vmware,
one for install ceph_client
one for install ceph_mon&mds&osd
altough successfully done : mount -t ceph /mnt/ceph root@ceph_mon&mds&osd
and input df -h ,I can see the mount ceph device,
but while I input command:
$touch /mnt/ceph/abc
then returned error: touch: cannot touch `abc': Permission denied
Is there anyone can help me resolve the problem?
