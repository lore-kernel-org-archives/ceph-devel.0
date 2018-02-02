From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Better anticipation for minor releases
Date: Fri, 2 Feb 2018 10:15:14 -0700
Message-ID: <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com>
 <4173fd50ca3d6d4e4f691f116b425397@suse.com> <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com>
 <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:43271 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeBBRPQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Feb 2018 12:15:16 -0500
Received: by mail-ua0-f171.google.com with SMTP id i5so14611248uai.10
        for <ceph-devel@vger.kernel.org>; Fri, 02 Feb 2018 09:15:15 -0800 (PST)
In-Reply-To: <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-devel-owner@vger.kernel.org

This is just my opinion: we should have a quick "bump commit + tag"
Jenkins job that pushes the Git tag live as soon as possible. In
particular we should not wait for packages to be build + signed +
published on download.ceph.com before pushing the bump commit + tag
live.

Bumping and tagging in Git should take a minute or two, whereas
building, signing, and rsync'ing all the packages for that tag takes
hours. I think this time-intensive process causes the Git history to
diverge for too long.

- Ken

On Fri, Feb 2, 2018 at 5:28 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> On 02/02/2018 01:05 PM, Alfredo Deza wrote:
>>>
>>> If we approximately stop accepting new PRs at the third week, ask leads
>>> at
>>> beginning of week 4 and go through only critical PRs for week 4; and go
>>> to
>>> QE in week5,6 we might be able to somewhat get to a more scheduled minor
>>> releases.
>>
>>
>> This might be a bit hard to deal with, how do you prevent a PR from
>> getting merged? I've seen several times PRs getting merged at the last
>> minute,
>> with little to no testing, and breaking a release :( It hasn't
>> happened much lately, but I don't know of a way to block all PRs for a
>> period of time
>
>
> Do we have a way of releasing a given SHA1 (which has passed QE) even when
> additional PRs have been merged on top of it?
>
> IIRC in the past we could only release the tip of the named (jewel,
> luminous) branch. That does indeed create a risk of PRs getting merged
> post-QE and inadvertently finding their way into a release.
>
> Nathan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
