From: John Spray <jspray@redhat.com>
Subject: Re: Python 3 plans
Date: Thu, 1 Sep 2016 10:45:38 +0100
Message-ID: <CALe9h7eZ+ssvUXv6xfv2PbU-ZiAbXOxza6KEf=xP-X2VfpqjPg@mail.gmail.com>
References: <CALe9h7fHZpXF18HoiQ4qeihrbg5C9p14m=T834T6tm+pdsquuw@mail.gmail.com>
 <2bf23853-de9e-5a98-2db1-fe17e9999548@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34970 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbcIAJqA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Sep 2016 05:46:00 -0400
Received: by mail-qk0-f169.google.com with SMTP id v123so78685102qkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 01 Sep 2016 02:45:59 -0700 (PDT)
In-Reply-To: <2bf23853-de9e-5a98-2db1-fe17e9999548@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 31, 2016 at 8:01 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 08/31/2016 07:09 AM, John Spray wrote:
>>
>> Hi all,
>>
>> Various people have been helpfully fixing up the python modules for
>> python 3 -- but I realised I wasn't sure what our plan really was or
>> who was depending on this.
>>
>> Some educated guesses:
>>  * All the existing modules working with both python 2 and 3 for Kraken?
>
>
> That was the goal for this summer - 2 students worked on this for
> google summer of code, and completed this (along with tests) for almost
> everything - there are just a few PRs left to merge, and a bit
> more test coverage to add [0][1]. Blaxpirit added python3 distro
> packages of libraries under pybind, which entails building python2 and
> python3 versions of the Cython libraries within the course of a normal
> build.
>
> In addition, onyb overhauled the python packaging was so once Kraken is
> released, we can upload the Kraken cython bindings to pypi, and
> developers can easily use them with virtualenvs of any python version.
>
>>  * Starting to test on python 3 when we have Xenial nodes in the lab?
>
>
> We're testing python2 and 3 on centos 7 (py3 from epel) and trusty for
> now. Xenial also has python2, it's just not installed by default, so
> python3 support is not necessary for running on xenial.
>
>>  * Keeping python 2 support indefinitely for EL7?
>
>
> This is needed not just for EL7, but also for existing users of the
> python libraries that have not yet ported their applications to
> python3. I see no need to make anything python3-only any time soon.
>
>> Related things:
>>  * I guess some openstack CIs might start depending on Python 3 at
>> some stage?  Maybe this motivated some of the work so far.
>
>
> There's no one motivating user for this work, it's more a combination
> of users interested in running with python 3 (like the folks who ported
> the librados bindings), and preparing for the future. Distros are
> getting closer to python3-only as python2 enters its final years (2.7,
> the last of the 2.x series, is set to stop being supported upstream in
> 2020) [2].
>
>>  * ceph-mgr will only be python 2 when it lands, it embeds an
>> interpreter so will need a bunch of #ifdeffing to support both 2 and 3
>> (a necessary evil)
>
>
> Perhaps it would make sense to build a ceph-mgr-python-3 package as
> well, now that the build system can use python2 and python3.

At build time the difference will just be whether it's using the
header/libs from python-dev or python3-dev, so that part should be
fairly simple.  I hadn't got as far as thinking about whether we
wanted a ceph-mgr package that would either link with python 2 or
python 3 depending on the distro target, or whether to build two
packages so that users could choose which python they wanted to use.
It might even be possible to build a binary that would support either
python depending on which libs were found at runtime, but that would
probably be too crazy.

> We still need to add some more conditionals around this in cmake - for
> kraken, to disable python3 builds when it isn't available (like on suse
> or rhel [3]). In the far future, once there are distros with no python2
> support, there will be some more build work needed to make the python2
> parts optional.

OK, all makes sense, thanks.

John

> Josh
>
> [0]
> https://gist.github.com/blaxpirit/82dc8b81e4e94bdb4ee3d3ec436faa53#file-gsoc-2016-md
> [1] https://gist.github.com/onyb/e5c282d3368631f5d46d62b37bc0ef0d
> [2] https://www.python.org/dev/peps/pep-0373/#maintenance-releases
> [3] http://tracker.ceph.com/issues/17103
