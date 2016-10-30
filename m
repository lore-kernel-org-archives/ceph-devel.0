From: John Calcote <john.calcote@gmail.com>
Subject: Fwd: pools without rules
Date: Sun, 30 Oct 2016 11:21:47 -0600
Message-ID: <CA+LTicsMfaG4C-yL_VGPMuKV0+gmXaTR+E9-1JrNYTgM0g9Drg@mail.gmail.com>
References: <CA+LTicvDBOTt=d-W8FzgBbpmxrgtM0VFWKFFoEspk+Wekr2deA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35007 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbcJ3RVt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Oct 2016 13:21:49 -0400
Received: by mail-ua0-f172.google.com with SMTP id 12so89214749uas.2
        for <ceph-devel@vger.kernel.org>; Sun, 30 Oct 2016 10:21:48 -0700 (PDT)
In-Reply-To: <CA+LTicvDBOTt=d-W8FzgBbpmxrgtM0VFWKFFoEspk+Wekr2deA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all -

I posted this question to the ceph-user list a few days ago but no one
responded, so I thought I'd send it to the devel list too:

What happens if I create a pool and associated it with a ruleset (say,
set '2', for instance), and then I remove all the rules from set '2'?

Similarly, what happens if I add a single rule to ruleset 2 that's
size-constrained to pools of size 2 - 3, but then create a replicated
pool of size 4 using that ruleset?

Is there a fundamental rule that ceph uses (e.g., random selection) to
choose osds on which to store the replicas?

Thanks,
John
