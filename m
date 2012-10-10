From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Determining RBD storage utilization
Date: Wed, 10 Oct 2012 10:54:49 -0700
Message-ID: <5075B669.9020704@inktank.com>
References: <CACkq2mr17KKvgE0tWTvfs0UqpwtBaEMo84Twfs+26duUmC62Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53119 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120Ab2JJRyw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 13:54:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so969160pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 10:54:51 -0700 (PDT)
In-Reply-To: <CACkq2mr17KKvgE0tWTvfs0UqpwtBaEMo84Twfs+26duUmC62Mw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 10/10/2012 10:10 AM, Travis Rhoden wrote:
> Hey folks,
>
> I have two questions about determining how much storage has been used
> *inside* of an RBD.
>
> First, I'm confused by the output of df.  I've created, mapped, and
> mounted a 500GB RBD, and see the following:
>
> # df -h /srv/test
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/rbd44      500G  7.5G  467G   2% /srv/test
>
> # cd /srv/test
> # du -sh .
> 20K	.
>
>
> Any ideas way a brand-new, no files added mount shows 7.5GB of used
> space?  Does this happen from the file system formatting (ext4 in this
> case)?
> Additionally, 500G - 7.5G != 467G (the number shown as Avail).  Why
> the huge discrepancy?  I don't expect the numbers to add up exact due
> to rounding from kB, MB, GB, etc, but they should be darn close, a la
>
> df -h /dev/sda1
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sda1        15G  1.7G   13G  12% /
>
>
> Second question, is it possible to know how much storage has been used
> in the RBD without mounting it and running df or du?  For the same RBD
> as above, I see:
>
> # rbd info test
> rbd image 'test'':
> 	size 500 GB in 128000 objects
> 	order 22 (4096 KB objects)
> 	block_name_prefix: rb.0.18f9.2d9c66c6
> 	parent:  (pool -1)
>
> Is there perhaps a way to know the number of objects that have been
> 'used'?  Then I could take that and multiply by the object size (4MB).

You can get an upper bound by looking at the number of objects in the
image:

rados --pool rbd ls | grep -c '^rb\.0\.18f9\.2d9c66c6'

Each object represents a section of the block device, but they may not
be entirely filled (objects are sparse), so this will probably still be
a higher estimate than df. Also note that listing all the objects in a
pool is an expensive operation, so it shouldn't be done very often.

Josh

> I'm running 0.48.1argonaut on Ubuntu 12.04.
> RBD maps are also on Ubuntu 12.04, with the stock 3.2.0-29-generic kernel.
>
> Thanks,
>
>   - Travis


