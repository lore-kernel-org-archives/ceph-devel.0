From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Moving RGW buckets under tenant namespaces
Date: Tue, 30 Jan 2018 17:27:39 +0100
Message-ID: <87po5rl3b8.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60953 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeA3Q2E (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 30 Jan 2018 11:28:04 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


I was looking into moving buckets owned by a user under a tenant
namespace; (a common usecase is in openstack installations where tenant
namespaces are preferred with openstack keystone for eg.). Doing this
manually with rados and radosgw-admin cli would involve something in the
lines of:

1. Copying the user and user.buckets object under the users.uid pool with
  the tenant$user name with rados cp which seems to preserve omaps

2 radosgw-admin metadata get user:<uid> > uid.json # change uid to
  reflect the tenant field

3 radosgw-admin metadata get bucket:<bucket-name> modifying the empty
  tenant field with the tenant info; and owner to the tenant$user format
  and finally metadata put bucket:tenant/<bucket-name>

4 repeating the same metadata get/put for
  bucket.instance 

5 metadata rm user:<old-username> bucket:<old-bucket-name>
  bucket.instance:<old-instance>

6 radosgw-admin metadata put < modified-uid.json

I'm not sure whether this covers all the bases or any other metadata is
left behind? 

Current RGW Bucket link/unlink does steps 2,3 and getting
the ACLs right and correctly adding and removing the omap entries in the
user.bucket object, though in the current form it would fail as
version checks for a non existent object would fail. 

Given these complexities would it also make sense supporting this in
radosgw-admin? (with the caveat that we want no buckets or user
metadata of the concerned user also modified during this time frame)

--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
