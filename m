From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: About the problem "export_diff relies on clone_overlap, which is lost
 when cache tier is enabled"
Date: Fri, 4 Aug 2017 11:41:11 +0800
Message-ID: <CAJACTuf6q0r0xk6jzohj94cUDRUKKuweTPv021829M-UZZWTHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35612 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdHDDlM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Aug 2017 23:41:12 -0400
Received: by mail-oi0-f46.google.com with SMTP id e124so4972375oig.2
        for <ceph-devel@vger.kernel.org>; Thu, 03 Aug 2017 20:41:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi, grep:-)

I finally got what you mean in https://github.com/ceph/ceph/pull/16790.

I agree with you in that " clone overlap is supposed to be tracking
which data is the same on disk".

My thought is that, "ObjectContext::new_snapset.clones" is already an
indicator about whether there are clone objects on disk, so, in the
scenario of "cache tier", although a clone oid does not corresponds to
a "present clone" in cache tier, as long as
"ObjectContext::new_snapset.clones" is not empty, there must a one
such clone object in the base tier. And, as long as
"ObjectContext::new_snapset.clones" has a strict "one-to-one"
correspondence to "ObjectContext::new_snapset.clone_overlap", passing
the condition check "if (ctx->new_snapset.clones.size() > 0)" is
enough to make the judgement that the clone object exists.

So, if I'm right, passing the condition check "if
(ctx->new_snapset.clones.size() > 0)" is already enough for us to do
"newest_overlap.subtract(ctx->modified_ranges)", it doesn't have to
pass "is_present_clone".

Am I right about this? Or am I missing anything?

Please help us, thank you:-)
