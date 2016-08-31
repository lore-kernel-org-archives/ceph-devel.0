From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Python 3 plans
Date: Wed, 31 Aug 2016 12:01:36 -0700
Message-ID: <2bf23853-de9e-5a98-2db1-fe17e9999548@redhat.com>
References: <CALe9h7fHZpXF18HoiQ4qeihrbg5C9p14m=T834T6tm+pdsquuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753370AbcHaTC4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 15:02:56 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBDD94E4DB
        for <ceph-devel@vger.kernel.org>; Wed, 31 Aug 2016 19:01:36 +0000 (UTC)
In-Reply-To: <CALe9h7fHZpXF18HoiQ4qeihrbg5C9p14m=T834T6tm+pdsquuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 08/31/2016 07:09 AM, John Spray wrote:
> Hi all,
>
> Various people have been helpfully fixing up the python modules for
> python 3 -- but I realised I wasn't sure what our plan really was or
> who was depending on this.
>
> Some educated guesses:
>  * All the existing modules working with both python 2 and 3 for Kraken?

That was the goal for this summer - 2 students worked on this for
google summer of code, and completed this (along with tests) for almost
everything - there are just a few PRs left to merge, and a bit
more test coverage to add [0][1]. Blaxpirit added python3 distro
packages of libraries under pybind, which entails building python2 and
python3 versions of the Cython libraries within the course of a normal
build.

In addition, onyb overhauled the python packaging was so once Kraken is
released, we can upload the Kraken cython bindings to pypi, and
developers can easily use them with virtualenvs of any python version.

>  * Starting to test on python 3 when we have Xenial nodes in the lab?

We're testing python2 and 3 on centos 7 (py3 from epel) and trusty for
now. Xenial also has python2, it's just not installed by default, so
python3 support is not necessary for running on xenial.

>  * Keeping python 2 support indefinitely for EL7?

This is needed not just for EL7, but also for existing users of the
python libraries that have not yet ported their applications to
python3. I see no need to make anything python3-only any time soon.

> Related things:
>  * I guess some openstack CIs might start depending on Python 3 at
> some stage?  Maybe this motivated some of the work so far.

There's no one motivating user for this work, it's more a combination
of users interested in running with python 3 (like the folks who ported
the librados bindings), and preparing for the future. Distros are
getting closer to python3-only as python2 enters its final years (2.7,
the last of the 2.x series, is set to stop being supported upstream in
2020) [2].

>  * ceph-mgr will only be python 2 when it lands, it embeds an
> interpreter so will need a bunch of #ifdeffing to support both 2 and 3
> (a necessary evil)

Perhaps it would make sense to build a ceph-mgr-python-3 package as
well, now that the build system can use python2 and python3.

We still need to add some more conditionals around this in cmake - for
kraken, to disable python3 builds when it isn't available (like on suse
or rhel [3]). In the far future, once there are distros with no python2
support, there will be some more build work needed to make the python2
parts optional.

Josh

[0] 
https://gist.github.com/blaxpirit/82dc8b81e4e94bdb4ee3d3ec436faa53#file-gsoc-2016-md
[1] https://gist.github.com/onyb/e5c282d3368631f5d46d62b37bc0ef0d
[2] https://www.python.org/dev/peps/pep-0373/#maintenance-releases
[3] http://tracker.ceph.com/issues/17103
