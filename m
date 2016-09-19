From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk and 'make'
Date: Mon, 19 Sep 2016 09:35:01 +0200
Message-ID: <57DF9525.5050904@dachary.org>
References: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
 <57DF7DA0.2050007@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56443 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757003AbcISHfH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Sep 2016 03:35:07 -0400
In-Reply-To: <57DF7DA0.2050007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

After running

./install-deps.sh
mkdir build
cd build
cmake ../
make

I have

loic@a64e7ff3b216:~/ceph-ubuntu-14.04-loic/build$ ls -l src/ceph-disk
ls -l src/ceph-disk
total 28
drwxr-xr-x 4 loic loic 4096 Sep 19 05:57 CMakeFiles
-rw-r--r-- 1 loic loic  313 Sep 19 05:57 CTestTestfile.cmake
-rw-r--r-- 1 loic loic 7240 Sep 19 05:57 Makefile
lrwxrwxrwx 1 loic loic   58 Sep 19 06:00 README.rst -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/README.rst
lrwxrwxrwx 1 loic loic   57 Sep 19 06:00 ceph_disk -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/ceph_disk
-rw-r--r-- 1 loic loic 1878 Sep 19 05:57 cmake_install.cmake
lrwxrwxrwx 1 loic loic   64 Sep 19 06:00 requirements.txt -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/requirements.txt
lrwxrwxrwx 1 loic loic   56 Sep 19 06:00 setup.py -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/setup.py
lrwxrwxrwx 1 loic loic   69 Sep 19 06:00 test-requirements.txt -> /home/loic/ceph-ubuntu-14.04-loic/src/ceph-disk/test-requirements.txt

which I interpret as make building ceph-disk. Did you expect something else ?

Cheers

On 19/09/2016 07:54, Loic Dachary wrote:
> 
> 
> On 19/09/2016 02:40, Sage Weil wrote:
>> I noticed that with the new cmake when I do a 'make' the ceph-disk target 
>> isn't built.  And ctest will fail most of its unit tests.  It looks like 
>> it is part of the 'tests' target, though.  Is it deliberate that a simple 
>> 'make' doesn't build everything?
> 
> I think make should build it. I'll look into it.
> 
> Cheers
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
