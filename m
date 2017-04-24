From: John Spray <jspray@redhat.com>
Subject: Storing NFS (ganesha) HA state in Ceph
Date: Mon, 24 Apr 2017 14:17:23 +0100
Message-ID: <CALe9h7cyD6r+0ed0r49jR-4BZhk7dxoe6ngUcqVMhH6kCo+vgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37364 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170832AbdDXNRp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Apr 2017 09:17:45 -0400
Received: by mail-wm0-f48.google.com with SMTP id m123so67336207wma.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Apr 2017 06:17:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Interesting ganesha patch (not by me) here:
https://review.gerrithub.io/#/c/355070/

My review is suggesting that ganesha should store its client state in
RADOS objects rather than the mon, but others may have opinions as
well...

John
