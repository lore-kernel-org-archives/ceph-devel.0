From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Checking on wip-blkin branch
Date: Tue, 16 Jun 2015 11:20:24 -0700
Message-ID: <558068E8.3050305@redhat.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B304B99DEA@SHSMSX101.ccr.corp.intel.com> <5576FBEA.8030805@redhat.com> <C8CF870384EBCF4CAB89D2041A5C80B304BAAAE6@SHSMSX101.ccr.corp.intel.com> <5580594D.8040809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50830 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbbFPSUU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 14:20:20 -0400
In-Reply-To: <5580594D.8040809@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Xue, Chendi" <chendi.xue@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Shewmaker <agshew@gmail.com>

On 06/16/2015 10:13 AM, Josh Durgin wrote:
> On 06/16/2015 12:02 AM, Xue, Chendi wrote:
>> HI, Josh and Andrew
>>
>> I just rebase the wip-blkin branch to 9.0.1, and did a rados bench
>> test on that
>>
>> https://github.com/ceph/ceph/pull/4963
>
> Thanks! Reset the branch in ceph.git.
>
>> Lttng result is collected successfully
>>
>> Considering on rados testsuits failing issues, I don't have a test
>> environment, any suggests?
>
> You should be able to reproduce the failures without teuthology. Try
> running these scripts from the ceph tree with
>
> ms inject socket failures = 5000
>
> in the [global] section of ceph.conf:
>
> qa/workunits/rados/test.sh
> qa/workunits/rados/test_pool_quota.sh
> qa/workunits/rados/cls.sh

Whoops, there's no cls.sh. I meant all the scripts in qa/workunits/cls/

>
> These resulted in osd crashes in the last rados suite run linked
> earlier in the thread.
>
> Josh
>
>> Best Regards,
>> -Chendi
>>
>> -----Original Message-----
>> From: Josh Durgin [mailto:jdurgin@redhat.com]
>> Sent: Tuesday, June 9, 2015 10:45 PM
>> To: Xue, Chendi; ceph-devel@vger.kernel.org; Andrew Shewmaker
>> Subject: Re: Checking on wip-blkin branch
>>
>> Hi Chendi,
>>
>> On 06/09/2015 04:59 AM, Xue, Chendi wrote:
>>> Hi, Josh and Andrew
>>>
>>> Today, I applied wip-blkin branch to my 4 nodes ceph setup, and
>>> created zipkin-based lttng results successfully.
>>>
>>> Since we wanna using this latency analyzing methodology on further
>>> release or on keyvalue store and newstore.
>>> I am wondering what is the gap to merge blkin into master? Can I help
>>> to rebase to master, so we can merge this branch?
>>
>> That'd be great! Andrew and I simply haven't had time to finish fixing
>> up the remaining issues. Running it through a rados suite showed some
>> more changes were necessary to handle more complicated osd usage -
>> you'll see several osd crashes in this rados suite run [1].
>>
>> The code was looking fine to me, it just needs rebasing and debugging
>> so it can pass the rados test suite.
>>
>> Thanks!
>> Josh
>>
>> [1]
>> http://pulpito.ceph.com/joshd-2015-03-25_17:29:16-rados-wip-blkin---blkin-multi/
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

