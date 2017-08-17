From: Neha Ojha <nojha@redhat.com>
Subject: Questions regarding ceph -w
Date: Wed, 16 Aug 2017 18:27:08 -0700
Message-ID: <CAKn7kBnGqRsSuatnhJSnp=-YYq1Q9fM7Ma7oRoHzAN9F7Uy_ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36139 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbdHQB1J (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Aug 2017 21:27:09 -0400
Received: by mail-oi0-f50.google.com with SMTP id g131so53042634oic.3
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 18:27:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ncutler@suse.cz, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi John,

I am working on the following tracker issue:
http://tracker.ceph.com/issues/20995.
I was wondering if you could help me figure out a couple of things -

1. What should be the expected output of only using ceph -w? Adding
--watch-channel=* logs things properly, but as for ceph -w alone, I am
unable to understand why I see very few log messages(in some cases
none).

2. For which cases would it show log messages? Like for example, for
"ceph osd out" it does, but not for "ceph osd in", "ceph osd pool
create" etc.

I would really appreciate your help on this issue.

Thanks,
Neha
