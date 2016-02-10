From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Jenkins error in running tests ....
Date: Wed, 10 Feb 2016 13:04:13 +0100
Message-ID: <56BB273D.2040007@digiware.nl>
References: <56B9B0A1.6090807@digiware.nl>
 <CAJE9aONSEzJVWe4Ows7oNrg403_ucT4vYdvCNEujGr74h7cYqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:55854 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbcBJNPE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Feb 2016 08:15:04 -0500
In-Reply-To: <CAJE9aONSEzJVWe4Ows7oNrg403_ucT4vYdvCNEujGr74h7cYqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10-2-2016 12:58, kefu chai wrote:
> On Tue, Feb 9, 2016 at 5:25 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> https://jenkins.ceph.com/job/ceph-pull-requests/1261/console
>>
>> .......
>> PASS: test/osd/osd-scrub-repair.sh
>> make[5]: execvp: /bin/sh: Argument list too long
>> make[5]: *** [test-suite.log] Error 127
>> make[5]: Leaving directory
>> `/home/jenkins-build/build/workspace/ceph-pull-requests/src'
>> make[4]: *** [check-TESTS] Error 2
>> make[4]: Leaving directory
>> `/home/jenkins-build/build/workspace/ceph-pull-requests/src'
>> make[3]: *** [check-am] Error 2
>>
>> I'm assuming that it is not something I did in my code.
>> But then again I've been proven wrong....
>
> Willem, seems you are not the only one having this failure in the
> jenkins run. i have
> the same error in
> https://jenkins.ceph.com/job/ceph-pull-requests/1294/console for
> my pull request of https://github.com/ceph/ceph/pull/7523 as well.

Problem is that I cannot reproduce it here. Atleast not thusfar.
And Jenkins has limitted debug possibilities.

So, i guess, it is a sort of catch-22, which needs to be solved by
people with more access to the platform.

--WjW
