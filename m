From: Sage Weil <sage@newdream.net>
Subject: Re: A way to reduce compression overhead
Date: Tue, 8 Nov 2016 20:27:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611082019530.29278@piezo.us.to>
References: <828b8988-5c29-8ec3-be00-e6c45fa15ab0@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57937 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753412AbcKHU1k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 15:27:40 -0500
In-Reply-To: <828b8988-5c29-8ec3-be00-e6c45fa15ab0@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 8 Nov 2016, Igor Fedotov wrote:
> Hi Sage, et al.
> 
> Let me share some ideas about possible compression burden reduction on the
> cluster.
> 
> As known we perform block compression at BlueStore level for each replica
> independently. This triples compression CPU overhead for the cluster. Looks
> like significant CPU resource waste IMHO.
> 
> We can probably eliminate this overhead by introduction write request
> preprocessing performed at ObjectStore level synchronously. This preprocessing
> parses transaction, detects write requests and transforms them into different
> ones aligned with current store allocation unit. At the same time resulting
> extents that span more than single AU are compressed if needed. I.e.
> preprocessing do some of the job performed at BlueStore::_do_write_data that
> splits write request into _do_write_small/_do_write_big calls. But after the
> split and big blob compression preprocessor simply updates the transaction
> with new write requests.
> 
> E.g.
> 
> with AU = 0x1000
> 
> Write Request (1~0xffff) is transformed into the following sequence:
> 
> WriteX 1~0xfff (uncompressed)
> 
> WriteX 0x1000~E000 (compressed if needed)
> 
> WriteX 0xf000~0xfff (uncompressed)
> 
> Then updated transaction is passed to all replicas including the master one
> using regular apply_/queue_transaction mechanics.
> 
> 
> As a bonus one receives automatic payload compression when transporting
> request to remote store replicas.
> Regular write request path should be preserved for EC pools and other needs as
> well.
> 
> Please note that almost no latency is introduced for request handling.
> Replicas receive modified transaction later but they do not spend time on
> doing split/compress stuff.

I think this is pretty reasonable!  We have a couple options... we could 
(1) just expose a compression alignment via ObjectStore, (2) take 
compression alignment from a pool property, or (3) have an explicit 
per-write call into ObjectStore so that it can chunk it up however it 
likes.  

Whatever we choose, the tricky bit is that there may be different stores 
on different replicas.  Or we could let the primary just decide locally, 
given that this is primarily an optimization; in the worst case we 
compress something on the primary but one replica doesn't support 
compression and just decompresses it before doing the write (i.e., we get 
on-the-wire compression but no on-disk compression).

I lean toward the simplicity of get_compression_alignment() and 
get_compression_alg() (or similar) and just make a local (primary) 
decision.  Then we just have a simple compatibility write_compressed() 
implementation (or helper) that decompresses the payload so that we can do 
a normal write.

Before getting to carried away, though, we should consider whether we're 
going to want to take a further step to allow clients to compress data 
before it's sent.  That isn't necessarily in conflict with this if we go 
with pool properties to inform the alignment and compression alg 
decision.  If we assume that the ObjectStore on the primary gets to decide 
everything it will work less well...

> There is a potential conflict with the current garbage collection stuff though
> - we can't perform GC during preprocessing due to possible race with preceding
> unfinished transactions and consequently we're unable to merge and compress
> merged data. Well, we can do that when applying transaction but this will
> produce a sequence like this at each replica:
> 
> decompress original request + decompress data to merge -> compress merged
> data.
> 
> Probably this limitation isn't that bad - IMHO it's better to have compressed
> blobs aligned with original write requests.
> 
> Moreover I have some ideas how to get rid of blob_depth notion that makes life
> a bit easier. Will share shortly.

I'm curious what you have in mind!  The blob_depth as currently 
implemented is not terribly reliable...

sage
