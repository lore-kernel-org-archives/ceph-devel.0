From: kefu chai <tchaikov@gmail.com>
Subject: Re: ceph-disk and 'make'
Date: Tue, 20 Sep 2016 23:28:30 +0800
Message-ID: <CAJE9aONfH9uWx4vtYUTjJMo_udRU_vEOMBYag8H6gY8+jGNSCA@mail.gmail.com>
References: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
 <57DF7DA0.2050007@dachary.org> <57DF9525.5050904@dachary.org> <CAJ4mKGb4ELCPgQOeiC_RWGtBZ44L1anrKX4eRJZx=p25cVCyMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34420 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754789AbcITP2c (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2016 11:28:32 -0400
Received: by mail-oi0-f49.google.com with SMTP id a62so25910481oib.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2016 08:28:31 -0700 (PDT)
In-Reply-To: <CAJ4mKGb4ELCPgQOeiC_RWGtBZ44L1anrKX4eRJZx=p25cVCyMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Marcus Watts <mwatts@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 20, 2016 at 2:30 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Sun, Sep 18, 2016 at 5:40 PM, Sage Weil <sweil@redhat.com> wrote:
>> I noticed that with the new cmake when I do a 'make' the ceph-disk target
>> isn't built.  And ctest will fail most of its unit tests.  It looks like
>> it is part of the 'tests' target, though.  Is it deliberate that a simple
>> 'make' doesn't build everything?

Sage, it is on purpose. "make" or "make all" should only build the
artifacts supposed
to be installed. this was pointed out by Marcus. and i am inclined to agree with
him on this.

>
> Dunno about this specific case, but in general we don't want
> *everything* to be built with a simple "make", since it slows down
> compile (and, especially, linking). I don't think ceph-disk is used
> during development for anything except the tests so this would make
> some sense, right?

agreed, actually, a test-ready ceph-disk needs venv which pip to install the
dependencies, but debian pbuilder uses a cleanroom for building packages
in which no network access is allowed by default. so if we have builded
ceph-disk while "make", pbuilder will have to enable the network access
from within the cleanroom. there is a bug filed against jewel on this
[1] because
we always have ceph-disk venv as a dependency of "make all".

--
[1] http://tracker.ceph.com/issues/16169

>
> On Mon, Sep 19, 2016 at 12:35 AM, Loic Dachary <loic@dachary.org> wrote:
>> After running
>>
>> ./install-deps.sh
>> mkdir build
>> cd build
>> cmake ../
>> make
>>
>> I have
>>
>> loic@a64e7ff3b216:~/ceph-ubuntu-14.04-loic/build$ ls -l src/ceph-disk
>> ls -l src/ceph-disk
>> total 28
>> drwxr-xr-x 4 loic loic 4096 Sep 19 05:57 CMakeFiles
>> -rw-r--r-- 1 loic loic  313 Sep 19 05:57 CTestTestfile.cmake
>> -rw-r--r-- 1 loic loic 7240 Sep 19 05:57 Makefile
>> lrwxrwxrwx 1 loic loic   58 Sep 19 06:00 README.rst -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/README.rst
>> lrwxrwxrwx 1 loic loic   57 Sep 19 06:00 ceph_disk -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/ceph_disk
>> -rw-r--r-- 1 loic loic 1878 Sep 19 05:57 cmake_install.cmake
>> lrwxrwxrwx 1 loic loic   64 Sep 19 06:00 requirements.txt -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/requirements.txt
>> lrwxrwxrwx 1 loic loic   56 Sep 19 06:00 setup.py -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/setup.py
>> lrwxrwxrwx 1 loic loic   69 Sep 19 06:00 test-requirements.txt -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/test-requirements.txt
>>
>> which I interpret as make building ceph-disk. Did you expect something else ?
>
> Shouldn't any "built" stuff in cmake be going in the build directory
> rather than the ceph/src one?
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
