From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Help in analyzing Jenkins output
Date: Sun, 14 Feb 2016 23:07:22 +0100
Message-ID: <56C0FA9A.3030609@digiware.nl>
References: <56C07822.5080600@digiware.nl>
 <CAJ4mKGaQjLFzO3gfD=iDw-12xY+XZNcVks_r2uenw+Q7jYx8jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:22352 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbcBNWHz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 14 Feb 2016 17:07:55 -0500
In-Reply-To: <CAJ4mKGaQjLFzO3gfD=iDw-12xY+XZNcVks_r2uenw+Q7jYx8jQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 14-2-2016 20:46, Gregory Farnum wrote:
> On Sun, Feb 14, 2016 at 4:50 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> I'm having a bit of trouble in finding the actual error in
>>
>> https://jenkins.ceph.com/job/ceph-pull-requests/1419/console
>>
>> The first few python warning/errors seem harmless, because the tests
>> are actually run.
>> Then 'bash -x tests/ceph-disk.sh' is run, which generates a lot of
>> output. But I'm missing the point where that generates an error.
>>
>> Could somebody help me point out where the error is that makes this test
>> fail??
>>
>> The test ATM fails under FreeBSD because of other errors still in some
>> of the scripts and programs..
>> So testing it there doest not even get as far as this point.
> 
> Search for "FAIL:" and you get:
>> FAIL: ceph-disk/run-tox.sh

Yup, run-tox.sh is rather a collection of tests run under tox
supervision. And it ends in running tests/ceph-disks.sh....
I've augmented the script to actually print the status value of the test
executions.
So:
	tests/ceph-disk.sh:386: run:  status=0
tells me that all components are executed and completed successfully.

Still leaving me to wonder why run-tox.sh concludes that there has been
an error....

> and then farther down a big block of output from that test. It's angry
> about a bunch of python syntax issues.
> There's also what looks like an unexpected network disconnect at the
> end; we've been having network troubles and the jenkins bot is failing
> intermittently.

I found the argy puthon murmers, but these do not trigger on my Centos7
platform. Even though they are pressent in the logfiles.

Thanx for helping,
--WjW
