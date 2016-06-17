From: Sage Weil <sweil@redhat.com>
Subject: Re: encoding
Date: Fri, 17 Jun 2016 17:02:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606171657530.21827@piezo.us.to>
References: <BLUPR0201MB1524E3853169E4292D16F710E8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1582906287-1466182970=:21827"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755554AbcFQRC4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Jun 2016 13:02:56 -0400
In-Reply-To: <BLUPR0201MB1524E3853169E4292D16F710E8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1582906287-1466182970=:21827
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

On Fri, 17 Jun 2016, Allen Samuels wrote:
> I don¢t understand the ref_map and unused stuff. What is their purpose?

ref_map:

We allocate blobs and write uncompressed data in.  Later, we logically 
overwrite part of that reference, such that our big 1MB allocation only 
has part of it referenced.  When that happens we want to release the 
unreferenced part back to the allocator for use by something else.  
ref_map lets us do that, which some additional complexity that counts 
references (from multiple clones).

unused:

We might allocate a full min_alloc_size but only write one block into it.  
If we do another small write in an adjacent block, we want to write 
into the existing blob.  In order to do that without with a WAL event, we 
need to know that the block isn't currently referenced by anything.  
ref_map isn't quite sufficient for this because we don't have a 
complicated commit/persist lifecycle sequence on update, and we need to 
make sure the *committed* state has no references before we can safely 
overwrite a block.

After pondering this a while I decided that would be very complex to 
implement that, with marginal benefit, and in reality this mostly matters 
for newly-allocated but never-written blobs... hence unused.  I decided we 
don't care the case when you partially occlude part of a blob (but less 
that min_alloc_size so it wasn't released back to the allocator) and 
*then* also do a small overwrite such that the space could be reused.

sage
--8323329-1582906287-1466182970=:21827--
