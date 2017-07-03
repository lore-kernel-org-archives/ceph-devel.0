From: Willem Jan Withagen <wjw@digiware.nl>
Subject: RBD rights acting up.
Date: Mon, 3 Jul 2017 19:51:46 +0200
Message-ID: <066859a0-9ca6-613f-e9de-a01a430e7efa@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:42319 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755788AbdGCRvw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 3 Jul 2017 13:51:52 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 162FE44BDF
        for <ceph-devel@vger.kernel.org>; Mon,  3 Jul 2017 19:51:49 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


Hi,

I do not seem to have luck with working with the rights structure in
Ceph. But please help me out with my ignorance....

I have setup the FreeBSD cluster running in 5 ceph jails/vms. That works
as a charm, and I can use ceph-fuse to mount a FS and write/read/... on
it when I'm outside the ceph jails. For that I copies ceph.conf and
ceph.client.admin.keyring to the current system I would like to connect
with.

Also things like ceph -s and rados commands just work as a charm.

So the next check is to test rbd-ggate, the freebsd variant to map
rbd-images to a device.... But then I start to get things like:
----
# rbd info rbd/testrbdggate45846
2017-07-03 19:41:00.562567 80ee53b00 -1 librbd::image::OpenRequest:
failed to retrieve create_timestamp: (1) Operation not permitted
2017-07-03 19:41:00.562685 80f8b2000 -1 librbd::ImageState: 0x80ef23640
failed to open image: (1) Operation not permitted
rbd: error opening image testrbdggate45846: (1) Operation not permitted
----

Which is definitly a rights issue, because I can do that without much
trouble on one of the Ceph servers:
----
# jexec ceph_0 rbd info rbd/testrbdggate45846
rbd image 'testrbdggate45846':
        size 65536 kB in 16 objects
        order 22 (4096 kB objects)
        block_name_prefix: rbd_data.10e3c0b1daf
        format: 2
        features: layering, exclusive-lock, object-map, fast-diff,
deep-flatten
        flags:
----

So why does this work from a server that is actually running
mon/osd/mgr, but not from a server that has the same
ceph.client.admin.keyring:
[client.admin]
        key = AQBUXllZMNZSARAAsSexLBkWJQS6vHi9u3rrSA==
        auid = 0
        caps mds = "allow *"
        caps mgr = "allow *"
        caps mon = "allow *"
        caps osd = "allow *"

and ceph auth list:
installed auth entries:

mds.a
        key: AQA+YFlZEHtzKRAAm7Ihhsp2bq2z1YrfmMKnXg==
        caps: [mds] allow
        caps: [mgr] allow profile
 mds
        caps: [mon] allow profile mds
        caps: [osd] allow *
osd.0
        key: AQCLXllZ6NL+BBAAzZH3lnPOR7jOdpsHZz9+FA==
        caps: [mon] allow profile osd
        caps: [osd] allow *
osd.1
        key: AQDpXllZeNPKDBAAMzXKut/xcPQP43l2UzTyQw==
        caps: [mon] allow profile osd
        caps: [osd] allow *
osd.2
        key: AQAkX1lZmL4FOhAAcgVJ5lno+abOyGq7TOdpKg==
        caps: [mon] allow profile osd
        caps: [osd] allow *
osd.3
        key: AQBlX1lZyBxRARAAccH0W16MQ4EMPT+y3Bh5ag==
        caps: [mon] allow profile osd
        caps: [osd] allow *
osd.4
        key: AQCtX1lZaOnOGxAAFSK3sCq/pbqXARi9oELAxA==
        caps: [mon] allow profile osd
        caps: [osd] allow *
osd.5
        key: AQD5X1lZ2KhCGRAAFda2ttOumRXxLGU6CU26Fw==
        caps: [mon] allow profile osd
        caps: [osd] allow *
osd.6
        key: AQA8YFlZkLPDBxAAe6YlnCCUTQlgQh0UvWw6Fg==
        caps: [mon] allow profile osd
        caps: [osd] allow *
client.admin
        key: AQBUXllZMNZSARAAsSexLBkWJQS6vHi9u3rrSA==
        auid: 0
        caps: [mds] allow *
        caps: [mgr] allow *
        caps: [mon] allow *
        caps: [osd] allow *
client.bootstrap-mds
        key: AQBWXllZ6DHwMRAA53Zp9126rH/b5IZr0y2j/A==
        caps: [mon] allow profile bootstrap-mds
client.bootstrap-osd
        key: AQBWXllZWD3EDxAAhaJ41UcTwlQVJCHzw+tBkA==
        caps: [mon] allow profile bootstrap-osd
client.bootstrap-rgw
        key: AQBWXllZ0EUAIRAAfUgvfH7mIzF2cTKXbd8yPg==
        caps: [mon] allow profile bootstrap-rgw
client.ggate
        key: AQANP1pZGNDmNRAAVb8NRXUMmWYh9i1nju6rYA==
        caps: [mon] allow r
        caps: [osd] allow class-read object_prefix rbd_children, allow
rwx pool=rbd
client.kernelrbd
        key: AQBzP1pZEO4nLxAABljwihF2xHFzZfUcc+CJtg==
        caps: [mon] allow r
        caps: [osd] allow class-read object_prefix rbd_children, allow
rwx pool=rbd
mgr.a
        key: AQA/YFlZkA7tDxAAAvC49DNN2VuTTSfCJ1nH+w==
        caps: [mds] allow *
        caps: [mon] allow profile mgr
        caps: [osd] allow *
mgr.x
        key: AQA+YFlZcE52ERAASdHoQn7DZ4G6ialDJg922g==
        caps: [mds] allow *
        caps: [mon] allow profile mgr
        caps: [osd] allow *


Thanx,
--WjW


