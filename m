From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-users] v12.1.4 Luminous (RC) released
Date: Wed, 16 Aug 2017 14:26:58 -0400
Message-ID: <CAC-Np1xMKD7TNpXKCy2AyatDOkGubGzifRX_TYyF0D48SG+pEg@mail.gmail.com>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com> <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
 <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com>
 <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com> <CAJ4mKGZqB+2ocK3Eo2fLbA8ebzrAuvFFw3Pf2sy-zantTdTkrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34289 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbdHPS1B (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Aug 2017 14:27:01 -0400
Received: by mail-wr0-f177.google.com with SMTP id y96so20145058wrc.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 11:27:00 -0700 (PDT)
In-Reply-To: <CAJ4mKGZqB+2ocK3Eo2fLbA8ebzrAuvFFw3Pf2sy-zantTdTkrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>

On Wed, Aug 16, 2017 at 11:42 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> <Reducing this to ceph-devel/ceph-maintainers, this discussion doesn't
> need to blast all over>
>
> On Wed, Aug 16, 2017 at 5:13 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Tue, Aug 15, 2017 at 10:35 PM, Matt Benjamin <mbenjami@redhat.com> wrote:
>>> I think we need a v12.1.5 including #17040
>>
>> *I* think that this is getting to a point where we should just have
>> nightly development releases.
>>
>> What is the benefit of waiting for each RC every two weeks (or so) otherwise?
>
> RC releases are supposed to be release candidates, as in, things that
> we think could be the release. As with much else in the Luminous cycle
> that broke down a bit, and that's frequently not really the case
> because we know it's missing features we want to make available, but
> in general it's not too far off — we believe the code is stable; it's
> passing our nightlies; we want people to test and use it a lot more
> rigorously than dev checkpoints. Every RC is practice for the real
> thing and making them available the same way as real releases is part
> of that.
>
>>
>> On one side we are treating the RC releases somewhat like normal
>> releases, with proper announcements, waiting for
>> QA suites to complete, and have leads "ack" when their components are
>> good enough. But on the other side of things
>> we then try to cut releases to include fixes as immediate as possible
>> (and as often as that means)
>>
>> We've had 3 releases already in August and this would mean discussing
>> a *fourth*.
>
> We had 12.1.2 on August 2 and 12.1.3 on August 9. This last 12.1.4 was
> an emergency because we broke things, and that'll happen sometimes no
> matter what dev process you're using.
>

And that is understandable, I agree that even for stable releases that
can happen.

> Let's not jump overboard just because we had one emergency and another
> idle suggestion that it'd be nice to fix bug X. If your concern is
> that these builds take a lot of time, I'm sure we'd all love a
> smoother build infrastructure. But build time is not the dominating
> issue when deciding how we do releases when we want users to practice
> with them. :)

I wouldn't raise this if it was infrequent.

A build time is a concern if it can't be automated and it takes a long
time. Currently releases take about a day if all goes well. If it took
a whole week
but doesn't need any intervention it wouldn't be a problem, but we
can't get there if we want to treat these releases like stable ones,
where other things
need to happen in order to get them out the door.

The dev builds take about 1 hour, and they don't require any
babysitting, and that is what I would envision for these types of
releases.

How would a daily release impact negatively the goals you are
describing for an RC?

> -Greg
>
>>
>>>
>>> Matt
>>>
>>> On Tue, Aug 15, 2017 at 5:16 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>>> On Tue, Aug 15, 2017 at 2:05 PM, Abhishek <abhishek@suse.com> wrote:
>>>>> This is the fifth release candidate for Luminous, the next long term
>>>>> stable release. We’ve had to do this release as there was a bug in
>>>>> the previous RC, which affected upgrades to Luminous.[1]
>>>>
>>>> In particular, this will fix things for those of you who upgraded from
>>>> Jewel or a previous RC and saw OSDs crash instantly on boot. We had an
>>>> oversight in dealing with another bug. (Standard disclaimer: this was
>>>> a logic error that resulted in no data changes. There were no
>>>> durability implications — not that that helps much when you can't read
>>>> your data out again.)
>>>>
>>>> Sorry guys!
>>>> -Greg
>>>>
>>>>>
>>>>> Please note that this is still a *release candidate* and
>>>>> not the final release, we're expecting the final Luminous release in
>>>>> a week's time, meanwhile, testing and feedback is very much welcom.
>>>>>
>>>>> Ceph Luminous (v12.2.0) will be the foundation for the next long-term
>>>>> stable release series. There have been major changes since Kraken
>>>>> (v11.2.z) and Jewel (v10.2.z), and the upgrade process is non-trivial.
>>>>> Please read these release notes carefully. Full details and changelog at
>>>>> http://ceph.com/releases/v12-1-4-luminous-rc-released/
>>>>>
>>>>> Notable Changes from 12.1.3
>>>>> ---------------------------
>>>>> * core: Wip 20985 divergent handling luminous (issue#20985, pr#17001, Greg
>>>>> Farnum)
>>>>> * qa/tasks/thrashosds-health.yaml: ignore MON_DOWN (issue#20910, pr#17003,
>>>>> Sage Weil)
>>>>> * crush, mon: fix weight set vs crush device classes (issue#20939, Sage
>>>>> Weil)
>>>>>
>>>>>
>>>>> Getting Ceph
>>>>> ------------
>>>>> * Git at git://github.com/ceph/ceph.git
>>>>> * Tarball at http://download.ceph.com/tarballs/ceph-12.1.4.tar.gz
>>>>> * For packages, see http://docs.ceph.com/docs/master/install/get-packages/
>>>>> * For ceph-deploy, see
>>>>> http://docs.ceph.com/docs/master/install/install-ceph-deploy
>>>>> * Release sha1: a5f84b37668fc8e03165aaf5cbb380c78e4deba4
>>>>>
>>>>> [1]: http://tracker.ceph.com/issues/20985
>>>>>
>>>>>
>>>>> Best Regards
>>>>> Abhishek
>>>>>
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users@lists.ceph.com
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
