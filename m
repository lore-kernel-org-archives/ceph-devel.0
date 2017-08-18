From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: [ceph-users] v12.1.4 Luminous (RC) released
Date: Fri, 18 Aug 2017 19:39:40 +0200
Message-ID: <5470e345-0274-0fd3-8fbb-3826dcaaa5ee@suse.cz>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com>
 <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
 <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com>
 <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55993 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750846AbdHRRjm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 18 Aug 2017 13:39:42 -0400
In-Reply-To: <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, Matt Benjamin <mbenjami@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>

> *I* think that this is getting to a point where we should just have
> nightly development releases.

What if that night's development release is totally broken?

The point of having a release is that someone (a human - preferably one 
of the lead developers) has signed off on it. Releasing is inherently 
unautomatable, because when you automate it you lose that assurance.

Nathan
