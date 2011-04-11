From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Mon, 11 Apr 2011 14:14:25 -0600
Message-ID: <4DA36121.40808@sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <4D9F367B.1070904@sandia.gov>
 <Pine.LNX.4.64.1104081343460.15928@cobra.newdream.net>
 <4D9F87F7.6090203@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:49964 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000Ab1DKUOp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 16:14:45 -0400
In-Reply-To: <4D9F87F7.6090203@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Jim Schutt wrote:
> Sage Weil wrote:

> 
>>
>> I guess the other thing that would help to confirm this is to just 
>> halve the number of OSDs on your machines in a test and see if the 
>> problem goes away.
> 
> I was going to try this first, exactly because it seems like
> a definitive test.
> 

FWIW, I've done some testing on a file system using 48 OSDs
rather than 96.

With the 96-OSD version of this test (12 servers, 8 OSD/server),
with 64 clients writing a total of 128 GiB data, I usually see
multiple instances (5-6, or more, is common) of OSDs getting
marked down, noticing they were wrongly marked down, and coming back.

With the 48-OSD version of the file system (12 servers, 4 OSD/server)
I ran multiple tests, totaling several TiB data, and experienced
exactly one instance on an OSD being wrongly marked down.

-- Jim

