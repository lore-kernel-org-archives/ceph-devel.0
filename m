From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Richacls
Date: Thu, 26 Feb 2015 16:54:42 +0100
Message-ID: <54EF41C2.5080700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39816 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976AbbBZPyq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 10:54:46 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: gluster-devel@gluster.org, ceph-devel@vger.kernel.org

Hi everyone,

I've posted an updated version of the richacl kernel patches and
user-space bits earlier today [1].  This should give anyone interested
in the topic a chance to get richacls up and running locally, on ext4,
to get a feeling of how they work.  See the richacl homepage [2] for
instructions on getting started, some examples, and some bits of
background information.

Some of you are interested in supporting richacls in glusterfs and ceph.
 This will require richacl permission checking in user space; I would
suggest to use librichacl for doing that.  There's a new
richacl_permission() function there for that currently declared as follows:

  /**
   * richacl_permission  -  check if a user has the requested access
   * @acl:        ACL of the file to check
   * @owner:      Owner of the file
   * @owning_group: Owning group of the file
   * @user:       User ID of the accessing process
   * @groups:     Group IDs the accessing process is a member in
   * @n_groups:   Number of entries in @groups
   * @mask:       Requested permissions (ACE4_* mask flags)
   */
 bool richacl_permission(struct richacl *acl, uid_t owner,
                         gid_t  owning_group, uid_t user,
                         const gid_t *groups, int n_groups,
                         unsigned int mask)

Is this interface suitable?

Note that full permission checking often requires more than just a
single richacl_permission() check: for example, deleting files is
restricted to the owner in sticky directories; other mechanisms like
capabilities may play a role as well.

Some documentation on how the various richacl permission bits are
supposed to work can be found in the kernel patches.  In addition, the
test cases in the richacl package are supposed to also document and test
all the corner cases; they are not perfect yet though.

Librichacl exports functions for converting from richacl extended
attributes to librichacl's internal representation and back now.  This
should allow to pass around the richacl xattr blobs and feed them to
librichacl for permission checking and other richacl manipulations.

  [1] http://lwn.net/Articles/634870/
  [2] http://www.bestbits.at/richacl/

Thanks,
Andreas
