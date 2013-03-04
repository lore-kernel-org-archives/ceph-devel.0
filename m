From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 1/3] libceph: drop mutex while allocating a message
Date: Mon, 4 Mar 2013 11:39:53 -0800
Message-ID: <CAPYLRzjwNgLro0RZORGsxU4e0nmDZTNpUQ2rTrB7Mk0ER6m_hQ@mail.gmail.com>
References: <5134E25E.4030701@inktank.com>
	<5134E3AD.4080906@inktank.com>
	<5134E3F1.70008@inktank.com>
	<CAPYLRzhQeqbEK6wp+V8OWaAeyML1Uqh60vc0omanTyvCsXtTXQ@mail.gmail.com>
	<5134F53A.1010601@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:34538 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496Ab3CDTkY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 14:40:24 -0500
Received: by mail-qa0-f42.google.com with SMTP id cr7so1404689qab.8
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 11:40:23 -0800 (PST)
In-Reply-To: <5134F53A.1010601@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 4, 2013 at 11:25 AM, Alex Elder <elder@inktank.com> wrote:
> On 03/04/2013 01:07 PM, Gregory Farnum wrote:
>> On Mon, Mar 4, 2013 at 10:12 AM, Alex Elder <elder@inktank.com> wrote:
>>> In ceph_con_in_msg_alloc(), if no alloc_msg method is defined for a
>>> connection a new message is allocated with ceph_msg_new().
>>>
>>> Drop the mutex before making this call, and make sure we're still
>>> connected when we get it back again.
>>
>> Why do we need to drop the mutex at all? The mds_alloc_msg() that
>> you're about to define doesn't seem to need it.
>> -Greg
>>
>
> My purpose in doing this is to make the third patch in
> this series trivial to review.

The one that doesn't set the page_alignment for mds messages? *confused*

> That is, I make the code
> here match what will happen when I unify how all alloc_msg
> calls get made, as a pre-step, and then it's easier to see
> that the later patch is correct.

Oh, and we do do the mutex_lock and unlock pair around alloc_msg.
Right, looks good! :)
Reviewed-by: Greg Farnum <greg@inktank.com>


>
> I agree, it's not needed for that allocator.  By the same
> token, it almost certainly causes no harm, and the end result
> will be consistent handling by all users of this interface.
>
>                                         -Alex
