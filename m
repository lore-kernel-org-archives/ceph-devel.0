From: Francois Deppierraz <francois@ctrlaltdel.ch>
Subject: [radosgw-admin] modify bucker owner
Date: Mon, 02 Jun 2014 11:07:16 +0200
Message-ID: <538C3EC4.8000604@ctrlaltdel.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nimag.net ([62.220.136.11]:38547 "EHLO smtp.nimag.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbaFBJQl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Jun 2014 05:16:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm trying to modify the owner of an existing bucket. The original user
(userA) was manually created with radosgw-admin user create a few
releases ago (dumpling I guess). The new user
(a2176a80eeac47a58c3d773eaebf6659) is defined in the Openstack Keystone
service.

# ceph -v
ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
# radosgw-admin bucket stats --bucket test-permissions3
{ "bucket": "test-permissions3",
  "pool": ".rgw.buckets",
  "index_pool": ".rgw.buckets",
  "id": "default.37768360.136",
  "marker": "default.37768360.136",
  "owner": "userA",
  "ver": 3,
  "master_ver": 0,
  "mtime": 1401699197,
  "max_marker": "",
  "usage": { "rgw.main": { "size_kb": 1,
          "size_kb_actual": 4,
          "num_objects": 1}},
  "bucket_quota": { "enabled": false,
      "max_size_kb": -1,
      "max_objects": -1}}
# radosgw-admin bucket link --bucket test-permissions3 --uid
a2176a80eeac47a58c3d773eaebf6659
# radosgw-admin bucket stats --bucket test-permissions3
{ "bucket": "test-permissions3",
  "pool": ".rgw.buckets",
  "index_pool": ".rgw.buckets",
  "id": "default.37768360.136",
  "marker": "default.37768360.136",
  "owner": "a2176a80eeac47a58c3d773eaebf6659",
  "ver": 3,
  "master_ver": 0,
  "mtime": 1401699387,
  "max_marker": "",
  "usage": { "rgw.main": { "size_kb": 1,
          "size_kb_actual": 4,
          "num_objects": 1}},
  "bucket_quota": { "enabled": false,
      "max_size_kb": -1,
      "max_objects": -1}}


Looks like the bucket owner was correctly changed, however access to th=
e
bucket through the swift API with the new user fails.

$ swift list
test-permissions3
$ swift list test-permissions3
Container GET failed:
https://s3.company.com/swift/v1/test-permissions3?format=3Djson 401
Authorization Required   {"Code":"AccessDenied"}
$

Trying to rollback to the previous state also fails.

# radosgw-admin bucket link --bucket test-permissions3 --uid userA
failure: (22) Invalid argument
2014-06-02 11:02:21.216739 7fb0b0392780  0 bucket entry point user
mismatch, can't unlink bucket: a2176a80eeac47a58c3d773eaebf6659 !=3D us=
erA
#

=46ortunately, access to the bucket with the old user still works, even
though it's no longer listed as owner of the bucket according to
radosgw-admin.

Am I doing this wrong or is there a bug somewhere?

Thanks for your help!

=46ran=E7ois
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
