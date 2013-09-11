From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Jerasure 1.2A plugin for Ceph
Date: Wed, 11 Sep 2013 11:32:40 -0500
Message-ID: <52309B28.3010607@inktank.com>
References: <522055BE.2040200@dachary.org> <CFA250A5-F536-4C28-AC69-10C7F2B6DD39@cs.utk.edu> <52308EDD.5020100@dachary.org> <alpine.DEB.2.00.1309110927280.23522@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:59215 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296Ab3IKQcg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Sep 2013 12:32:36 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so20112199ieb.3
        for <ceph-devel@vger.kernel.org>; Wed, 11 Sep 2013 09:32:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309110927280.23522@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, James Plank <plank@cs.utk.edu>, Ceph Development <ceph-devel@vger.kernel.org>

On 09/11/2013 11:29 AM, Sage Weil wrote:
> On Wed, 11 Sep 2013, Loic Dachary wrote:
>> [cc'ing the devel mailing list]
>>
>> Hi James,
>>
>> Thanks for the positive feedback :-) I found the API fairly
>> straightforward and I don't see what could be improved. However, I've
>> learnt about erasure code and designed the Ceph plugin abstract API
>> mostly by studying jerasure. I'm probably biased : let hear what others
>> have to suggest.
>>
>> Cheers
>>
>> On 11/09/2013 17:04, James Plank wrote:
>>> Hi Loic -- I took a scan, and it looks like a nice usage of the
>>> library.  Here's a question -- for the next revision of jerasure, are
>>> there any functionalities that you would like to see, that would make
>>> your life as a developer easier?  Thanks!  Jim ----------
>
> Hi James-
>
> Late to this discussion, and this may have already been covered, but:
> there is a bunch of Intel-optimized code floating around for various
> erasure codes.  I would love to see this incorporated into jerasure (with
> automatic arch and CPU feature detection) so that users can transparently
> take advantage of it.
>
> sage
>

+1.  Same for ARM down the road. :D

Mark

>
>>>
>>> On Aug 30, 2013, at 4:20 AM, Loic Dachary wrote:
>>>
>>>> Hi James,
>>>>
>>>> The first version of the jerasure 1.2A plugin for Ceph is complete at
>>>>
>>>> https://github.com/ceph/ceph/pull/538#commits-pushed-763275e
>>>>
>>>> This commit introduces the main part:
>>>> ErasureCodeJerasure: base class for jerasure ErasureCodeInterface
>>>> https://github.com/dachary/ceph/commit/76d2842358465e560a4929d60131762f8c93804f
>>>>
>>>> and each technique is derived from it in six successive commits, starting from here
>>>> ErasureCodeJerasure: define technique ReedSolomonVandermonde
>>>>
>>>> It would be great if you could take a look and let us know if you see anything odd.
>>>>
>>>> Cheers
>>>>
>>>> --
>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>> All that is necessary for the triumph of evil is that good people do nothing.
>>>>
>>>
>>
>> --
>> Lo?c Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do nothing.
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

