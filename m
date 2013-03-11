From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Estimating OSD memory requirements (was Re: stuff for
 v0.56.4)
Date: Mon, 11 Mar 2013 12:01:55 -0600
Message-ID: <513E1C13.50104@sandia.gov>
References: <201303111510.r2BFAUcx011721@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:39156 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab3CKSCj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 14:02:39 -0400
In-Reply-To: <201303111510.r2BFAUcx011721@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bkw1a@ayesha.phys.virginia.edu
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Hi Bryan,

On 03/11/2013 09:10 AM, Bryan K. Wright wrote:
> sage@inktank.com said:
>> On Thu, 7 Mar 2013, Bryan K. Wright wrote:
>>
>> sage@inktank.com said:
>>> - pg log trimming (probably a conservative subset) to avoid memory bloat 
>>
>> Anything that reduces the size of OSD processes would be appreciated.
>> You can probably do this with just
>>  log max recent = 1000
>> By default it's keeping 100k lines of logs in memory, which can eat a lot  of
>> ram (but is great when debugging issues).
> 
> 	Thanks for the tip about "log max recent".  I've made this 
> change, but it doesn't seem to significantly reduce the size of the 
> OSD processes.
> 
> 	In general, are there some rules of thumb for estimated the
> memory requirements for OSDs?  I see processes blow up to 8gb of 
> resident memory sometimes.  If I need to allow for that much memory
> per OSD process, I may have to just walk away from ceph.
> 
> 	Does the memory usage scale with the size of the disks?
> I've been trying to run 12 OSDs with 12 2TB disks on a single box.
> Would I be better off (memory-usage-wise) if I RAIDed the disks
> together and used a single OSD process?
> 
> 	Thanks for any advice.

You might also try tuning "osd client message size cap"; its
current default is 500 MiB.

During the periods your aggregate applied write load is higher
than your OSD aggregate write bandwidth (taking into account
replicas), you'll be buffering up this amount of client data.

Since it only applies to incoming client messages, to figure
total memory use I believe you need to multiply that by the
number of replicas you're using.

FWIW, for sequential writes from lots of clients, I can
maintain full write bandwidth with "osd client message size
cap" tuned to 60 MiB.

-- Jim

> 
> 					Bryan
> 
> 


