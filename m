From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: ceph-iscsi packages
Date: Tue, 3 Oct 2017 13:48:11 -0400
Message-ID: <CA+aFP1BtuR--wrPxVKFKj-=ZL9x=Gf0=FRTrvn-tCWtJHaMqsg@mail.gmail.com>
References: <CAMzumdYvfZYb+4S6bmWCn+zjbbr=wPqmi8Qs3Nwrt=fpdP695g@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:48884 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdJCRsN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Oct 2017 13:48:13 -0400
Received: by mail-qt0-f181.google.com with SMTP id d13so13774781qta.5
        for <ceph-devel@vger.kernel.org>; Tue, 03 Oct 2017 10:48:12 -0700 (PDT)
In-Reply-To: <CAMzumdYvfZYb+4S6bmWCn+zjbbr=wPqmi8Qs3Nwrt=fpdP695g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barclay Jameson <almightybeeij@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The Open-iSCSI targetcli, python-rtslib, and tcmu-runner projects
should eventually trickle down into distributions, but before that we
hope to find some responsible entity / person to provide COPR, PPA,
etc repositories for these packages since we don't want to maintain
these packages long-term. We do, from time-to-time, build these as
part of the Ceph development repos available here [1][2].

The story with the Ceph organization's ceph-iscsi-config and
ceph-iscsi-cli packages are a similar story. We hope to get these
officially build and available as part of Ceph's production repos. In
the meantime, development repos are available here [3][4].

[1] https://shaman.ceph.com/repos/python-rtslib/
[2] https://shaman.ceph.com/repos/tcmu-runner/
[3] https://shaman.ceph.com/repos/ceph-iscsi-config/
[4] https://shaman.ceph.com/repos/ceph-iscsi-cli/

Note that the current ceph-iscsi-config package expect an upstream
4.14 kernel with an patch that has not yet been merged into the most
recent release candidate.

On Tue, Oct 3, 2017 at 11:07 AM, Barclay Jameson
<almightybeeij@gmail.com> wrote:
> From the docs:
>
> The following packages must be installed from your Linux
> distribution's software repository:
>
>     targetcli-2.1.fb47 or newer package
>     python-rtslib-2.1.fb64 or newer package
>     tcmu-runner-1.3.0 or newer package
>     ceph-iscsi-config-2.3 or newer package
>     ceph-iscsi-cli-2.5 or newer package
>
>
> Where do I find said packages?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
