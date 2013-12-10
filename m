From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] block I/O when cluster is full
Date: Mon, 09 Dec 2013 16:45:44 -0800
Message-ID: <52A66438.90101@inktank.com>
References: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>	<52A12CA9.3020008@inktank.com>	<CAPYLRzj+NE-g=NAt9P-x1dtvLFFFBHZmrwJSU4hxBuXiJaQbfA@mail.gmail.com>	<52A284F8.7020602@inktank.com>	<CAPYLRzgLX=dni9cD2f4sANHTNqPrvr8=wZdTKHj0J5NSOgU0wQ@mail.gmail.com>	<52A65C36.9060105@inktank.com> <CAPYLRzgr7p3HGZUrg2NyvA2uBPUaucmxy7rgG+sMJcFkjH+F=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:48263 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab3LJApv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Dec 2013 19:45:51 -0500
Received: by mail-yh0-f54.google.com with SMTP id z12so3353247yhz.41
        for <ceph-devel@vger.kernel.org>; Mon, 09 Dec 2013 16:45:50 -0800 (PST)
In-Reply-To: <CAPYLRzgr7p3HGZUrg2NyvA2uBPUaucmxy7rgG+sMJcFkjH+F=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/09/2013 04:19 PM, Gregory Farnum wrote:
> On Mon, Dec 9, 2013 at 4:11 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> On 12/06/2013 06:24 PM, Gregory Farnum wrote:
>>>
>>> On Fri, Dec 6, 2013 at 6:16 PM, Josh Durgin <josh.durgin@inktank.com>
>>> wrote:
>>>> Don't bother trying to stop ENOSPC on the client side, since it'd need
>>>> some
>>>> restructuring in the kernel side and would be prone to screwing up
>>>> write ordering.
>>>>
>>>> Instead drop writes on the osd side when they have a map marked full,
>>>> and have clients resend all writes when a map goes transitions from
>>>> full -> nonfull. The userspace side is
>>>> https://github.com/ceph/ceph/pull/914
>>>
>>>
>>> Do previous client implementations already satisfy that requirement?
>>> We can't drop requests if older clients expect a response...
>>
>>
>> No, previous clients do not do this. For old rbd clients, this turns a
>> potential corruption into a hang, which is a good trade-off imo.
>>
>> For userspace clients, this only happens when the osd gets the FULL map
>> first, and rejects a write in flight before the client got a FULL map.
>>
>> The kernel client already rejects writes at the fs layer when the FULL
>> flag is set, so kcephfs will only be affected when it hits this race as
>> well.
>
> Hrm, do we have mechanisms in the kernel for re-sending ops that are
> waiting? Hanging instead of corrupting doesn't help us much if we have
> no way to get the proper state ondisk.

Yes, that's what 1/3 uses.

