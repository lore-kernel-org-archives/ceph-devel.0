From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: v12.0.2 Luminous (dev) released
Date: Mon, 24 Apr 2017 17:49:06 +0200
Message-ID: <319cffed-6ef8-bb3f-186a-77b2be62a2db@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56145 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971824AbdDXPtI (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 24 Apr 2017 11:49:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

This is the third development checkpoint release of Luminous, the next
long term
stable release.

Major changes from v12.0.1
--------------------------
* The original librados rados_objects_list_open (C) and objects_begin
  (C++) object listing API, deprecated in Hammer, has finally been
  removed.  Users of this interface must update their software to use
  either the rados_nobjects_list_open (C) and nobjects_begin (C++) API or
  the new rados_object_list_begin (C) and object_list_begin (C++) API
  before updating the client-side librados library to Luminous.

  Object enumeration (via any API) with the latest librados version
  and pre-Hammer OSDs is no longer supported.  Note that no in-tree
  Ceph services rely on object enumeration via the deprecated APIs, so
  only external librados users might be affected.

  The newest (and recommended) rados_object_list_begin (C) and
  object_list_begin (C++) API is only usable on clusters with the
  SORTBITWISE flag enabled (Jewel and later).  (Note that this flag is
  required to be set before upgrading beyond Jewel.)

* CephFS clients without the 'p' flag in their authentication capability
  string will no longer be able to set quotas or any layout fields.  This
  flag previously only restricted modification of the pool and namespace
  fields in layouts.

* CephFS directory fragmentation (large directory support) is enabled
  by default on new filesystems.  To enable it on existing filesystems
  use "ceph fs set <fs_name> allow_dirfrags".

* CephFS will generate a health warning if you have fewer standby daemons
  than it thinks you wanted.  By default this will be 1 if you ever had
  a standby, and 0 if you did not.  You can customize this using
  ``ceph fs set <fs> standby_count_wanted <number>``.  Setting it
  to zero will effectively disable the health check.

* The "ceph mds tell ..." command has been removed.  It is superseded
  by "ceph tell mds.<id> ..."

* RGW introduces server side encryption of uploaded objects with 3
options for
  the management of encryption keys, automatic encryption (only
recommended for
  test setups), customer provided keys similar to Amazon SSE KMS
specification &
  using a key management service (openstack barbician)

For a more detailed changelog, refer to
http://ceph.com/releases/ceph-v12-0-2-luminous-dev-released/

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.0.2.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see
http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release sha1: 5a1b6b3269da99a18984c138c23935e5eb96f73e

--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)

