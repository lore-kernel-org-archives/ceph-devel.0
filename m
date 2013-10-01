From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: Performance results on inline data support
Date: Tue, 01 Oct 2013 22:40:06 +0800
Message-ID: <524ADEC6.10405@ubuntukylin.com>
References: <5249377C.8030003@ubuntukylin.com> <52497109.8030206@inktank.com> <524ADA80.30700@ubuntukylin.com> <524ADC5F.4010400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:38063 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3JAOkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Oct 2013 10:40:09 -0400
In-Reply-To: <524ADC5F.4010400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

True. 'How small is small' seems to be a common issue for small file 
optimization. I guess there is an optimal threshold there, and maybe 
depending on the workloads, even the number of MDSs. It is obviously 
advantageous for read-only applications, and it comes at a cost of 
pollution of the MDS's metadata cache, at least, leave less space for 
metadata cache.

Cheers,
Li Wang

On 10/01/2013 10:29 PM, Mark Nelson wrote:
> Great.  I'd be curious to know what the right limits are. :)
>
> Mark
>
> On 10/01/2013 09:21 AM, Li Wang wrote:
>> Currently it is 4KB, but we will implement it as a tunable parameter.
>>
>> Cheers,
>> Li Wang
>>
>> On 09/30/2013 08:39 PM, Mark Nelson wrote:
>>> On 09/30/2013 03:34 AM, Li Wang wrote:
>>>> Hi,
>>>>    We did a performance test on inline data support, the Ceph
>>>> cluster is
>>>> composed of 1 MDS, 1 MON, 6 OSD on a HPC cluster. The program is
>>>> simple,
>>>> there are 1000 - 3000 files with each being 1KB. The program repeated
>>>> the following processes on each file: open(), read(), close(). The
>>>> total
>>>> time is measured with/without inline data support. The results are as
>>>> follows (seconds),
>>>>
>>>> #files  without    with
>>>> 1000    17.3674      8.7186
>>>> 2000    35.4848      17.7646
>>>> 3000    53.2164      26.4374
>>>
>>> Excellent job!  Looks like this could make a big difference for certain
>>> workloads.  How much data can it store before it switches away from
>>> inlining the data?
>>>
>>>>
>>>> Cheers,
>>>> Li Wang
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>
>
