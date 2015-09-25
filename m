From: "Fox, Kevin M" <Kevin.Fox-MIjBx5DB8Ok@public.gmane.org>
Subject: Re: CephFS native driver
Date: Fri, 25 Sep 2015 16:05:38 +0000
Message-ID: <1A3C52DFCD06494D8528644858247BF01B7CAAC6@EX10MBOX06.pnnl.gov>
References: <CALe9h7datjEmxQ8i+pZPPXA_355o4wMs7MVH56eVrPACFjCKSg@mail.gmail.com>,
 <1886719958.21640286.1443164654402.JavaMail.zimbra@redhat.com>
Reply-To: "OpenStack Development Mailing List \(not for usage questions\)"
 <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <openstack-dev-bounces+god-openstack-dev=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1886719958.21640286.1443164654402.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.openstack.org/cgi-bin/mailman/options/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openstack.org/pipermail/openstack-dev>
List-Post: <mailto:openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev>,
 <mailto:openstack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject=subscribe>
Errors-To: openstack-dev-bounces+god-openstack-dev=m.gmane.org-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
To: "OpenStack Development Mailing List (not for usage questions)" <openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org>, John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I think having a native cephfs driver without nfs in the cloud is a very compelling feature. nfs is nearly impossible to make both HA and Scalable without adding really expensive dedicated hardware. Ceph on the other hand scales very nicely and its very fault tollerent out of the box.

Thanks,
Kevin
________________________________________
From: Shinobu Kinjo [skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
Sent: Friday, September 25, 2015 12:04 AM
To: OpenStack Development Mailing List (not for usage questions); John Spray
Cc: Ceph Development; openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org
Subject: Re: [openstack-dev] [Manila] CephFS native driver

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
From: "John Spray" <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
To: openstack-dev-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org, "Ceph Development" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
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
Unsubscribe: OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe
http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev

__________________________________________________________________________
OpenStack Development Mailing List (not for usage questions)
Unsubscribe: OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe
http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev

__________________________________________________________________________
OpenStack Development Mailing List (not for usage questions)
Unsubscribe: OpenStack-dev-request-ZwoEplunGu0gQVYkTtqAhEB+6BGkLq7r@public.gmane.org?subject:unsubscribe
http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev
