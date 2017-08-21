From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-users] v12.1.4 Luminous (RC) released
Date: Mon, 21 Aug 2017 08:14:58 -0400
Message-ID: <CAC-Np1zS4wxjFVCHBdiNnwOG-D2jyJAZrj4H7Ee2vRQcmvqWgg@mail.gmail.com>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com> <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
 <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com>
 <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com> <5470e345-0274-0fd3-8fbb-3826dcaaa5ee@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36234 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbdHUMPA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Aug 2017 08:15:00 -0400
Received: by mail-wr0-f176.google.com with SMTP id f8so61301458wrf.3
        for <ceph-devel@vger.kernel.org>; Mon, 21 Aug 2017 05:15:00 -0700 (PDT)
In-Reply-To: <5470e345-0274-0fd3-8fbb-3826dcaaa5ee@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Matt Benjamin <mbenjami@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>

On Fri, Aug 18, 2017 at 1:39 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> *I* think that this is getting to a point where we should just have
>> nightly development releases.
>
>
> What if that night's development release is totally broken?

Broken like needing a new release? That is my point :) You wait until
the next day.

>
> The point of having a release is that someone (a human - preferably one of
> the lead developers) has signed off on it. Releasing is inherently
> unautomatable, because when you automate it you lose that assurance.

A regular, stable release, yes. Not a nightly/dev release.

>
> Nathan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
