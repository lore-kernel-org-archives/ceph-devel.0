From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 4/4] rbd: don't drop watch requests on completion
Date: Wed, 30 Jan 2013 15:54:45 -0600
Message-ID: <510996A5.9030807@inktank.com>
References: <51043EF2.4070305@inktank.com> <51043F71.3050208@inktank.com> <510977ED.70203@inktank.com> <510984B0.8090907@inktank.com> <5109851A.4020604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:40327 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030Ab3A3Vyp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 16:54:45 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so1765871ieb.1
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 13:54:44 -0800 (PST)
In-Reply-To: <5109851A.4020604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/30/2013 02:39 PM, Josh Durgin wrote:
> On 01/30/2013 12:38 PM, Alex Elder wrote:
>> On 01/30/2013 01:43 PM, Josh Durgin wrote:
>>> On 01/26/2013 12:41 PM, Alex Elder wrote:
>>>> The new request code arranges to get a callback for every osd
>>>> request we submit (this was not the case previously).
>>>>
>>>> We register a lingering object watch request for the header object
>>>> for each mapped rbd image.
>>>>
>>>> If a connection problem occurs, the osd client will re-submit
>>>> lingering requests.  And each time such a request is re-submitted,
>>>> its callback function will get called again.
>>>
>>> I think this should be fixed in the osd_client - rbd should only get
>>> the callback once, when the watch is first registered. Later we
>>> could add a separate callback to handle re-registration if we need to.
>>
>> I agree.  Even so, I would like to maintain a reference
>> to this lingering object request as is done in this patch.
>> I think it makes sense even if we'll never get another
>> callback.
>>
>> I would like to therefore address the multiple callback
>> from the osd client as a separate issue.  If I update
>> the comments here accordingly, and open a tracker issue
>> for the other thing, would that be OK with you?
> 
> That's fine with me.

http://tracker.ceph.com/issues/3967

					-Alex

