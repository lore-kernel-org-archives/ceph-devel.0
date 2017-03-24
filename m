From: kefu chai <tchaikov@gmail.com>
Subject: Re: code review: crc32c for ppc64le architecture
Date: Fri, 24 Mar 2017 13:16:06 +0800
Message-ID: <CAJE9aONRZq3_oVuV1+a4ZsqOirAtDVPdoSa+0uJYiWgmdYdCUQ@mail.gmail.com>
References: <OF3BEF520D.AEA1F984-ON002580ED.00139C83-862580ED.0015CACE@notes.na.collabserv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34082 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbdCXFQI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Mar 2017 01:16:08 -0400
Received: by mail-vk0-f48.google.com with SMTP id z204so4333782vkd.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 22:16:07 -0700 (PDT)
In-Reply-To: <OF3BEF520D.AEA1F984-ON002580ED.00139C83-862580ED.0015CACE@notes.na.collabserv.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew N Solomon <asolomon@us.ibm.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

+ ceph-devel

On Fri, Mar 24, 2017 at 11:58 AM, Andrew N Solomon <asolomon@us.ibm.com> wrote:
> Kefu-
>
> Regarding the pull request you've been reviewing:
> https://github.com/ceph/ceph/pull/13909
>
> I had assumed perhaps you were on vacation since you hadn't commented in a
> few days

Hi Andy,

i am not on vacation, just didn't get a chance to take another look at
your updated
PR. will do it now.

> but I noticed today you are probably around since you replied to some of the
> content on the
> ceph-devel mailing list. Regardless, I'm sure you're busy so I appreciate
> you taking the time
> to review the pull request.
>
> This is my first contribution to the ceph project so I'm not entirely sure
> what to expect in terms
> of the review process, whether any other reviewers besides yourself are
> expected to approve the
> drop before it gets pulled in, and in general what happens next.

any ceph reviewers can review the PRs, but not certain developer are expected
to do so, unless you request him/her to review your change.

in general, we will add needs-qa label on github, and pull it in a rados-qa
suite, and if the tests look good. we will merge it.

>
> If there is anything more you need from my end on the review, please let me
> know.
> Do you think it is likely this will make it in time for the upcoming
> luminous release?

i think so. =)

>
> Thanks,
> Andy
> ---
> Andy Solomon
> Power Open Source Storage Software
> asolomon@us.ibm.com
> (512)286-8657



-- 
Regards
Kefu Chai
