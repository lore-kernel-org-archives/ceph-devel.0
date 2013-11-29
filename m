From: Ketor D <d.ketor@gmail.com>
Subject: [May be a bug?]Cannot umount cephfs after all mons is stopped
Date: Fri, 29 Nov 2013 13:51:51 +0800
Message-ID: <CAM9_UU9HeugRieJTbLQguCofhzVXNPvsys4nUbTqC79coG4BRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:36028 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab3K2FwW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Nov 2013 00:52:22 -0500
Received: by mail-la0-f46.google.com with SMTP id eh20so6427107lab.5
        for <ceph-devel@vger.kernel.org>; Thu, 28 Nov 2013 21:52:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage:
       We are testing cephfs mouting by kernel 3.12. And we meet a
situation that we cannot umount cephfs and also cannot reboot the
client machine. Only hard reset can restart the client machine.
        Here is the flow:
        1) Create a ceph cluster with 3 mons, 2 mds (active-standby), 2 osds.
        2) Mount the cephfs with linux kernel 3.12.
        3) Using service ceph stop mon.x to stop all mons.
        4) Then we cannot umount the cephfs. The command lsof and
fuser cannot return,and even if we use "umount -l [mount_point]",  we
only see the mount_point disappeared from /etc/mtab, but we still
cannot soft reboot the client machine.

        If we get in this situation, we can only hard reset the client
machine to avoid this.
        So the problem is if there is some method can gracefully
umount the cephfs and dont make the client machine cant rebooted?

         Regards!
