From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: rbdmap.service - which package?
Date: Thu, 6 Apr 2017 17:01:23 -0400
Message-ID: <CAGbviv+T5k6U62D9H0BJLdFQohVkwO+1WrGSPrKJQ1FAtppfyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:35698 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbdDFVBZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 17:01:25 -0400
Received: by mail-it0-f48.google.com with SMTP id y18so109059742itc.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Apr 2017 14:01:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Which package is the systemd script for rbdmap ("rbdmap.service")
supposed to be delivered in?

I have 10.2.6 installed and that particular service script is not
installed anywhere, the old sysv startup script (/etc/init.d/rbdmap)
is present, but the proper rbdmap.service is not.

Is this correct?

- Wyllys Ingersoll
  Keeper Technology
