From: Travis Rhoden <trhoden@gmail.com>
Subject: [ANN] ceph-deploy 1.5.23 released
Date: Wed, 8 Apr 2015 10:40:21 -0400
Message-ID: <CACkq2mpHdM5v6qdYt7JqWqpqgAty+6WNNdKW6t3ghs0kSWaiBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35944 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbbDHOkm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 10:40:42 -0400
Received: by qgeb100 with SMTP id b100so29814847qge.3
        for <ceph-devel@vger.kernel.org>; Wed, 08 Apr 2015 07:40:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-announce@lists.ceph.com

Hi All,

This is a new release of ceph-deploy that includes a new feature for
Hammer and bugfixes.  ceph-deploy can be installed from the ceph.com
hosted repos for Firefly, Giant, Hammer, or testing, and is also
available on PyPI.

ceph-deploy now defaults to installing the Hammer release. If you need
to install a different release, use the --release flag.

To go along with the Hammer release, ceph-deploy now includes support
for a drastically simplified deployment for RGW.  See further details
at [1] and [2].

This release also fixes an issue where keyrings pushed to remote nodes
ended up with world-readable permissions.

The full changelog can be seen at [3].

Please update!

Cheers,

 - Travis

[1] http://ceph.com/docs/master/start/quick-ceph-deploy/#add-an-rgw-instance
[2] http://ceph.com/ceph-deploy/docs/rgw.html
[3] http://ceph.com/ceph-deploy/docs/changelog.html#id2
