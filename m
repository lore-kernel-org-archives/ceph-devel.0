From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph-disk and 'make'
Date: Mon, 19 Sep 2016 11:30:00 -0700
Message-ID: <CAJ4mKGb4ELCPgQOeiC_RWGtBZ44L1anrKX4eRJZx=p25cVCyMg@mail.gmail.com>
References: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
 <57DF7DA0.2050007@dachary.org> <57DF9525.5050904@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33559 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbcISSaC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 14:30:02 -0400
Received: by mail-vk0-f41.google.com with SMTP id u196so3975348vkd.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Sep 2016 11:30:02 -0700 (PDT)
In-Reply-To: <57DF9525.5050904@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Sep 18, 2016 at 5:40 PM, Sage Weil <sweil@redhat.com> wrote:
> I noticed that with the new cmake when I do a 'make' the ceph-disk target
> isn't built.  And ctest will fail most of its unit tests.  It looks like
> it is part of the 'tests' target, though.  Is it deliberate that a simple
> 'make' doesn't build everything?

Dunno about this specific case, but in general we don't want
*everything* to be built with a simple "make", since it slows down
compile (and, especially, linking). I don't think ceph-disk is used
during development for anything except the tests so this would make
some sense, right?

On Mon, Sep 19, 2016 at 12:35 AM, Loic Dachary <loic@dachary.org> wrote:
> After running
>
> ./install-deps.sh
> mkdir build
> cd build
> cmake ../
> make
>
> I have
>
> loic@a64e7ff3b216:~/ceph-ubuntu-14.04-loic/build$ ls -l src/ceph-disk
> ls -l src/ceph-disk
> total 28
> drwxr-xr-x 4 loic loic 4096 Sep 19 05:57 CMakeFiles
> -rw-r--r-- 1 loic loic  313 Sep 19 05:57 CTestTestfile.cmake
> -rw-r--r-- 1 loic loic 7240 Sep 19 05:57 Makefile
> lrwxrwxrwx 1 loic loic   58 Sep 19 06:00 README.rst -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/README.rst
> lrwxrwxrwx 1 loic loic   57 Sep 19 06:00 ceph_disk -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/ceph_disk
> -rw-r--r-- 1 loic loic 1878 Sep 19 05:57 cmake_install.cmake
> lrwxrwxrwx 1 loic loic   64 Sep 19 06:00 requirements.txt -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/requirements.txt
> lrwxrwxrwx 1 loic loic   56 Sep 19 06:00 setup.py -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/setup.py
> lrwxrwxrwx 1 loic loic   69 Sep 19 06:00 test-requirements.txt -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/test-requirements.txt
>
> which I interpret as make building ceph-disk. Did you expect something else ?

Shouldn't any "built" stuff in cmake be going in the build directory
rather than the ceph/src one?
-Greg
