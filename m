From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
        <bartlomiej.swiecki@corp.ovh.com>
Subject: Re: Breakage in Clang compile....
Date: Thu, 9 Feb 2017 17:31:08 +0100
Message-ID: <385cdacb-741c-c0b5-ed62-a2b3f49cca37@corp.ovh.com>
References: <a5a35bfc-57b2-bf28-9788-04127654e23a@digiware.nl>
 <2445ae3c-ff1e-2894-bfe3-9891070189c8@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 6.mo301.mail-out.ovh.net ([137.74.110.69]:54063 "EHLO
        6.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752464AbdBIQbY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2017 11:31:24 -0500
In-Reply-To: <2445ae3c-ff1e-2894-bfe3-9891070189c8@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Here's the fix:

https://github.com/ceph/ceph/pull/13335


On 02/09/2017 04:46 PM, Bartłomiej Święcki wrote:
> Hi,
>
> Looking at this right now.
>
> Bartek
>
> On 02/09/2017 04:35 PM, Willem Jan Withagen wrote:
>> Hi,
>>
>> I think this is a recent addition to the game?
>> And Clang does not really like it.
>>
>> In file included from
>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:21:
>> /home/jenkins/workspace/ceph-master/src/common/perf_histogram.h:80:9:
>> error: array initializer must be an initializer list
>>        : m_axes_config(other.m_axes_config) {
>>          ^
>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:98:29:
>> note: in instantiation of member function
>> 'PerfHistogram<2>::PerfHistogram' requested here
>>          histogram.reset(new PerfHistogram<>(*other.histogram));
>>                              ^
>> 1 error generated.
>>
>> --WjW
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

