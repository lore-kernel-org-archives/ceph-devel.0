From: Matt Benjamin <mbenjami@redhat.com>
Subject: Re: [ceph-users] v12.1.4 Luminous (RC) released
Date: Tue, 15 Aug 2017 22:35:10 -0400
Message-ID: <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com> <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36237 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbdHPCfL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Aug 2017 22:35:11 -0400
Received: by mail-pf0-f176.google.com with SMTP id c28so387105pfe.3
        for <ceph-devel@vger.kernel.org>; Tue, 15 Aug 2017 19:35:11 -0700 (PDT)
In-Reply-To: <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com, ceph-announce@ceph.com

I think we need a v12.1.5 including #17040

Matt

On Tue, Aug 15, 2017 at 5:16 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Aug 15, 2017 at 2:05 PM, Abhishek <abhishek@suse.com> wrote:
>> This is the fifth release candidate for Luminous, the next long term
>> stable release. We’ve had to do this release as there was a bug in
>> the previous RC, which affected upgrades to Luminous.[1]
>
> In particular, this will fix things for those of you who upgraded from
> Jewel or a previous RC and saw OSDs crash instantly on boot. We had an
> oversight in dealing with another bug. (Standard disclaimer: this was
> a logic error that resulted in no data changes. There were no
> durability implications — not that that helps much when you can't read
> your data out again.)
>
> Sorry guys!
> -Greg
>
>>
>> Please note that this is still a *release candidate* and
>> not the final release, we're expecting the final Luminous release in
>> a week's time, meanwhile, testing and feedback is very much welcom.
>>
>> Ceph Luminous (v12.2.0) will be the foundation for the next long-term
>> stable release series. There have been major changes since Kraken
>> (v11.2.z) and Jewel (v10.2.z), and the upgrade process is non-trivial.
>> Please read these release notes carefully. Full details and changelog at
>> http://ceph.com/releases/v12-1-4-luminous-rc-released/
>>
>> Notable Changes from 12.1.3
>> ---------------------------
>> * core: Wip 20985 divergent handling luminous (issue#20985, pr#17001, Greg
>> Farnum)
>> * qa/tasks/thrashosds-health.yaml: ignore MON_DOWN (issue#20910, pr#17003,
>> Sage Weil)
>> * crush, mon: fix weight set vs crush device classes (issue#20939, Sage
>> Weil)
>>
>>
>> Getting Ceph
>> ------------
>> * Git at git://github.com/ceph/ceph.git
>> * Tarball at http://download.ceph.com/tarballs/ceph-12.1.4.tar.gz
>> * For packages, see http://docs.ceph.com/docs/master/install/get-packages/
>> * For ceph-deploy, see
>> http://docs.ceph.com/docs/master/install/install-ceph-deploy
>> * Release sha1: a5f84b37668fc8e03165aaf5cbb380c78e4deba4
>>
>> [1]: http://tracker.ceph.com/issues/20985
>>
>>
>> Best Regards
>> Abhishek
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
