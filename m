From: Paul Cuzner <pcuzner@redhat.com>
Subject: admin_socket question
Date: Wed, 6 Sep 2017 17:27:49 +1200
Message-ID: <CAO=rSOu+f9rcy=mTv0hk4PSDkyiphN5vJDnQ=nz+_RTfVNF7DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37104 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbdIFF1v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Sep 2017 01:27:51 -0400
Received: by mail-wm0-f41.google.com with SMTP id u26so26502243wma.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 Sep 2017 22:27:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

One of the users of cephmetrics has seen issues where the response to
perf dump requests against an osd seems to hang. (issue #91 -
https://github.com/ceph/cephmetrics/issues/91)

When I looked at the admin_command function in ceph[1], it looks to me
that the socket interaction is defaulting to blocking mode? So if
there is a delay in responding, the caller will see this hanging
behaviour that was described in the issue.

If blocking mode is being used, can anyone explain why this is
preferred over a non-blocking approach with 'select'?

Cheers,

Paul C

[1] https://github.com/ceph/ceph/blob/master/src/pybind/ceph_daemon.py
