From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: client isn't responding to mclientcaps
Date: Tue, 16 Jan 2018 17:06:25 +0800
Message-ID: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:37097 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeAPJG0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jan 2018 04:06:26 -0500
Received: by mail-oi0-f41.google.com with SMTP id e144so10136991oib.4
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 01:06:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, everyone.

In our online cephfs, we occasionally encounter the error "Client.
isn't responding to mclientcaps", the client kernel we are using is
centos's "3.10.0-514". Due to the massive deployment of our clients,
it's difficult to update kernels, which means we can not confirm
whether the error is the result of a relative older kernel or some
kind of unresolved bug. Is there any way that we can find all the
related bugs issued before? If we can, we believe it should be helpful
for us to locate the cause of the problem

Thanks:-)
