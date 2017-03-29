From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: v12.0.1 Luminous (dev) released
Date: Wed, 29 Mar 2017 07:49:30 +0200
Message-ID: <58DB4AEA.6040402@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38145 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbdC2FuD (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 29 Mar 2017 01:50:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

This is the second development checkpoint release of Luminous, the next
long term stable release.

Major changes from 12.0.0
-------------------------
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

* The rados copy-get-classic operation has been removed since it has not 
been
   used by the OSD since before hammer.  It is unlikely any librados user is
   using this operation explicitly since there is also the more modern 
copy-get.

* The RGW api for getting object torrent has changed its params from 
'get_torrent'
   to 'torrent' so that it can be compatible with Amazon S3. Now the 
request for
   object torrent is like 'GET /ObjectName?torrent'.

See http://ceph.com/releases/v12-0-1-luminous-dev-released/ for a more
detailed changelog on this release, and thank you everyone for
contributing.

While we're fixing a few issues in the build system, the arm64 packages
for centos7 are, unfortunately, not available for this dev release.

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.0.1.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see 
http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release sha1: 5456408827a1a31690514342624a4ff9b66be1d5

--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, 
HRB 21284 (AG Nürnberg)


