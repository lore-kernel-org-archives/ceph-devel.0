From: Alfredo Deza <adeza@redhat.com>
Subject: Re: repository build process change
Date: Wed, 30 Nov 2016 07:49:07 -0500
Message-ID: <CAC-Np1yyC5xuCSJypa7xgJqWF9fx9h6Y9NsJdgvxajdyep56XQ@mail.gmail.com>
References: <CAC-Np1zuviMENxn-4ZWMbC78b7J2x1asxg-i3ks+7uTkfuyaRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36811 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932844AbcK3MtJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 07:49:09 -0500
Received: by mail-qk0-f172.google.com with SMTP id n21so207851707qka.3
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 04:49:08 -0800 (PST)
In-Reply-To: <CAC-Np1zuviMENxn-4ZWMbC78b7J2x1asxg-i3ks+7uTkfuyaRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Nov 23, 2016 at 3:15 PM, Alfredo Deza <adeza@redhat.com> wrote:
> Starting next week we will start building binaries and repositories
> from the ceph-ci.git repo (https://github.com/ceph/ceph-ci).
>
> The current build process, which uses ceph.git will also continue at
> the same time, so there is
> enough time to transition over.
>
> This doesn't change anything for a developer except where it needs to
> push to get a repository
> with binaries for a given branch.
>
> After a week of correctly building from both repositories I will send
> a follow up email to warn of the change.

Last night we enabled ceph-ci builds and I managed to get a
configuration setting wrong and builds got stuck.

This has since been corrected and everything should be as normal. We
are working to enable the new ceph-ci builds this week.

Sorry for any troubles.
>
> Let me know if you have any questions,
>
>
> Thanks!
