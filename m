From: Matt Benjamin <mbenjami@redhat.com>
Subject: Fwd: final luminous blockers
Date: Tue, 8 Aug 2017 13:11:15 -0400
Message-ID: <CAKOnarksy6XtFxgVmj9VPNVpX=hMkDczt6ywGEi511Bi6wLGpA@mail.gmail.com>
References: <alpine.DEB.2.11.1708081556210.20435@piezo.novalocal> <CAKOnarkBrtzUCK46Erje=fArSuSkQPXjH+FXhUqawUeNy_tPoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35430 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdHHRLR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Aug 2017 13:11:17 -0400
Received: by mail-pf0-f175.google.com with SMTP id t86so16976148pfe.2
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 10:11:16 -0700 (PDT)
In-Reply-To: <CAKOnarkBrtzUCK46Erje=fArSuSkQPXjH+FXhUqawUeNy_tPoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

resend
---------- Forwarded message ----------
From: Matt Benjamin <mbenjami@redhat.com>
Date: Tue, Aug 8, 2017 at 12:56 PM
Subject: Re: final luminous blockers
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


With the IAM parser reset use-after-free fix, I think RGW is probably
in good shape.  I think we believe that the cls-rgw test reproducing
in Jewel is not a blocker.  I think dynamic resharding bugs are going
to take longer than 1 day to resolve, so will need to follow the .0.

Matt

On Tue, Aug 8, 2017 at 11:58 AM, Sage Weil <sweil@redhat.com> wrote:
>
> I'm hoping we get get 12.2.0 out the door tomorrow.  On the rados side,
> there is just one blocker:
>
>         http://tracker.ceph.com/issues/20925
>
> which I'm testing a fix for now.  There is also the rocskdb build issue
> that makes things break for folks with really old CPUs, but I don't think
> it needs to block the initial release.
>
> I'm waiting for the latest round of upgrade tests to run as well but I
> think everything is resolved there.
>
> Jason, Matt, Patrick: how are rbd, rgw, and cephfs looking?
>
> Everyone else: any other blockers?
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
