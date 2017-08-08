From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: luminous branch is now forked
Date: Tue, 8 Aug 2017 07:59:26 -0700
Message-ID: <CAMMFjmEJycSdnvAei7EJJWc4QddEDi3eOnEPrkKgyHj24cVbLw@mail.gmail.com>
References: <alpine.DEB.2.11.1708071600050.20435@piezo.novalocal> <CA+aFP1AG6Bf4f++h91GPjcp360+FY5gqXyJ_GEJVbvcXjcF15g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34900 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbdHHO72 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Aug 2017 10:59:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id m85so9582792wma.0
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 07:59:27 -0700 (PDT)
In-Reply-To: <CA+aFP1AG6Bf4f++h91GPjcp360+FY5gqXyJ_GEJVbvcXjcF15g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Dillaman, Jason" <dillaman@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yes I will add it to nightlies.

On Tue, Aug 8, 2017 at 5:09 AM, Jason Dillaman <jdillama@redhat.com> wrote:
> Should we start running teuthology nightlies against the luminous
> branch (perhaps swapping out kraken)?
>
> On Mon, Aug 7, 2017 at 12:01 PM, Sage Weil <sweil@redhat.com> wrote:
>> The luminous branch is now fully forked from master.  Any fixes merged to
>> master need to be cherry-pick -x'd to luminous.
>>
>> There are only 6 open prs with the luminous tag.  I'm going to clear the
>> milestone for these shortly so that the luminous milestone can be used for
>> luminous backport PRs.
>>
>> Thanks!
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
