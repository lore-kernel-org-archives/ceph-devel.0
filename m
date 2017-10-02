From: Mauricio Garavaglia <mauricio@medallia.com>
Subject: break_lock in librbd API without blacklisting client
Date: Mon, 2 Oct 2017 14:28:13 -0300
Message-ID: <CAAVaRixW--NfN6a65xj7ekNGhbc+ZT7VMBdXVGtOgCaFxnesgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:49570 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdJBR2p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 13:28:45 -0400
Received: by mail-wm0-f42.google.com with SMTP id b189so8107880wmd.4
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 10:28:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,
What's the correct way to use break_lock in the python/golang bindings
without blacklisting the client?
This can be done in the rbd cli using
--rbd_blacklist_on_break_lock=false but I can't find a way to do it
with the api.
Thanks
