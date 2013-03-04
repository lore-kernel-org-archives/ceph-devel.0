From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/3] libceph: drop mutex while allocating a message
Date: Mon, 04 Mar 2013 13:25:46 -0600
Message-ID: <5134F53A.1010601@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E3AD.4080906@inktank.com> <5134E3F1.70008@inktank.com> <CAPYLRzhQeqbEK6wp+V8OWaAeyML1Uqh60vc0omanTyvCsXtTXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:41741 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758773Ab3CDTZq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 14:25:46 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so5072245iae.39
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 11:25:46 -0800 (PST)
In-Reply-To: <CAPYLRzhQeqbEK6wp+V8OWaAeyML1Uqh60vc0omanTyvCsXtTXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/04/2013 01:07 PM, Gregory Farnum wrote:
> On Mon, Mar 4, 2013 at 10:12 AM, Alex Elder <elder@inktank.com> wrote:
>> In ceph_con_in_msg_alloc(), if no alloc_msg method is defined for a
>> connection a new message is allocated with ceph_msg_new().
>>
>> Drop the mutex before making this call, and make sure we're still
>> connected when we get it back again.
> 
> Why do we need to drop the mutex at all? The mds_alloc_msg() that
> you're about to define doesn't seem to need it.
> -Greg
> 

My purpose in doing this is to make the third patch in
this series trivial to review.  That is, I make the code
here match what will happen when I unify how all alloc_msg
calls get made, as a pre-step, and then it's easier to see
that the later patch is correct.

I agree, it's not needed for that allocator.  By the same
token, it almost certainly causes no harm, and the end result
will be consistent handling by all users of this interface.

					-Alex
