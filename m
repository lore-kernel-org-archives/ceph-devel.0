From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Ceph performance improvement
Date: Thu, 23 Aug 2012 15:51:35 +1200
Message-ID: <5035A8C7.5050806@catalyst.net.nz>
References: <50349E62.90405@ledeuns.net> <5034B354.1040109@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:50061 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab2HWDvh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 23:51:37 -0400
In-Reply-To: <5034B354.1040109@cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David McBride <dwm37@cam.ac.uk>
Cc: Denis Fondras <ceph@ledeuns.net>, ceph-devel@vger.kernel.org

On 22/08/12 22:24, David McBride wrote:
> On 22/08/12 09:54, Denis Fondras wrote:
>
>> * Test with "dd" from the client using CephFS :
>> # dd if=/dev/zero of=testdd bs=4k count=4M
>> 17179869184 bytes (17 GB) written, 338,29 s, 50,8 MB/s
>
> Again, the synchronous nature of 'dd' is probably severely affecting 
> apparent performance.  I'd suggest looking at some other tools, like 
> fio, bonnie++, or iozone, which might generate more representative load.
>
> (Or, if you have a specific use-case in mind, something that generates 
> an IO pattern like what you'll be using in production would be ideal!)
>
>

Appending conv=fsync to the dd will make the comparison fair enough. 
Looking at the ceph code, it does


sync_file_range(fd, offset, blocksz, SYNC_FILE_RANGE_WRITE);

which is very fast - way faster than fdatasync() and friends (I have 
tested this ... see prev posting on random write performance with file 
writetest.c attached).

I am not convinced the these sort of tests are in any way 'unfair' - for 
instance I would like to use rbd for postgres or mysql data volumes... 
and many database actions involve a stream of block writes similar 
enough to doing dd (e.g bulk row loads, appends to transaction log 
journals).

Cheers

Mark
