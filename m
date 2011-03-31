From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 31 Mar 2011 08:16:12 -0600
Message-ID: <4D948CAC.6040709@sandia.gov>
References: <4D939FF7.1070104@sandia.gov>
 <Pine.LNX.4.64.1103301449400.18670@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:57282 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab1CaOQd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 10:16:33 -0400
In-Reply-To: <Pine.LNX.4.64.1103301449400.18670@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage Weil wrote:
> On Wed, 30 Mar 2011, Jim Schutt wrote:
>>> Hmm!  That does seem to point at the allocator, doesn't it.
>>>
>>> Other threads are doing work during this long interval?  Including freeing
>>> memory, presumably, since basically everything uses the heap one way or
>>> another.  If it's the allocator, it's somehow affecting one thread only,
>>> which is pretty crazy.
>>>
>>> Is it difficult for you to try this with tcmalloc?  That'll tell us
>>> something.
>> I finally had a chance to rerun this testing, using
>> tcmalloc (from google-perftools v1.7) and libatomic_ops (v1.2-2)
>> against current next branch (commit a2ec936a7cd1c).
>>
>> I still get lots of slow RefCountedObject::put calls.
> 
> Argh...
> 
> We've verified there's no swapping going on, right?  The allocator isn't 
> touching cold pages and waiting for them to be swapped in or something?

There's no swap configured on these nodes ;)

> 
>>> One other possibility would be to try to catch this "in the act" and send it
>>> a SIGABRT to get a core dump.  Then we can look in more detail at what this
>>> (and other) threads are up to.  I'm not sure how easy this is to catch on a
>>> particular node...
>> I'll try this next, assuming that using an assert
>> in RefCountedObject::put that() "delete this" takes
>> less than, say, 1 second will catch the state of
>> the other threads at an interesting place.
>>
>> Does that sound OK?
> 
> I was actually suggesting we try to make it core dump inside the "delete 
> this" and watching for a stall in progress and then sending SIGABRT to 
> dump core in the act.  That way we verify it really is in the allocator 
> (and maybe even see where).  That's a bit harder to set up, though!  

Right, I couldn't think of how to automate that stall detection
during the stall, rather than after.  At least, I couldn't
think of how to do it without incurring possibly excessive
overhead, say by starting a timer on every "delete this".

> 
> Dumping right after may still yield some useful info, but I'm less 
> hopeful...

I thought I might try turning off all debugging, except a notice
that the "delete this" took too long.  This is easy to do, and
would tell us if allocator activity in support of debugging is
affecting operations.  It doesn't lead to any ideas for
improving the situation, though :/

Also, since I built tcmalloc from source, I thought I might
try to figure out what operation is taking too long there.
I'm hoping Ceph logging redirection is set up so that stdout
or stderr from tcmalloc would show up in my log files?

-- Jim

> 
> sage
> 
> 


