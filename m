From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: build-integration-branch
Date: Mon, 4 Sep 2017 13:36:07 -0700
Message-ID: <CA+2bHPb37yYY8g4ma_cx_ifgvgLXpCXm9sEcBuRNVEfYGL7V5Q@mail.gmail.com>
References: <alpine.DEB.2.11.1708302045570.20435@piezo.novalocal> <CA+2bHPbwsUwpp7k1P=54uet1SsW7PKDX_U=4xgj=tbPOKN3yiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36327 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753965AbdIDUgi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Sep 2017 16:36:38 -0400
Received: by mail-qk0-f178.google.com with SMTP id z143so5370101qkb.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 Sep 2017 13:36:38 -0700 (PDT)
In-Reply-To: <CA+2bHPbwsUwpp7k1P=54uet1SsW7PKDX_U=4xgj=tbPOKN3yiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Sep 4, 2017 at 12:28 PM, Patrick Donnelly <pdonnell@redhat.com> wrote:
> I figure I'll share my own integration branch script (attached) which
> is based on some work John Spray did. It's probably too specific to my
> own workflow but pieces can be pulled out to suit others' needs.
> [...]
> 2) Fetches comments/reviews from GitHub for each PR, looking for
> review approvals for Reviewed-bys.
> 3) Merges refs/upstream/pull/pr#/head with a commit message including
> each commit's title and "Reviewed-by".

I had hard-coded some of the reviewers I've encountered so far in my
script. I have a PR to add a .githubmap to Ceph so we can have an
official map everyone can use for their scripts:

https://github.com/ceph/ceph/pull/17457

-- 
Patrick Donnelly
