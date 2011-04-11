From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Mon, 11 Apr 2011 15:18:35 -0600
Message-ID: <4DA3702B.4010808@sandia.gov>
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
Received: from sentry-three.sandia.gov ([132.175.109.17]:55397 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795Ab1DKVS7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 17:18:59 -0400
In-Reply-To: <4D9F87F7.6090203@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Jim Schutt wrote:
> Sage Weil wrote:
>> On Fri, 8 Apr 2011, Jim Schutt wrote:

>>> So, in the short term I guess I need to run fewer cosd
>>> instances per server.
>>
>> There is one other thing to look at, and that's the number of threads 
>> used by each cosd process.  Have you tried setting
>>
>>     osd op threads = 1
>>
>> (or even 0, although I haven't tested that recently).  That will limit 
>> the number of concurrent IOs in flight to the fs.  Setting it to 0 
>> will avoid using a thread pool at all and will process the IO in the 
>> message dispatch thread (though we haven't tested that recently so 
>> there may be issues).
> 
> I'll try this 2nd, since it's easy.
> 
      osd op threads = 0

didn't work for me at all - 20 of 96 OSDs aborted almost
immediately after startup.

      osd op threads = 1

didn't work very well either - one of my servers went OOM,
which hasn't happened since I started using my restricted
buffering parameters.

It really does seem like I'm just trying to do too much
work on each server.  If I back off to 4 OSDs/server on
my  hardware, there's a few percent idle cycles, making
interacting with it much more pleasant.

-- Jim

