From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Patches for review on keyvaluestore
Date: Thu, 9 Jul 2015 08:31:31 +0000
Message-ID: <C226B0AB34511445928D9882AA519F601C4400B3@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0060.outbound.protection.outlook.com ([157.56.111.60]:30912
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750936AbbGIKFa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 06:05:30 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Samuel Just <sam.just@inktank.com>, Haomai Wang <haomaiwang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage/Sam/Haomai,

Sent pull requests for two enhancement for key value store. Can you please review the changes?

https://github.com/ceph/ceph/pull/5136

Contains changes for short circuiting op_wq and osr in key value store. We have observed good performance gains with the above pull request. Not sure if it breaks any assumptions or design constraints. Need your comments on the approach.

https://github.com/ceph/ceph/pull/5169

Contains changes for adding a generic framework to add any keyvaluedb as a backend.  There are code made for initial proposal on the infernalis blueprint. Other enhancement proposed are being worked on as loadable object store using a factory approach.

Gist of the implementation sent for review:

1. A new class is derived from KeyValueDB (Derived from ObjectStore) called PluggableDBStore, which honors the semantics of KeyvalueStore and KeyValueDB. This class acts as mediator between CEPH and loadable shim (a shared library).  This class transforms the ceph related bufferlist etc... to const char pointers for the shim to understand.
2. Shim layer is assumed to be a shared library.
3. PluggableDBStore, loads (dlopen) the key value database wrapper/shim needed for Ceph integration.  The loadable shim library location is specified in ceph.conf. Not added any checks to validate the sanity or compatibility of shared object as of now. We can impose certain checks to be honored by the shim layer to be compatible with the ceph version.
4. Interfaces that needs to be implemented in shim, are added in a new header called PluggableDBInterfaces.h.  This header contains the signatures for the necessary interfaces like init(), close(), submit_transaction(), get() and get_iterator(). PluggableDBStore caches these handles in a table during the initialization time of the backend db.
5. Similarly for Iterator functionality, PluggableDBIterator.h, contains the functionality to be implemented by the shim layer.
6. ceph-disk is modified to make two partitions of the osd disk given, one for osd metadata and other for the pluggable DB, similar to existing functionality like journal and osd data partition. Two partitions are created only when PluggableDBstore is selected as backed for OSD.  DB's can work off a raw partition as well, having a partition can enable to them use it. May be we can add additional parameters or conf options to have a file system also on the newly created partition, which can be implemented by ceph-disk.
7. Partition information and other information needed like osd id etc... are passed to shim layer at the time of initializing the store.
8. Additional script modification is get correct stats from the backend.

Please share your comments on the pull requests.

Thanks,
Varada




________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

