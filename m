From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: About the problem "export_diff relies on clone_overlap, which is
 lost when cache tier is enabled"
Date: Fri, 4 Aug 2017 15:14:14 +0800
Message-ID: <CAJACTud-qK7WDZnUGfPKP1iTPoStbDGUG28zQ0ftBTBsqQZghA@mail.gmail.com>
References: <CAJACTuf6q0r0xk6jzohj94cUDRUKKuweTPv021829M-UZZWTHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:32963 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdHDHOP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Aug 2017 03:14:15 -0400
Received: by mail-oi0-f48.google.com with SMTP id d71so8000007oih.0
        for <ceph-devel@vger.kernel.org>; Fri, 04 Aug 2017 00:14:15 -0700 (PDT)
In-Reply-To: <CAJACTuf6q0r0xk6jzohj94cUDRUKKuweTPv021829M-UZZWTHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I mean I think it's the condition check "is_present_clone" that
prevent the clone overlap to record the client write operations
modified range when the target "HEAD" object exists without its most
recent clone object, and if I'm right, just move the clone overlap
modification out of the "is_present_clone" condition check block is
enough to solve this case, just like the PR
"https://github.com/ceph/ceph/pull/16790", and this fix wouldn't cause
other problems.

In our test, this fix solved the problem successfully, however, we
can't confirm it won't cause new problems yet.

So if anyone see this and knows the answer, please help us. Thank you:-)

On 4 August 2017 at 11:41, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> Hi, grep:-)
>
> I finally got what you mean in https://github.com/ceph/ceph/pull/16790.
>
> I agree with you in that " clone overlap is supposed to be tracking
> which data is the same on disk".
>
> My thought is that, "ObjectContext::new_snapset.clones" is already an
> indicator about whether there are clone objects on disk, so, in the
> scenario of "cache tier", although a clone oid does not corresponds to
> a "present clone" in cache tier, as long as
> "ObjectContext::new_snapset.clones" is not empty, there must a one
> such clone object in the base tier. And, as long as
> "ObjectContext::new_snapset.clones" has a strict "one-to-one"
> correspondence to "ObjectContext::new_snapset.clone_overlap", passing
> the condition check "if (ctx->new_snapset.clones.size() > 0)" is
> enough to make the judgement that the clone object exists.
>
> So, if I'm right, passing the condition check "if
> (ctx->new_snapset.clones.size() > 0)" is already enough for us to do
> "newest_overlap.subtract(ctx->modified_ranges)", it doesn't have to
> pass "is_present_clone".
>
> Am I right about this? Or am I missing anything?
>
> Please help us, thank you:-)
