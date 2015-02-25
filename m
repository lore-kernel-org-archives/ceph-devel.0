From: Varada Kari <Varada.Kari@sandisk.com>
Subject: RE: Adding a proprietary key value store to CEPH
Date: Wed, 25 Feb 2015 08:10:57 +0000
Message-ID: <C226B0AB34511445928D9882AA519F600A56A05B@SACMBXIP03.sdcorp.global.sandisk.com>
References: <C226B0AB34511445928D9882AA519F600A56972E@SACMBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502240819320.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0077.outbound.protection.outlook.com ([157.56.110.77]:12038
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751772AbbBYILD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 03:11:03 -0500
In-Reply-To: <alpine.DEB.2.00.1502240819320.25838@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

Thanks. Will wait for your reply.
Meanwhile, Can I submit a blue print for this for next release?

Thanks,
Varada

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Tuesday, February 24, 2015 10:21 PM
To: Varada Kari
Cc: Ceph Development
Subject: Re: Adding a proprietary key value store to CEPH

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

This sounds like a good approach to link to pretty much any external backend (modulo the dlopen part).  I need to check with lawyer types before I can promise we'll be able to merge something like this into the main ceph.git, though!

Thanks-
sage

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

