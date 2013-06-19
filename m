From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Erasure code library summary
Date: Wed, 19 Jun 2013 07:33:23 -0500
Message-ID: <51C1A513.8040604@inktank.com>
References: <51C05123.8000002@dachary.org> <51C196F8.4080501@inktank.com> <51C19FB1.7000700@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34800 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934022Ab3FSMdZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 08:33:25 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so13264761iec.33
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 05:33:24 -0700 (PDT)
In-Reply-To: <51C19FB1.7000700@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 06/19/2013 07:10 AM, Loic Dachary wrote:
>
>
> On 06/19/2013 01:33 PM, Mark Nelson wrote:
>> On 06/18/2013 07:22 AM, Loic Dachary wrote:
>>> Hi Ceph,
>>>
>>> TL;DR: use jerasure 1.2 with Reed-Solomon to code/decode/repair an object, and upgrade to 2.0 when available.
>>>
>>> Disclaimer: I'm no expert ;-) The terms are explained in wikipedia[1].
>>>
>>> Using Reed-Solomon object O is encoded by dividing it into consecutive chuncks O1, O2, ... ON and computing parity blocks P1, P2, ... PK.  Reading the original content of object O is a simple concatenation of O1, O2, ... ON. If O2 or P2 are lost, they can be repaired/reconstructed using O1 ... ON and P1 ... PK. If the use case is mostly reading objects and repairs are at least 1000 times less likely than normal operations, being able to read the object from non-coded chuncks is attractive.
>>>
>>> Reed-Solomon is significantly more expensive to encode ( 100MB/s order of magnitude on a single 2.5Ghz core ) than fountain codes with the current jerasure implementation[2]. However, gf-complete[3] that will be used in the upcoming version of jerasure significantly improves performances ( 2 to 10 times faster ) and the difference becomes negligible.
>>
>> One thing that we might consider is that ARM is very quickly becoming an option for Ceph.  It may be very important to have our erasure coding scheme be viable on that platform and CPU is going to be the primary bottleneck.  It may be worth a quick look at NEON to see if there are any things we should be thinking about now.
>
> Hi Mark,
>
> In another thread James Plank wrote that CPU usage is not going to be a problem as long as we're not trying to slice an object into more than 2^16 chunks ( the actual sentence is "I agree that the CPU burden of the GF arithmetic will not be a bottleneck in your system, regardless of which implementation you use, as long as you stay at or below GF(2^16)." http://article.gmane.org/gmane.comp.file-systems.ceph.devel/15650 ). It looks like we're aiming for something in the order of 10 data chunks + 5 parity chunks, i.e. much lower than 2^16. My hunch is that using more than 100 OSDs to code a single object would be problematic for reasons that are unrelated to the maths involved in coding it anyway.
>
> That being said I can look for/write benchmark code based on jerasure to run on ARM and get a rough idea of the CPU footprint, if you think it's worth it.

I don't want to add even more to your plate because you already have 
quite a bit here!  I just want to mention it because on ARM, CRC32c and 
general Ceph processing is already using a significant amount of the CPU 
resources.  I suspect that even highly optimized erasure coding 
implementations will be fighting for CPU on ARM (That may change though 
with some of the next generation ARM cores coming out next year).

>
> Cheers
>>
>>>
>>> Reed-Solomon coding family is the only one that can keep the chuncks unencoded and therefore concatenable.
>>>
>>> The jerasure library is packaged and being worked on by the author at the moment. All other Free Software implementations are either not packaged or not maintained.
>>>
>>> The license[4] of jerasure is compatible with the license of Ceph.
>>>
>>> Performances depend on the parameters to the Reed-Solomon functions but they will also be influenced by the buffer sizes used when calling the encoding functions: smaller buffers will mean more calls and more overhead.
>>>
>>> Open questions:
>>>
>>> * Does Mojette Transform [5] have compelling qualities compared to other code families ?
>>> * Do hierarchical codes [6] have compelling qualities ? Implementing them would require a different API. To be effective they need to take into account the context in which an object is stored where the other code only require the object itself.
>>> * I have not experiemented with the jerasure API yet
>>>
>>> Feedback and criticisms are welcome :-)
>>>
>>> [1] http://en.wikipedia.org/wiki/Erasure_code
>>> [2] jerasure 1.2 http://web.eecs.utk.edu/~plank/plank/papers/CS-08-627.html
>>> [3] gf-complete http://web.eecs.utk.edu/~plank/plank/papers/CS-13-703.html
>>> [4] jerasure license https://github.com/tsuraan/Jerasure/blob/master/License.txt
>>> [5] Mojette Transform http://en.wikipedia.org/wiki/Mojette_Transform
>>> [6] hierarchical codes http://www.e-biersack.eu/BPublished/nc_springer.pdf
>>>
>>>
>>
>

