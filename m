From: David Galloway <dgallowa@redhat.com>
Subject: Re: [ceph-users] tracker.ceph.com
Date: Tue, 20 Dec 2016 14:24:55 -0500
Message-ID: <6c6c5e67-f9bb-2595-f884-089a93d3be1d@redhat.com>
References: <8421d2fe-067f-97c0-4a79-083c37baee35@redhat.com>
 <c6a0103f-5f03-b3f6-7a87-80e73e9d49ef@redhat.com>
 <84d80a96-93d4-4425-ebb5-58b3050687ae@suse.cz>
 <bac5442d-95fc-ad5f-7879-6a7f5ae9baa0@redhat.com>
 <cdf1b050-6b7d-d2e2-f05a-2b6d84d0089e@suse.cz>
 <135821945.5017.1482252480516@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965378AbcLTTZD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Dec 2016 14:25:03 -0500
In-Reply-To: <135821945.5017.1482252480516@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Nathan Cutler <ncutler@suse.cz>, ceph-users@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>


On 12/20/2016 11:48 AM, Wido den Hollander wrote:
>
>> Op 20 december 2016 om 17:31 schreef Nathan Cutler <ncutler@suse.cz>:
>>
>>
>>> Looks like it was trying to send mail over IPv6 and failing.
>>>
>>> I switched back to postfix, disabled IPv6, and show a message was
>>> recently queued for delivery to you.  Please confirm you got it.
>>
>> Got it. Thanks for the fix!
>>
>
> I wouldn't call it a fix. In 2016 (almost 2017) IPv6 should be enabled, no questions asked.
>
> After the recent migrations both ceph.com and tracker.ceph.com lost their IPv6. To me that's broken connectivity.
>
> When is this coming back?
>

Tracker never had an IPv6 record as far as I'm aware.  Nevertheless, I 
added its AAAA record to DNS.  We don't manage the reverse DNS for it, 
however, so outgoing mail to gmail addresses still fails because the 
IPv6 address lacks a PTR record.

www.ceph.com lost its IPv6 record because it is using a floating IP 
after its move to the new DreamCompute cluster.  IPv6 isn't functional 
for floating IPs in that cluster yet.

The new ceph.com host isn't using a floating IP and will have an IPv6 
record when we switch over.
