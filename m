From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: pools without rules
Date: Thu, 3 Nov 2016 10:43:48 +0100
Message-ID: <CAOi1vP9L9Z9ttjE4MXykRprAH2XHTPVXpM2GaE3tX5oSxk=B6Q@mail.gmail.com>
References: <CA+LTicvDBOTt=d-W8FzgBbpmxrgtM0VFWKFFoEspk+Wekr2deA@mail.gmail.com>
 <CA+LTicsMfaG4C-yL_VGPMuKV0+gmXaTR+E9-1JrNYTgM0g9Drg@mail.gmail.com>
 <alpine.DEB.2.11.1610311332100.20331@piezo.us.to> <CA+LTicszpfwTGHH1F5Ayys2=QMP2+61DeRPWk-F52JWV4nhOLQ@mail.gmail.com>
 <alpine.DEB.2.11.1610311640280.20331@piezo.us.to> <CA+LTicuA41=jx5w+LSipaEHZaGo=nQYp0XBukA8aQCc03ggVYg@mail.gmail.com>
 <CA+LTictrhoQEsJwGOynUzHCWgzenj5BYpuSfrngptGNYVXmUzg@mail.gmail.com>
 <CA+aFP1BZL1ygPtmGEjsyV8GiUWfVveA7+fTpNY0L59b6=e3V7Q@mail.gmail.com>
 <C554BA39-3862-4420-9A7A-BCD349B60882@Teradata.com> <CA+LTicsu3Ods3keSCxfkXk2S5JR8agqunL+HXeYBVOYFRkrY_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36538 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbcKCJnu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2016 05:43:50 -0400
Received: by mail-vk0-f48.google.com with SMTP id p9so34766072vkd.3
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2016 02:43:50 -0700 (PDT)
In-Reply-To: <CA+LTicsu3Ods3keSCxfkXk2S5JR8agqunL+HXeYBVOYFRkrY_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Calcote <john.calcote@gmail.com>
Cc: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>, "dillaman@redhat.com" <dillaman@redhat.com>, Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, kefu chai <tchaikov@gmail.com>, Ali Maredia <amaredia@redhat.com>

On Thu, Nov 3, 2016 at 2:40 AM, John Calcote <john.calcote@gmail.com> wrote:
> I've now built the entire code base from a clean checkout of master -
> the build completed without errors. However, the main build (as
> defined by the README file) does NOT build the documentation - it does
> build the man pages, but not the "read-the-docs" rst files.

Correct.

>
> One thing I haven't mentioned before: I'm building on Ubuntu 14.04 - I
> realize this may be an issue if I'm expected to use a later OS to
> build docs.
>
> Can Anyone help me? I'm just trying to help out here, and I've done
> everything myself that could reasonably be expected of a software
> engineer with 30 years experience. I may be new to Ceph, but I'm not
> new to development, and I'm telling you all, there's a problem with
> building the docs. Once again, here's what happens:
>
> ----------------SNIP----------------
> jcalcote@jmc-u14:~/dev/git/ceph$ ./admin/build-doc
> Top Level States:  ['RecoveryMachine']
> Unpacking /home/jcalcote/dev/git/ceph/src/pybind/rados
>   Running setup.py (path:/tmp/pip-awYqow-build/setup.py) egg_info for
> package from file:///home/jcalcote/dev/git/ceph/src/pybind/rados
>     ERROR: Cannot find Cythonized file rados.c
>     WARNING: Cython is not installed.
>     Complete output from command python setup.py egg_info:
>     ERROR: Cannot find Cythonized file rados.c
>
> WARNING: Cython is not installed.
>
> ----------------------------------------
> Cleaning up...
> Command python setup.py egg_info failed with error code 1 in
> /tmp/pip-awYqow-build
> Storing debug log for failure in /home/jcalcote/.pip/pip.log
> ----------------SNIP----------------

I don't think a lot of people use build-doc, so it may very well be
broken, especially given the recent transition to cmake.  Kefu and Ali
might be able to help, if it's indeed related to that.

I'd try checking out something pre-cmake/cython, like v10.2.0 (or even
something older), and seeing if it works there.  Or if the changes
aren't too invasive, just submit the PR and mention that build-doc
seems to be wedged...

Thanks,

                Ilya
