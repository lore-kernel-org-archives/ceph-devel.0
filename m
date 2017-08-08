From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: luminous branch is now forked
Date: Tue, 8 Aug 2017 08:09:06 -0400
Message-ID: <CA+aFP1AG6Bf4f++h91GPjcp360+FY5gqXyJ_GEJVbvcXjcF15g@mail.gmail.com>
References: <alpine.DEB.2.11.1708071600050.20435@piezo.novalocal>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34456 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbdHHMJH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Aug 2017 08:09:07 -0400
Received: by mail-yw0-f179.google.com with SMTP id s143so19720658ywg.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 05:09:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708071600050.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Should we start running teuthology nightlies against the luminous
branch (perhaps swapping out kraken)?

On Mon, Aug 7, 2017 at 12:01 PM, Sage Weil <sweil@redhat.com> wrote:
> The luminous branch is now fully forked from master.  Any fixes merged to
> master need to be cherry-pick -x'd to luminous.
>
> There are only 6 open prs with the luminous tag.  I'm going to clear the
> milestone for these shortly so that the luminous milestone can be used for
> luminous backport PRs.
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
