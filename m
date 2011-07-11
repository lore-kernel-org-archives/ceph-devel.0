From: Damien Churchill <damoxc@gmail.com>
Subject: Support for {fa,i}notify
Date: Mon, 11 Jul 2011 13:15:28 +0100
Message-ID: <CAFtEh-fEDJq++32EKMQdaFVXJk050eY59Hj_vxjqHosSDAZ3Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36053 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab1GKMP3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2011 08:15:29 -0400
Received: by gxk21 with SMTP id 21so1438619gxk.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2011 05:15:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I was wondering if there is plans for (or already is support for)
inotify or fanotify when using the Ceph filesystem? In my tests it
seemed to work okay locally but there weren't any notifications to
another machine in the cluster.

Regards,
Damien
