From: Sage Weil <sage@newdream.net>
Subject: Re: Adding a proprietary key value store to CEPH
Date: Tue, 24 Feb 2015 08:51:17 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502240819320.25838@cobra.newdream.net>
References: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32873 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbbBXQvS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Feb 2015 11:51:18 -0500
In-Reply-To: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Varada,

On Tue, 24 Feb 2015, Varada Kari wrote:
> Hi Sage,
> 
> We are trying to integrate a new proprietary key value store to CEPH. To integrate this KV-store, which is a closed source shared library, we propose a new class to CEPH called PropDBStore which does a dlopen and imports the required symbols. This framework will help in integrating vendor specific extensions to CEPH.
> 
> The gist of the implementation is as follows.
> 
> 1. Implement a wrapper around the proprietary KVStore. Let us call it as KVExtension. This is a shared library which implements all interfaces required by CEPH KeyValueStore.
> 2. A new class is derived from KeyValueDB called PropDBStore, which honors the semantics of KeyvalueStore and KeyValueDB. This class acts as mediator between CEPH and KVExtension.  This class transforms bufferlist etc... to const char pointers or strings for the extension to understand.
> 3. PropDBStore, loads (dlopen) the KVExtension during OSD initialization.  Path to the KVExtension can be mentioned in ceph.conf.
> 4. Interfaces that needs to be implemented in KVExtension, which are imported by the PropDBStore are added in a new header called PropDBWrapper.h.  This header contains the signatures for the necessary interfaces like init(), close(), submit_transaction(), get() and get_iterator(). Similarly for Iterator functionality, PropDBIterator.h, which specifies the signatures of seek_to_first (), seek_to_last(), lower_bound() and upper_bound() etc...  PropDBStore includes these headers to import the symbols, using dlsym().
> 5. Choosing the proprietary DB as Backend to the OSD is controlled/managed by config options of the ceph (/etc/ceph/ceph.conf) like rocksdb or leveldb.
> 6. Rest of the existing functionality is not disturbed by this change. Changing the osd backend option will change backend implementation. But this change is not dynamic. The type of the backend should be chosen at osd creation time and osd will continue use that backend till that osd is reformatted again.
> 7. The new KVStore we are trying to integrate works on a raw partition, so we divided the osd drive into two partitions. One partition is given to osd Meta data (super block, fsid etc...), and the other is given to the new db to manage it. OSD partition is now not the entire disk, but 2-4GB which needed for the metadata.

This sounds like a good approach to link to pretty much any external 
backend (modulo the dlopen part).  I need to check with lawyer types 
before I can promise we'll be able to merge something like this into the 
main ceph.git, though!

Thanks-
sage
