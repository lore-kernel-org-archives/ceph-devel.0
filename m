From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: [ceph-users] v12.1.4 Luminous (RC) released
Date: Wed, 16 Aug 2017 15:17:04 +0200
Message-ID: <8760dn4ppr.fsf@suse.com>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com> <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com> <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com> <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:39183 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbdHPNRI (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 16 Aug 2017 09:17:08 -0400
In-Reply-To: <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Matt Benjamin <mbenjami@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>, ceph-announce@ceph.com

Alfredo Deza <adeza@redhat.com> writes:

> On Tue, Aug 15, 2017 at 10:35 PM, Matt Benjamin <mbenjami@redhat.com> wrote:
>> I think we need a v12.1.5 including #17040
We discussed this in the RGW Standups today & may not need one more RC
for the bug above, and should be fine as far as the fix is in 12.2.0

>
> *I* think that this is getting to a point where we should just have
> nightly development releases.
>
> What is the benefit of waiting for each RC every two weeks (or so) otherwise?

We could consider something of this sort for M maybe?

Abhishek
> On one side we are treating the RC releases somewhat like normal
> releases, with proper announcements, waiting for
> QA suites to complete, and have leads "ack" when their components are
> good enough. But on the other side of things
> we then try to cut releases to include fixes as immediate as possible
> (and as often as that means)
>
> We've had 3 releases already in August and this would mean discussing
> a *fourth*. 
>
>>
>> Matt
>>
>> On Tue, Aug 15, 2017 at 5:16 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Tue, Aug 15, 2017 at 2:05 PM, Abhishek <abhishek@suse.com> wrote:
>>>> This is the fifth release candidate for Luminous, the next long term
>>>> stable release. We’ve had to do this release as there was a bug in
>>>> the previous RC, which affected upgrades to Luminous.[1]
>>>
>>> In particular, this will fix things for those of you who upgraded from
>>> Jewel or a previous RC and saw OSDs crash instantly on boot. We had an
>>> oversight in dealing with another bug. (Standard disclaimer: this was
>>> a logic error that resulted in no data changes. There were no
>>> durability implications — not that that helps much when you can't read
>>> your data out again.)
>>>
>>> Sorry guys!
>>> -Greg
>>>
>>>>
>>>> Please note that this is still a *release candidate* and
>>>> not the final release, we're expecting the final Luminous release in
>>>> a week's time, meanwhile, testing and feedback is very much welcom.
>>>>
>>>> Ceph Luminous (v12.2.0) will be the foundation for the next long-term
>>>> stable release series. There have been major changes since Kraken
>>>> (v11.2.z) and Jewel (v10.2.z), and the upgrade process is non-trivial.
>>>> Please read these release notes carefully. Full details and changelog at
>>>> http://ceph.com/releases/v12-1-4-luminous-rc-released/
>>>>
>>>> Notable Changes from 12.1.3
>>>> ---------------------------
>>>> * core: Wip 20985 divergent handling luminous (issue#20985, pr#17001, Greg
>>>> Farnum)
>>>> * qa/tasks/thrashosds-health.yaml: ignore MON_DOWN (issue#20910, pr#17003,
>>>> Sage Weil)
>>>> * crush, mon: fix weight set vs crush device classes (issue#20939, Sage
>>>> Weil)
>>>>
>>>>
>>>> Getting Ceph
>>>> ------------
>>>> * Git at git://github.com/ceph/ceph.git
>>>> * Tarball at http://download.ceph.com/tarballs/ceph-12.1.4.tar.gz
>>>> * For packages, see http://docs.ceph.com/docs/master/install/get-packages/
>>>> * For ceph-deploy, see
>>>> http://docs.ceph.com/docs/master/install/install-ceph-deploy
>>>> * Release sha1: a5f84b37668fc8e03165aaf5cbb380c78e4deba4
>>>>
>>>> [1]: http://tracker.ceph.com/issues/20985
>>>>
>>>>
>>>> Best Regards
>>>> Abhishek
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

