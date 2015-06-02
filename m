From: Jason Dillaman <dillaman@redhat.com>
Subject: RBD journal draft design
Date: Tue, 2 Jun 2015 11:11:51 -0400 (EDT)
Message-ID: <1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com>
References: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:50139 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759064AbbFBPLw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2015 11:11:52 -0400
Received: from zmail12.collab.prod.int.phx2.redhat.com (zmail12.collab.prod.int.phx2.redhat.com [10.5.83.14])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id t52FBqeS029390
	for <ceph-devel@vger.kernel.org>; Tue, 2 Jun 2015 11:11:52 -0400
In-Reply-To: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I am posting to get wider review/feedback on this draft design.  In support of the RBD mirroring feature [1], a new client-side journaling class will be developed for use by librbd.  The implementation is designed to carry opaque journal entry payloads so it will be possible to be re-used in other applications as well in the future.  It will also use the librados API for all operations.  At a high level, a single journal will be composed of a journal header to store metadata and multiple journal objects to contain the individual journal entries.

Journal objects will be named "<journal object prefix>.<journal id>.<object number>".  An individual journal object will hold one or more journal entries, appended one after another.  Journal objects will have a configurable soft maximum size.  After the size has been exceeded, a new journal object (numbered current object + number of journal objects) will be created for future journal entries and the header active set will be updated so that other clients know that a new journal object was created.

In contrast to the current journal code used by CephFS, the new journal code will use sequence numbers to identify journal entries, instead of offsets within the journal.  Additionally, a given journal entry will not be striped across multiple journal objects.  Journal entries will be mapped to journal objects using the sequence number: <sequence number> mod <splay count> == <object number> mod <splay count> for active journal objects.

The rationale for this difference is to facilitate parallelism for appends as journal entries will be splayed across a configurable number of journal objects.  The journal API for appending a new journal entry will return a future which can be used to retrieve the assigned sequence number for the submitted journal entry payload once committed to disk. The use of a future allows for asynchronous journal entry submissions by default and can be used to simplify integration with the client-side cache writeback handler (and as a potential future enhacement to delay appends to the journal in order to satisfy EC-pool alignment requirements).

Sequence numbers are treated as a monotonically increasing integer for a given value of journal entry tag.  This allows for the possibility for multiple clients to concurrently use the same journal (e.g. all RBD disks within a given VM could use the same journal).  This will provide a loose coupling of operations between different clients using the same journal.

A new journal object class method will be used to submit journal entry append requests.  This will act as a gatekeeper for the concurrent client case.  A successful append will indicate whether or not the journal is now full (larger than the max object size), indicating to the client that a new journal object should be used.  If the journal is too large, an error code responce would alert the client that it needs to write to the current active journal object.  In practice, the only time the journaler should expect to see such a response would be in the case where multiple clients are using the same journal and the active object update notification has yet to be received.  

All the journal objects will be tied together by means of a journal header object, named "<journal header prefix>.<journal id>".  This object will contain the current committed journal entry positions of all registered clients.  In librbd's case, each mirrored copy of an image would be a new registered client.  OSD class methods would be used to create/manipulate the journal header to serialize modifications from multiple clients.

Journal recovery / playback will iterate through each journal entry from the journal, in sequence order.  Journal objects will be prefetched (where possible) to a configurable amount to improve the latency.  Journal entry playback can use an optional client-specified filter to only iterate over entries with a matching journal entry tag.  The API will need to support the use case of an external client periodically testing the journal for new data. 
 
Journal trimming will be accomplished by removing a whole journal object.  Only after all registered users of the journal have indicated that they have committed all journal entries within the journal object (via an update to the journal header metadata) will the journal object be deleted and the header updated to indicate the new starting object number.

Since the journal is designed to be append-only, there needs to be support for cases where journal entry needs to be updated out-of-band (e.g. fixing a corrupt entry similar to CephFS's current journal recovery tools).  The proposed solution is to just append a new journal entry with the same sequence number as the record to be replaced to the end of the journal (i.e. last entry for a given sequence number wins).  This also protects against accidental replays of the original append operation.  An alternative suggestion would be to use a compare-and-swap mechanism to update the full journal object with the updated contents.

Journal Header
~~~~~~~~~~~~~~

omap
* soft max object size
* journal objects splay count
* min object number
* most recent active journal objects (could be out-of-date)
* registered clients
  * client description (i.e. zone)
  * journal entry tag
  * last committed sequence number

Journal Object
~~~~~~~~~~~~~~~

Data
* 1..N: <Journal Entry>

Journal Entries
~~~~~~~~~~~~~~~

Header
* version
* tag
* sequence number
* data size

Data
* raw payload

Footer
* CRC of journal entry header + data

[1] http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/24929

-- 

Jason Dillaman 
Red Hat 
dillaman@redhat.com 
http://www.redhat.com 


