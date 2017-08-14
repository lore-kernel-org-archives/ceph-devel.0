From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: warnings in rgw_crypt.cc
Date: Mon, 14 Aug 2017 09:41:57 -0700
Message-ID: <CAJ4mKGYODRagB-a6-QRMm1Npj28QdpmPq9jdfo7DygfPvS0qjg@mail.gmail.com>
References: <CALe9h7cCO+ZLHysdHr8AueyfkHLMvj1Wsy7CO0763cD3ydcJ3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:36961 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbdHNQl7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Aug 2017 12:41:59 -0400
Received: by mail-it0-f47.google.com with SMTP id 76so20611265ith.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Aug 2017 09:41:59 -0700 (PDT)
In-Reply-To: <CALe9h7cCO+ZLHysdHr8AueyfkHLMvj1Wsy7CO0763cD3ydcJ3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 14, 2017 at 9:38 AM, John Spray <jspray@redhat.com> wrote:
> Hi all,
>
> These have been in master for quite a while now:
>
> /home/jenkins-build/build/workspace/ceph-pull-requests/src/rgw/rgw_crypt.cc:38:2:
> warning: #warning "TODO: move this code to auth/Crypto for others to
> reuse." [-Wcpp]
>  #warning "TODO: move this code to auth/Crypto for others to reuse."
>   ^
> /home/jenkins-build/build/workspace/ceph-pull-requests/src/rgw/rgw_crypt.cc:247:2:
> warning: #warning "TODO: use auth/Crypto instead of reimplementing."
> [-Wcpp]
>  #warning "TODO: use auth/Crypto instead of reimplementing."
>   ^
>
> Is anyone working in this area?  Otherwise we should probably just
> create tracker tickets instead of using preprocessor macros as
> reminders.

Yes. A few key people have had fantasies that this was going to be the
next thing on X person's list, but that's clearly not happening. I'd
merge a PR changing that. :)
-Greg
