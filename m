From: Sage Weil <sweil@redhat.com>
Subject: per-pool bluestore options
Date: Sat, 13 Aug 2016 18:56:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608131843050.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43398 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbcHNJDd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 14 Aug 2016 05:03:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ifedotov@mirantis.com
Cc: ceph-devel@vger.kernel.org

Hi Igor,

I took another look at

	https://github.com/ceph/ceph/pull/10556

You define three settings:

 compress_hint - determines if pool contains compressible / incompressible data
 compress_algorithm - permits to specify different compression algorithm
 compress_ratio - specifies maximum compression ratio

I think we should extend this to include csum-related options.  And use a 
consistent naming scheme that aligns with the config options where we just 
strip off the bluestore_ prefix.  The relevant options are:

 bluestore_csum = {true, false}
 bluestore_csum_type = {crc32c, crc32c_{8,16}, ...}
 bluestore_csum_min_chunk_size = 4k      (*)
 bluestore_csum_max_chunk_size = 64k     (*)

 bluestore_compression = {force, aggressive, passive, none}
 bluestore_compression_algorithm = {snappy, zlib, ...}
 bluestore_compression_min_blob_size = 256k
 bluestore_compression_max_blob_size = 4M
 bluestore_compression_required_ratio = .875

(*) These currently have a different name but aren't used yet.  Working on 
a PR to change that.

What's missing is your 'compress_hint'.  We can call that 
'compression_hint' to align with the names above?

 compression_hint = {compressible, incompressible, ...}

The main changes from your PR that I think we need to make are:

* These options should be part of the pool_opts_t structure in pg_pool_t 
(which is a set of optional key/value-like parameters for the pool).

* We can add a new ObjectStore operation that passes down parameters for a 
collection, and have the OSD pass these all in for each PG collection when 
the pool properties change.  That way ObjectStore doesn't need to persist 
these options at all--just store the ones it understands in memory, and 
the OSD will always reset them on startup etc.

What do you think?

sage
