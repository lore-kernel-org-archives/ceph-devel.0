From: Jim Schutt <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 30 Mar 2011 15:26:15 -0600
Message-ID: <4D939FF7.1070104@sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>	 <1297893011.25491.124.camel@sale659.sandia.gov>	 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>	 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>	 <1297957574.25491.152.camel@sale659.sandia.gov>	 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>	 <1297985503.25491.175.camel@sale659.sandia.gov>	 <1299686572.4750.329.camel@sale659.sandia.gov>	 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>	 <1299695809.4750.346.camel@sale659.sandia.gov>	 <144B52A5BA504DCB992CD253287A397A@gmail.com>	 <1299798589.4750.372.camel@sale659.sandia.gov>	 <Pine.LNX.4.64.1103101515430.20133@cobra.newdream.net>	 <1299799936.4750.378.camel@sale659.sandia.gov>	 <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>	 <1299867988.4750.394.camel@s
 ale659.sandia.gov>	 <Pine.LNX.4.64.1103111036450.23902@cobra.newdream.net>	 <1299877982.4750.415.camel@sale659.sandia.gov> <Pine.LNX.4.64.1103111333190.23902@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:47927 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964815Ab1C3VoR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2011 17:44:17 -0400
In-Reply-To: <Pine.LNX.4.64.1103111333190.23902@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

Sage Weil wrote:
> On Fri, 11 Mar 2011, Jim Schutt wrote:
>> On Fri, 2011-03-11 at 11:37 -0700, Sage Weil wrote:
>>> On Fri, 11 Mar 2011, Jim Schutt wrote:
>>>> So none of those were osd_ping messages.
>>>>
>>>> But, I still had lots of delayed acks.  Here's a couple more examples:


> 
> Hmm!  That does seem to point at the allocator, doesn't it.
> 
> Other threads are doing work during this long interval?  Including freeing 
> memory, presumably, since basically everything uses the heap one way or 
> another.  If it's the allocator, it's somehow affecting one thread only, 
> which is pretty crazy.
> 
> Is it difficult for you to try this with tcmalloc?  That'll tell us 
> something.

I finally had a chance to rerun this testing, using
tcmalloc (from google-perftools v1.7) and libatomic_ops (v1.2-2)
against current next branch (commit a2ec936a7cd1c).

I still get lots of slow RefCountedObject::put calls.

> 
> One other possibility would be to try to catch this "in the act" and send 
> it a SIGABRT to get a core dump.  Then we can look in more detail at what 
> this (and other) threads are up to.  I'm not sure how easy this is to 
> catch on a particular node...

I'll try this next, assuming that using an assert
in RefCountedObject::put that() "delete this" takes
less than, say, 1 second will catch the state of
the other threads at an interesting place.

Does that sound OK?

-- Jim

> 
> sage
> 
> 

