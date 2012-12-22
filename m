From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Bobtail vs Argonaut Performance Preview
Date: Sat, 22 Dec 2012 13:44:15 -0600
Message-ID: <50D60D8F.6020708@inktank.com>
References: <CAP8Oy=J6kazDvT6woLZZ3v+XVrzhKbHgO1wgyoTU8OCKq2qDEg@mail.gmail.com> <20121222083200.GA1977@infradead.org> <50D5B769.4090104@inktank.com> <20121222184508.GA32567@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64834 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab2LVToR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Dec 2012 14:44:17 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so7711817iea.2
        for <ceph-devel@vger.kernel.org>; Sat, 22 Dec 2012 11:44:17 -0800 (PST)
In-Reply-To: <20121222184508.GA32567@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>

On 12/22/2012 12:45 PM, Christoph Hellwig wrote:
> On Sat, Dec 22, 2012 at 07:36:41AM -0600, Mark Nelson wrote:
>> Btw Christoph, thank you for taking the time to read my article.  If
>> I've done anything dumb or suboptimal regarding xfs, please do let
>> me know.  Soon I will be doing parametric sweeps over ceph parameter
>> spaces to see how performance varies on different hardware
>> configurations.  I want to make sure the tests are setup as
>> optimally as possible.
>
> You're defintively missing the "inode64" mount option, which we've
> always recommended, and which finally made it to be the default in
> Linux 3.7.
>

Is inode64 typically faster than inode32?  I thought I remembered 
dchinner saying that the situation wasn't always particularly clear and 
it depended on the workload.  Having said that, I can't really see it 
not being a good thing for Ceph to spread metadata out over all of the 
AGs, especially in the multi-disk raid config.  I'll use it for the next 
set of tests.

> Some other things worth playing with, but which aren't guaranteed to
> be a win are:
>
>   - use a larger than default log size (e.g. mkfs.xfs -l size=2g)
>   - use large directory blocks, similar to what you already do for btrfs
>     (mkfs.xfs -n size=16k or 64k)

I'll definitely give them a try at some point.  Thanks for the tips 
Christoph!

>
> Also at least for the benchmarks doing concurrent I/O (or any real life
> setup) you're probably much better off with a concatenation than a RAID 0
> for the multiple disk setup.
>


