From: kefu chai <tchaikov@gmail.com>
Subject: Re: ceph-disk and 'make'
Date: Wed, 21 Sep 2016 10:39:22 +0800
Message-ID: <CAJE9aOMNC1ApUUKR3RVr+QBT1hEMLCbPddtA03F-wCvYMgBUWg@mail.gmail.com>
References: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
 <57DF7DA0.2050007@dachary.org> <57DF9525.5050904@dachary.org>
 <CAJ4mKGb4ELCPgQOeiC_RWGtBZ44L1anrKX4eRJZx=p25cVCyMg@mail.gmail.com>
 <CAJE9aONfH9uWx4vtYUTjJMo_udRU_vEOMBYag8H6gY8+jGNSCA@mail.gmail.com> <CALqRxCy629qBDOobD==3B9M_-QkLjeg7xuPcVkkOQ1ycrotVrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35343 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755492AbcIUCjX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2016 22:39:23 -0400
Received: by mail-oi0-f41.google.com with SMTP id w11so44891616oia.2
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2016 19:39:23 -0700 (PDT)
In-Reply-To: <CALqRxCy629qBDOobD==3B9M_-QkLjeg7xuPcVkkOQ1ycrotVrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Marcus Watts <mwatts@redhat.com>, Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 21, 2016 at 2:04 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Tue, Sep 20, 2016 at 9:28 AM, kefu chai <tchaikov@gmail.com> wrote:
>> agreed, actually, a test-ready ceph-disk needs venv which pip to install the
>> dependencies, but debian pbuilder uses a cleanroom for building packages
>> in which no network access is allowed by default.
>
> I'm curious why we need a virtualenv at all (or why we "pip install" anything) ?
>
> The distros should have all the packaged python-* and python3-*
> dependencies already, right?
>
> If we could switch to using the packaged python dependencies for
> everything, we'd fix the pbuilder USENETWORK issue, and avoid the
> indeterminate nature of depending on whatever happens to be going on
> with pypi. Maybe I'm missing something, though?

we could. the python modules installed by pip are only used for
testing purpose, like tox, pytest, flake8, testtools, fixtures, i
think we can add them to the Build-Depends list. and let pbuilder to
take care of them.

@loic what do you think?


>
> - Ken



-- 
Regards
Kefu Chai
