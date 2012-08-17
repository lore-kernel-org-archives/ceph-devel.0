From: Wido den Hollander <wido@widodh.nl>
Subject: Re: omap functions in librados.h
Date: Fri, 17 Aug 2012 22:09:38 +0200
Message-ID: <502EA502.20709@widodh.nl>
References: <502E9D44.6010006@widodh.nl> <CAPYLRzhw9BF+9h6y4WUW113oc71OHQnecACNK0sw7oXbqiUpLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:59462 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab2HQUJk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 16:09:40 -0400
In-Reply-To: <CAPYLRzhw9BF+9h6y4WUW113oc71OHQnecACNK0sw7oXbqiUpLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 08/17/2012 09:54 PM, Gregory Farnum wrote:
> On Fri, Aug 17, 2012 at 12:36 PM, Wido den Hollander <wido@widodh.nl> wrote:
>> Hi,
>>
>> I'm looking for the omap functions in librados.h, but they only seem to be
>> implemented in librados.hpp?
>>
>> I want to store about 6000 objects in a RADOS pool, but I want to give them
>> some attributes I can query for, this should be possible with the omap
>> functionality, shouldn't it?
> What do you mean, query for? You can look at an object and ask if it
> has "foo=bar" in its omap, but you can't say "give me all objects with
> 'foo=bar'".
>

Ah, I must have understood that differently. I thought that leveldb was 
added so you could give objects attributes you could query.

So yes: "Give me all objects that have foo=bar"

I thought I saw some discussion regarding this.

Any ideas besides setting up a own external database with this information?

Wido

>
>> Do to this I want to use phprados, but that is using the C-functions, so
>> that's why I'm asking.
>>
>> Has this been forgotten or is there something blocking it?
> It'll probably be inconvenient as always due to memory management, but
> it's not blocked by anything that I'm aware of.
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
