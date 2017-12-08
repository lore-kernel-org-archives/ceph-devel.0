From: kefu chai <tchaikov@gmail.com>
Subject: Re: mimic-dev1 branch for 13.0.1
Date: Fri, 8 Dec 2017 15:42:43 +0800
Message-ID: <CAJE9aOM4w080Yg=MK1Hbg_gZzBPigm_fg0zWnoTUh5eBeDSc-g@mail.gmail.com>
References: <alpine.DEB.2.11.1712041459580.22619@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:43157 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdLHHmo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Dec 2017 02:42:44 -0500
Received: by mail-qt0-f175.google.com with SMTP id w10so24023427qtb.10
        for <ceph-devel@vger.kernel.org>; Thu, 07 Dec 2017 23:42:44 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1712041459580.22619@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Dec 5, 2017 at 1:57 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi all,
>
> I've pushed a mimic-dev1 branch and am kicking off a bunch of qa runs for
> the 13.0.1 dev checkpoint release.  The goal here is to make sure these QA
> runs are clean so that we don't have weeks and weeks of cleaning up our
> testing debt at the end of the mimic cycle.  Yuri is on PTO right now so
> it'll be up to the leads to drive these tests for now.
>
> Overall for the rados suite I think we are in reasonably good shape,
> but there are definitely some failures that we should clean up before
> moving on.
>
> Please try to merge fixes directly into the mimic-dev1 branch (instead of
> cherry-picking the fixes).  We will periodically merge mimic-dev1 back
> into master, and also merge the eventual 13.0.1 release tag into master as
> well.

some fixes also address the QA suite failures on master branch, if they go to
mimic-dev1 and will not go back to master branch immediately. we will still be
seeing test failures in the merge window. take
https://github.com/ceph/ceph/pull/19395,
as an example, it is in mimic-dev1 first. but i found that the same failure also
existed in master, that's why i want to have this fix in master before waiting
the merge in batch.

so, shall we just be more patient in this case, or we can forward-port
the fix to
master immediately?

-- 
Regards
Kefu Chai
