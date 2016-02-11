From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Changing code in a subproject ceph-erasure-code-corpus
Date: Thu, 11 Feb 2016 14:07:14 +0100
Message-ID: <56BC8782.5010401@digiware.nl>
References: <56BB1BFA.6040603@digiware.nl> <56BB1F83.3090304@dachary.org>
 <56BB2696.30505@digiware.nl> <56BB42BD.3050808@dachary.org>
 <56BB44A9.2080700@dachary.org> <56BB514A.10004@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:65033 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433AbcBKNHZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Feb 2016 08:07:25 -0500
In-Reply-To: <56BB514A.10004@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 10-2-2016 16:03, Willem Jan Withagen wrote:
> On 10-2-2016 15:09, Loic Dachary wrote:
>> Once https://github.com/ceph/ceph/pull/7596 is merged, your change
>> will be in use. Would you mind verifying it's the case ?
>
> Thanx,
> And it'll show itself immediately on a next 'make check' run.
> IF it's not there, I'll let you know.

Hi Loic,

It has arived. Currently running a large recompile.

--WjW


>
> --WjW
>
>> On 10/02/2016 21:01, Loic Dachary wrote:
>>> Hi,
>>>
>>> On 10/02/2016 19:01, Willem Jan Withagen wrote:
>>>> On 10-2-2016 12:31, Loic Dachary wrote:
>>>>> Hi,
>>>>>
>>>>> You can submit a patch against
>>>>> https://github.com/ceph/ceph-erasure-code-corpus
>>>>
>>>> Right,
>>>>
>>>> Thru the github interface that went more than easy.....
>>>>
>>>> https://github.com/ceph/ceph-erasure-code-corpus/pull/3
>>>
>>> Merged, thanks !
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
