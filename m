From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: code coverage and teuthology
Date: Tue, 15 Jan 2013 09:21:03 -0800
Message-ID: <50F58FFF.6020508@inktank.com>
References: <50EF49C4.1020909@dachary.org> <50F43FAB.2050609@inktank.com> <50F52B23.4090903@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:59425 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248Ab3AORVK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 12:21:10 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so225270pad.22
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 09:21:09 -0800 (PST)
In-Reply-To: <50F52B23.4090903@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 01/15/2013 02:10 AM, Loic Dachary wrote:
> On 01/14/2013 06:26 PM, Josh Durgin wrote:
>>
>> Looking at how it's run automatically might help:
>>
>> https://github.com/ceph/teuthology/blob/master/teuthology/coverage.py#L88
>>
>>
>> You should also add 'coverage: true' for the ceph task overrides.
>> This way daemons are killed with SIGTERM, and the atexit function
>> that outputs coverage information will run.
>>
>> Then you don't need your patch changing the flavor either.
>> For each task X, the docstring for teuthology.task.X.task documents
>> example usage and extra options like this.
> Hi,
>
> That helped a lot, thanks :-) I think I'm almost there. After running:
>
> ./virtualenv/bin/teuthology --archive /tmp/a1 /srv/3node_rgw.yaml
>
> wget -O /tmp/build/tmp.tgz http://gitbuilder.ceph.com/ceph-tarball-precise-x86_64-gcov/sha1/$(cat /tmp/a1/ceph-sha1)/ceph.x86_64.tgz
>
> echo ceph_build_output_dir: /tmp/build >> ~/.teuthology.yaml
>
> ./virtualenv/bin/teuthology-coverage -v --html-output /tmp/html --lcov-output /tmp/lcov --cov-tools-dir /srv/teuthology/coverage /tmp
>
> I get
>
> INFO:teuthology.coverage:initializing coverage data...
> Retrieving source and .gcno files...
> Initializing lcov files...
> Deleting all .da files in /tmp/lcov/ceph/src and subdirectories
> Done.
> Capturing coverage data from /tmp/lcov/ceph/src
> Found gcov version: 4.7.2
> Scanning /tmp/lcov/ceph/src for .gcno files ...
> Found 692 graph files in /tmp/lcov/ceph/src
> Processing src/test_libhadoopcephfs_build-AuthMethodList.gcno
> geninfo: ERROR: /tmp/lcov/ceph/src/test_libhadoopcephfs_build-AuthMethodList.gcno: reached unexpected end of file
>
> root@ceph:/srv/teuthology# ls -l /tmp/lcov/ceph/src/test_libhadoopcephfs_build-AuthMethodList.gcno
> -rw-r--r-- 1 root root 41088 Jan 15 09:49 /tmp/lcov/ceph/src/test_libhadoopcephfs_build-AuthMethodList.gcno
>
> I'm using
>
> lcov: LCOV version 1.9
>
> The only problem I can think of is that the machine I'm running lcov on is a Debian GNU/Linux Wheezy, trying to analyze coverage for binaries created for Ubuntu Precise. They are both amd64 but .gcno files may have dependencies to the toolchain.
>
> Did you ever run into similar problems ?

I think I did when I built and ran on debian, and it was fixed with a
later version of lcov (I think 1.9-2). I didn't try doing the coverage
analysis on a different distribution from where ceph was built and run
though, so that may also cause some issues.

Josh
