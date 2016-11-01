From: Mustafa Muhammad <mustafa1024m@gmail.com>
Subject: Lots of radosgw-admin commands fail after upgrade
Date: Tue, 1 Nov 2016 16:13:42 +0300
Message-ID: <CAFehDbCTSPLmh8LY03q0cfV1v2ACzF24ZShAk+OgSXYJLVjPqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33587 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169096AbcKANNp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2016 09:13:45 -0400
Received: by mail-lf0-f45.google.com with SMTP id c13so19263472lfg.0
        for <ceph-devel@vger.kernel.org>; Tue, 01 Nov 2016 06:13:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
I have production cluster configured with multiple placement pools according to:

http://cephnotes.ksperis.com/blog/2014/11/28/placement-pools-on-rados-gw

After upgrading to Jewel, most radosgw-admin are failing, probably
because there is no realm


# radosgw-admin realm list
{
    "default_info": "",
    "realms": []
}


# radosgw-admin zone get
unable to initialize zone: (2) No such file or directory


# radosgw-admin regionmap get
failed to read current period info: 2016-11-01 16:08:14.099948
7f21b55ee9c0  0 RGWPeriod::init failed to init realm  id  : (2) No
such file or directory(2) No such file or directory
{
    "zonegroups": [],
    "master_zonegroup": "",
    "bucket_quota": {
        "enabled": false,
        "max_size_kb": -1,
        "max_objects": -1
    },
    "user_quota": {
        "enabled": false,
        "max_size_kb": -1,
        "max_objects": -1
    }
}


# radosgw-admin bucket stats
2016-11-01 16:07:55.860053 7f6e747f89c0  0 zonegroup default missing
zone for master_zone=
couldn't init storage provider

I have previous region.conf.json and zone.conf.json, how can I make
everything work again? Will creating new realm fix this?

Regards
Mustafa Muhammad
