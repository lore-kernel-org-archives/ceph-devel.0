From: Warren Lobo <warrenlobo23@gmail.com>
Subject: Fwd: Query regarding stripe size in Ceph
Date: Sun, 25 Sep 2016 12:28:38 +0530
Message-ID: <CAMfR9XJOryB7ZCfMdps5p4fiNBuEeghGphCuPOPsFh4xow-FHQ@mail.gmail.com>
References: <CAMfR9X+C4Ya=Kq_rYY_eLXvecekNNyATaK95KTcEA-Lw_2rgYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f181.google.com ([209.85.213.181]:35246 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934317AbcIYG6j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Sep 2016 02:58:39 -0400
Received: by mail-yb0-f181.google.com with SMTP id t5so2542810yba.2
        for <ceph-devel@vger.kernel.org>; Sat, 24 Sep 2016 23:58:39 -0700 (PDT)
In-Reply-To: <CAMfR9X+C4Ya=Kq_rYY_eLXvecekNNyATaK95KTcEA-Lw_2rgYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,


I am using Ceph for my college project. Somehow "ceph osd-profile get
.." command is not able to recover the object properly if stripe size
is not a power of 2. Is it mandatory for the stripe size to be a power
of 2?

Read on a blog that stripe size should always be a power of 2 but it
was a very old blog so wanted to confirm if this is still true. Would
really appreciate if someone could confirm this.



Thanks and Regards,
Warren
