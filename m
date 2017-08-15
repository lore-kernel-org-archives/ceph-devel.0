From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: warnings in rgw_crypt.cc
Date: Tue, 15 Aug 2017 15:03:52 -0700
Message-ID: <CAJ4mKGZMPkobDgFpM7tyrBtKb+0m5S-DVg1yam=CHTAcBx4NDQ@mail.gmail.com>
References: <CALe9h7cCO+ZLHysdHr8AueyfkHLMvj1Wsy7CO0763cD3ydcJ3w@mail.gmail.com>
 <CAJ4mKGYODRagB-a6-QRMm1Npj28QdpmPq9jdfo7DygfPvS0qjg@mail.gmail.com> <74847d74-ed64-163d-eceb-2284d603c077@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33343 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbdHOWDz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Aug 2017 18:03:55 -0400
Received: by mail-io0-f169.google.com with SMTP id j32so7721739iod.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Aug 2017 15:03:54 -0700 (PDT)
In-Reply-To: <74847d74-ed64-163d-eceb-2284d603c077@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jos Collin <jcollin@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Aug 14, 2017 at 6:48 PM, Jos Collin <jcollin@redhat.com> wrote:
> Hi,
>
> @Greg:
> No, your PR is not merged it seems.
> Please see:
> https://github.com/ceph/ceph/blob/master/src/rgw/rgw_crypt.cc#L38
> https://github.com/ceph/ceph/blob/master/src/rgw/rgw_crypt.cc#L247
>
> I have created the following tracker the moment I saw this warning:
> http://tracker.ceph.com/issues/19851
>
> and
>
> This PR https://github.com/ceph/ceph/pull/14498, implements this
> requirement.
>
> But the progress of this PR seems to be very slow. As this warning is
> annoying and appears in every PR tests and builds, I have created a PR
> yesterday for removing it sooner:
> https://github.com/ceph/ceph/pull/17012

Merged, thanks!
