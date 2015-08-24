From: Matt Benjamin <mbenjamin@redhat.com>
Subject: handle-based object store
Date: Mon, 24 Aug 2015 11:50:45 -0400 (EDT)
Message-ID: <634542282.7893067.1440431445910.JavaMail.zimbra@redhat.com>
References: <1141157085.7889185.1440430914232.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:56504 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbbHXPuq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 11:50:46 -0400
In-Reply-To: <1141157085.7889185.1440430914232.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Casey Bodley <cbodley@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

(11:37:44 AM) mattbenjamin: sjusthm, cbodley:  Casey and I think it might be useful to have a short video call on the meet points between object and collection handle as we did it, and the other objectstore changes; I don't know which aspects really should port over to master, but I think it would be useful to do a walk-through and discussion of what parts we could retarget, and anything that we could sequence cleanly later.
(11:38:06 AM) mattbenjamin: sjusthm, cbodley: do you have a bit of time available?

Some of the pieces we had:

1. the handle interface change itself
2. indexed slots for collection and object handles or ids (unions, iirc) in Transaction, and efficient operations to fill slots
3. probably more flexbility than needed in that every OS could completely redefine Collection and Object
4. lifecycle and refcounting which worked correctly
5. an Object hierarchy we actually used in our version of filestore, w/concurrent LRU system
6. a set of changes by Casey replacing the FDRef system w/management of objects--some of this could be useful, I don't know how it maps onto newstore at all
7. a unification of ObjectContext and opaque Object which we were debating in Oregon
8. thread-local caches of collections and objects above the OS interface that appeared to be a big help in IOPs work

ok, apparently we're on for 11:00 am pst--I'll send an invite

Matt 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-761-4689
fax.  734-769-8938
cel.  734-216-5309

