From: kefu chai <tchaikov@gmail.com>
Subject: etherpad for librados3
Date: Tue, 29 Nov 2016 15:21:37 +0800
Message-ID: <CAJE9aOPXfC1VW37KvH-DTg_4nfKC3xvC19kdrcNyxuSpwRM6mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33685 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbcK2HVj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Nov 2016 02:21:39 -0500
Received: by mail-qt0-f171.google.com with SMTP id p16so146601794qta.0
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2016 23:21:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi cephers,

i am collecting PRs got reverted or closed due to incompatibility (ABI
or souce level) with existing librados at
http://pad.ceph.com/p/librados3. so they won't get lost along the
time.

hopefully, we can pull them in when we decide to give an overhaul of
librados2 and bump up the soversion of it.

we can also use this page to note down the plan for the new librados3.


-- 
Regards
Kefu Chai
