From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: Better anticipation for minor releases
Date: Fri, 2 Feb 2018 12:15:22 -0800
Message-ID: <CAKPXa=aH8gNi4vLgeOVo2O9PRWDQ3qQJCgE6wiHeAW+-twcP=Q@mail.gmail.com>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com> <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
 <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz> <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com>
 <robbat2-20180202T195241-795645967Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:44714 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeBBUPY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Feb 2018 15:15:24 -0500
Received: by mail-ot0-f180.google.com with SMTP id l5so15334787otj.11
        for <ceph-devel@vger.kernel.org>; Fri, 02 Feb 2018 12:15:23 -0800 (PST)
In-Reply-To: <robbat2-20180202T195241-795645967Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 2, 2018 at 11:55 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> On Fri, Feb 02, 2018 at 10:15:14AM -0700, Ken Dreyer wrote:
>> This is just my opinion: we should have a quick "bump commit + tag"
>> Jenkins job that pushes the Git tag live as soon as possible. In
>> particular we should not wait for packages to be build + signed +
>> published on download.ceph.com before pushing the bump commit + tag
>> live.
>>
>> Bumping and tagging in Git should take a minute or two, whereas
>> building, signing, and rsync'ing all the packages for that tag takes
>> hours. I think this time-intensive process causes the Git history to
>> diverge for too long.
> Thought:
> - Tag or branch a candidate commit for going INTO the QE phase, say
>   v12.2.3-rcX.
> - Run QE on that tag.
> - If QE passes entirely, create final tag at same commit as rc tag.

+1 on this, we already have test suites that need to pass for release,
tagging/branch for specific
release would make it easier to test/release in controlled way, then
working on tip of the stable branch
where unexpected prs can get merged. Also we should freeze other
branches so that commit
goes through only one branch during the dot release cycle until its out.



>
> --
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
