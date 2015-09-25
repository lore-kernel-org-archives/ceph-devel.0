From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: [openstack-dev] [Manila] CephFS native driver
Date: Fri, 25 Sep 2015 03:04:14 -0400 (EDT)
Message-ID: <1886719958.21640286.1443164654402.JavaMail.zimbra@redhat.com>
References: <CALe9h7datjEmxQ8i+pZPPXA_355o4wMs7MVH56eVrPACFjCKSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:52669 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557AbbIYHEP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Sep 2015 03:04:15 -0400
In-Reply-To: <CALe9h7datjEmxQ8i+pZPPXA_355o4wMs7MVH56eVrPACFjCKSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, openstack-dev@lists.openstack.org

So here are questions from my side.
Just question.


 1.What is the biggest advantage comparing others such as RDB?
  We should be able to implement what you are going to do in
  existing module, shouldn't we?

 2.What are you going to focus on with a new implementation?
  It seems to be to use NFS in front of that implementation
  with more transparently.

 3.What are you thinking of integration with OpenStack using
  a new implementation?
  Since it's going to be new kind of, there should be differ-
  ent architecture.

 4.Is this implementation intended for OneStack integration 
  mainly?

Since velocity of OpenStack feature expansion is much more than 
it used to be, it's much more important to think of performance.

Is a new implementation also going to improve Ceph integration
with OpenStack system?
 
Thank you so much for your explanation in advance.

Shinobu 

----- Original Message -----
From: "John Spray" <jspray@redhat.com>
To: openstack-dev@lists.openstack.org, "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Thursday, September 24, 2015 10:49:17 PM
Subject: [openstack-dev] [Manila] CephFS native driver

Hi all,

I've recently started work on a CephFS driver for Manila.  The (early)
code is here:
https://github.com/openstack/manila/compare/master...jcsp:ceph

It requires a special branch of ceph which is here:
https://github.com/ceph/ceph/compare/master...jcsp:wip-manila

This isn't done yet (hence this email rather than a gerrit review),
but I wanted to give everyone a heads up that this work is going on,
and a brief status update.

This is the 'native' driver in the sense that clients use the CephFS
client to access the share, rather than re-exporting it over NFS.  The
idea is that this driver will be useful for anyone who has such
clients, as well as acting as the basis for a later NFS-enabled
driver.

The export location returned by the driver gives the client the Ceph
mon IP addresses, the share path, and an authentication token.  This
authentication token is what permits the clients access (Ceph does not
do access control based on IP addresses).

It's just capable of the minimal functionality of creating and
deleting shares so far, but I will shortly be looking into hooking up
snapshots/consistency groups, albeit for read-only snapshots only
(cephfs does not have writeable shapshots).  Currently deletion is
just a move into a 'trash' directory, the idea is to add something
later that cleans this up in the background: the downside to the
"shares are just directories" approach is that clearing them up has a
"rm -rf" cost!

A note on the implementation: cephfs recently got the ability (not yet
in master) to restrict client metadata access based on path, so this
driver is simply creating shares by creating directories within a
cluster-wide filesystem, and issuing credentials to clients that
restrict them to their own directory.  They then mount that subpath,
so that from the client's point of view it's like having their own
filesystem.  We also have a quota mechanism that I'll hook in later to
enforce the share size.

Currently the security here requires clients (i.e. the ceph-fuse code
on client hosts, not the userspace applications) to be trusted, as
quotas are enforced on the client side.  The OSD access control
operates on a per-pool basis, and creating a separate pool for each
share is inefficient.  In the future it is expected that CephFS will
be extended to support file layouts that use RADOS namespaces, which
are cheap, such that we can issue a new namespace to each share and
enforce the separation between shares on the OSD side.

However, for many people the ultimate access control solution will be
to use a NFS gateway in front of their CephFS filesystem: it is
expected that an NFS-enabled cephfs driver will follow this native
driver in the not-too-distant future.

This will be my first openstack contribution, so please bear with me
while I come up to speed with the submission process.  I'll also be in
Tokyo for the summit next month, so I hope to meet other interested
parties there.

All the best,
John

__________________________________________________________________________
OpenStack Development Mailing List (not for usage questions)
Unsubscribe: OpenStack-dev-request@lists.openstack.org?subject:unsubscribe
http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev
