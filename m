From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: final luminous blockers
Date: Wed, 9 Aug 2017 08:43:29 -0400
Message-ID: <CA+aFP1CWMrnk=k0UY-CmEMXUVHOYgznbm9izeHxmTu0BrfCZyw@mail.gmail.com>
References: <alpine.DEB.2.11.1708081556210.20435@piezo.novalocal>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33419 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdHIMna (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Aug 2017 08:43:30 -0400
Received: by mail-yw0-f182.google.com with SMTP id p68so39073908ywg.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Aug 2017 05:43:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708081556210.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

RBD should be good-to-go for 12.2.0.

On Tue, Aug 8, 2017 at 11:58 AM, Sage Weil <sweil@redhat.com> wrote:
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



-- 
Jason
