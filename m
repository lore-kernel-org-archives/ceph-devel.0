From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: A question on coredumps in unittests
Date: Tue, 12 Apr 2016 12:06:53 +0200
Message-ID: <570CC8BD.7010406@digiware.nl>
References: <570CC221.2040603@digiware.nl> <570CC7ED.4060405@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:34274 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756267AbcDLKHO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Apr 2016 06:07:14 -0400
In-Reply-To: <570CC7ED.4060405@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 12-4-2016 12:03, Loic Dachary wrote:
> Hi,
>
> IIRC there needs to be a pattern defined for where core are to be found. For instance teuthology/task/internal.py has                 'sudo', 'sysctl', '-w', 'kernel.core_pattern={adir}/coredump/%t.%p.core'.format(adir=archive_dir),
>
> I hope that helps

Our local Linux Guru is out, so I can't harras him now, but this gives 
me a pointer.

Any objections to adding the code below?
(Even if only ifdefed for FreeBSD)

It keep the directory pollution a bit down.

--WjW

>
> On 12/04/2016 11:38, Willem Jan Withagen wrote:
>> Hi Loic,
>>
>> You have written a lot of the unittests, so it seems.
>>
>> I'm having the issue that under FreeBSD the cores are left behind from
>> the EXPECT_DAETH tests.
>> But under CentOS7 no cores are left behind.
>> And 'ulimit -c unlimited' does not help to get cores
>>
>> Is there anything particular why this is the case...
>> Google tests suggest that it is the programs responsability to cleanup
>> after itself.
>>
>> And would there be any objections to adding code like:
>>
>>      ret = RUN_ALL_TESTS();
>>      if (ret == 0) {
>>          char core [30];
>>          strncpy(core, argv[0], 19);
>>          core[19] = '\0';
>>          strcat(core, ".core");
>>          ::unlink(core);
>>          free(core);
>>      }
>>      return ret;
>>
>> to the tests
>>
>> Thanx,
>> --WjW
>>
>
