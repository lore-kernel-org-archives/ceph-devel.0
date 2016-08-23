From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: 0.94.8 QE validation status
Date: Tue, 23 Aug 2016 09:45:36 -0700
Message-ID: <CAKPXa=agnk8Rp27Eenp7xNfnpFHpqy2-=ni9yg24cXfUY_7w8Q@mail.gmail.com>
References: <CAMMFjmFnSi68xJKh+WtpzHzoGu=w1QPnDjZefAuN-fSXtdWi7g@mail.gmail.com>
 <f6cb352e-6a46-7f70-450f-3ae02033b487@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33866 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754269AbcHWQph (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 12:45:37 -0400
Received: by mail-oi0-f49.google.com with SMTP id l203so204220635oib.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 09:45:37 -0700 (PDT)
In-Reply-To: <f6cb352e-6a46-7f70-450f-3ae02033b487@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Yuri Weinstein <yweinste@redhat.com>, "Weil, Sage" <sage@redhat.com>, "Dachary, Loic" <ldachary@redhat.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>

On Tue, Aug 23, 2016 at 12:21 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Known issues (need approval):
>>
>> http://tracker.ceph.com/issues/17075 was caught be several runs, see
>> email from Nathan with details "What to do with python-ceph-compat?"
>
>
> This was caused by
> https://github.com/ceph/teuthology/commit/4543fb64cedffc97c816feff7d4a69cd0456ab15
> (my fault) which is reverted by https://github.com/ceph/teuthology/pull/939
Revert will break jewel/rpm or in newer code where split has already happened.

> - when that is merged the tests could be re-run.
>
> Lesson learned (rather obvious in hindsight) is that we cannot drop the
> python-ceph/python-ceph-compat packages as long as there are tests in
> ceph-qa-suite that install pre-hammer releases.

This is not a problem, the reason packages.yaml + overrides was added
was to solve this issue.
we should be fixing it in right place(yaml or install task) or else we
wont be able to do any package changes at all.

>
> Nathan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
