From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: CephFS Space Accounting and Quotas
Date: Mon, 18 Mar 2013 08:19:07 -0600
Message-ID: <5147225B.5060702@sandia.gov>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
 <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
 <513793FD.7010001@sandia.gov>
 <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com>
 <51379FCD.9000502@sandia.gov>
 <D19243567199482692F961618A335817@inktank.com>
 <5137B4E9.1030505@sandia.gov>
 <1856965A675D4D5D971D5DC9AB01C657@inktank.com>
 <5137CDE2.70105@sandia.gov>
 <8B6963669A2E49C286B9241DCD62F557@inktank.com>
 <5138AEFB.5070200@sandia.gov> <513A69F8.6050709@sandia.gov>
 <391D23EA41AE4F05BCE2E6367BA0FC3C@inktank.com>
 <513DEE83.8030909@sandia.gov>
 <114836C3F596429AAB29E98225A25E1B@inktank.com>
 <513E0AF7.7050108@sandia.gov>
 <90B756938EF64998B9230F4E48620CDE@inktank.com>
 <513E4124.9040309@sandia.gov> <513FAD59.4040205@sandia.gov>
 <513FAE0F.2010608@sandia.gov>
 <BE627BF4B6E74BD49037D07821FC1DB9@inktank.com>
 <5143AA84.50409@sandia.gov>
 <0B3FC8A87058441CAB834F4995E6C8C6@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:51490 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab3CROTZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Mar 2013 10:19:25 -0400
In-Reply-To: <0B3FC8A87058441CAB834F4995E6C8C6@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel@vger.kernel.org

On 03/15/2013 05:17 PM, Greg Farnum wrote:
> [Putting list back on cc]
> 
> On Friday, March 15, 2013 at 4:11 PM, Jim Schutt wrote:
> 
>> On 03/15/2013 04:23 PM, Greg Farnum wrote:
>>> As I come back and look at these again, I'm not sure what the context
>>> for these logs is. Which test did they come from, and which behavior
>>> (slow or not slow, etc) did you see? :) -Greg
>>
>>
>>
>> They come from a test where I had debug mds = 20 and debug ms = 1
>> on the MDS while writing files from 198 clients. It turns out that 
>> for some reason I need debug mds = 20 during writing to reproduce
>> the slow stat behavior later.
>>
>> strace.find.dirs.txt.bz2 contains the log of running 
>> strace -tt -o strace.find.dirs.txt find /mnt/ceph/stripe-4M -type d -exec ls -lhd {} \;
>>
>> From that output, I believe that the stat of at least these files is slow:
>> zero0.rc11
>> zero0.rc30
>> zero0.rc46
>> zero0.rc8
>> zero0.tc103
>> zero0.tc105
>> zero0.tc106
>> I believe that log shows slow stats on more files, but those are the first few.
>>
>> mds.cs28.slow-stat.partial.bz2 contains the MDS log from just before the
>> find command started, until just after the fifth or sixth slow stat from
>> the list above.
>>
>> I haven't yet tried to find other ways of reproducing this, but so far
>> it appears that something happens during the writing of the files that
>> ends up causing the condition that results in slow stat commands.
>>
>> I have the full MDS log from the writing of the files, as well, but it's
>> big....
>>
>> Is that what you were after?
>>
>> Thanks for taking a look!
>>
>> -- Jim
> 
> I just was coming back to these to see what new information was
> available, but I realized we'd discussed several tests and I wasn't
> sure what these ones came from. That information is enough, yes.
> 
> If in fact you believe you've only seen this with high-level MDS
> debugging, I believe the cause is as I mentioned last time: the MDS
> is flapping a bit and so some files get marked as "needsrecover", but
> they aren't getting recovered asynchronously, and the first thing
> that pokes them into doing a recover is the stat.

OK, that makes sense.

> That's definitely not the behavior we want and so I'll be poking
> around the code a bit and generating bugs, but given that explanation
> it's a bit less scary than random slow stats are so it's not such a
> high priority. :) Do let me know if you come across it without the
> MDS and clients having had connection issues!

No problem - thanks!

-- Jim


> -Greg
> 
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> 
> 
> 


