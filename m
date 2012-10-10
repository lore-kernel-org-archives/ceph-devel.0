From: Travis Rhoden <trhoden@gmail.com>
Subject: Determining RBD storage utilization
Date: Wed, 10 Oct 2012 13:10:43 -0400
Message-ID: <CACkq2mr17KKvgE0tWTvfs0UqpwtBaEMo84Twfs+26duUmC62Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:44424 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab2JJRLF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 13:11:05 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so671725qaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 10:11:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey folks,

I have two questions about determining how much storage has been used
*inside* of an RBD.

First, I'm confused by the output of df.  I've created, mapped, and
mounted a 500GB RBD, and see the following:

# df -h /srv/test
Filesystem      Size  Used Avail Use% Mounted on
/dev/rbd44      500G  7.5G  467G   2% /srv/test

# cd /srv/test
# du -sh .
20K	.


Any ideas way a brand-new, no files added mount shows 7.5GB of used
space?  Does this happen from the file system formatting (ext4 in this
case)?
Additionally, 500G - 7.5G != 467G (the number shown as Avail).  Why
the huge discrepancy?  I don't expect the numbers to add up exact due
to rounding from kB, MB, GB, etc, but they should be darn close, a la

df -h /dev/sda1
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        15G  1.7G   13G  12% /


Second question, is it possible to know how much storage has been used
in the RBD without mounting it and running df or du?  For the same RBD
as above, I see:

# rbd info test
rbd image 'test'':
	size 500 GB in 128000 objects
	order 22 (4096 KB objects)
	block_name_prefix: rb.0.18f9.2d9c66c6
	parent:  (pool -1)

Is there perhaps a way to know the number of objects that have been
'used'?  Then I could take that and multiply by the object size (4MB).

I'm running 0.48.1argonaut on Ubuntu 12.04.
RBD maps are also on Ubuntu 12.04, with the stock 3.2.0-29-generic kernel.

Thanks,

 - Travis
