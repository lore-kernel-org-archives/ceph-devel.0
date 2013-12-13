From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: BUG v0.73: radosgw-admin key create ignores specified access-key
Date: Fri, 13 Dec 2013 20:44:42 +0000
Message-ID: <robbat2-20131213T203815-267676123Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:40769 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753238Ab3LMUon (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Dec 2013 15:44:43 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id CD55E33F4A9
	for <ceph-devel@vger.kernel.org>; Fri, 13 Dec 2013 20:44:42 +0000 (UTC)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If I try to create a key with explicitly specifying the access-key and
secret-key, radosgw-admin ignores the access-key entirely.
In my case, I'm trying to copy some keys exactly from an older Ceph cluster.
(I've slightly scrambled some details below for security)

ceph version 0.73 (d8ad51ee8ab508bc523a0398f54d8d9c5785b8d8)
(Running the raring packages).

# radosgw-admin key create --uid example --subuser=example:foo --access-key=exampleaccess --secret examplesecret
{ "user_id": "example",
  "display_name": "...",
  "email": "..."
  "suspended": 0,
  "max_buckets": 1000,
  "auid": 0,
  "subusers": [
        { "id": "example:foo",
          "permissions": "read-write"}],
  "keys": [
        { "user": "example",
          "access_key": "HGDRHZG1K030VGYU5AUX",
          "secret_key": "xDCaefCz1v9jrY6yi3L\/BBd7OZznokiJNJced5\/3"},
        { "user": "example:foo",
          "access_key": "O8E3B2HUJMXR5L5N5UL6",
          "secret_key": "examplesecret"}],
  "swift_keys": [],
  "caps": [],
  "op_mask": "read, write, delete",
  "default_placement": "",
  "placement_tags": [],
  "bucket_quota": { "enabled": false,
      "max_size_kb": -1,
      "max_objects": -1}}

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
