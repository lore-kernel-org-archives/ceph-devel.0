From: Ning Yao <zay11022@gmail.com>
Subject: Object watcher can't be deleted when primary goes to down
Date: Thu, 7 Jul 2016 17:58:30 +0800
Message-ID: <CALZt5jzC-FxZqzF06pv5r_Ve6T1GCUuZFw7_YOrR8qzbHOL=FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34365 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbcGGJ6b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jul 2016 05:58:31 -0400
Received: by mail-qk0-f176.google.com with SMTP id t127so9844369qkf.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jul 2016 02:58:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

Currently, Object watcher just register timeout callback function
HandleWatchTimeout on primary OSD.
However, If primary OSD and rbd client becomes down at the time (If
virtual machine and ceph-osd is on the same physical server) ,  then
the replica OSD will leave the watcher there until the Object is
accessed and populate the watcher again. So eventually, if we want to
remove the unused image, it will return error saying image is still
busy because the watcher is still there.
Currently, if we want to find out the object containing watchers, we
need to scan all objects so that it is unreasonable to do that. But I
think it is reasonable to remove the watcher normally in this case,
otherwise client will get wrong information about whether the image is
busy. So we can record the watcher information in omap and retrieve
the information the cluster restart or something primary OSD is down?

Regards
Ning Yao
