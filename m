From: Dan van der Ster <dan@vanderster.com>
Subject: path-restricted mds caps cause EPERM on (some) stray files
Date: Tue, 20 Jun 2017 12:04:00 +0200
Message-ID: <CABZ+qqnnGm4wdeLryDEX5A5oFF1mRvq5rvQd9_ktFJBTT_ZA7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:33165 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdFTKEm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 06:04:42 -0400
Received: by mail-ot0-f177.google.com with SMTP id y47so63845167oty.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 03:04:42 -0700 (PDT)
Received: from mail-ot0-f175.google.com (mail-ot0-f175.google.com. [74.125.82.175])
        by smtp.gmail.com with ESMTPSA id x190sm6151110oix.8.2017.06.20.03.04.40
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 03:04:41 -0700 (PDT)
Received: by mail-ot0-f175.google.com with SMTP id r67so86195947ota.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 03:04:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pdonnell@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Patrick,

In tracker #20340 I've found that path-restricted mds caps can still
occasionally trigger incorrect EPERM errors.

It seems that sometimes Session::check_access uses a path looking like
#<inode num>, which of course doesn't match the path restriction. Here
is a *normal*, working check_access with stray_prior_path:

2017-06-20 11:22:38.489414 7f4fb4687700 20 Session check_access
stray_prior_path /volumes/_nogroup/4722edf2-a761-4189-b925-
dbf2d44c5345/aijens151.cern.ch/clone/modules/ironic/.fe57a500217328e0cb41c6e0731bf9ec3f949bff/.git/tvvy1sQ
2017-06-20 11:22:38.489417 7f4fb4687700 10 MDSAuthCap is_capable
inode(path /volumes/_nogroup/4722edf2-a761-4189-b925-dbf2d
44c5345/aijens151.cern.ch/clone/modules/ironic/.fe57a500217328e0cb41c6e0731bf9ec3f949bff/.git/tvvy1sQ
owner 993:991 mode 01
00600) by caller 4294967295:4294967295 mask 2 new 0:0 cap:
MDSAuthCaps[allow rw path="/volumes/_nogroup/4722edf2-a761-4189-
b925-dbf2d44c5345"]

But then here is one with the inode num path, which returns Permission denied:

2017-06-20 11:22:40.736744 7f4fb4687700 20 Session check_access
stray_prior_path #10000ee3d6f/tmp_obj_x3Ncq5
2017-06-20 11:22:40.736745 7f4fb4687700 10 MDSAuthCap is_capable
inode(path /10000ee3d6f/tmp_obj_x3Ncq5 owner 993:991 mode 0100444) by
caller 0:0 mask 1 new 0:0 cap: MDSAuthCaps[allow rw
path="/volumes/_nogroup/4722edf2-a761-4189-b925-dbf2d44c5345"]
2017-06-20 11:22:40.736749 7f4fb4687700 10 mds.0.server
reply_client_request -13 ((13) Permission denied)
client_request(client.372408617:11903 lookup
#10000ee3d6f/62f6fac09b5291e0924a6c844e11da53e40397 2017-06-20
11:22:40.734619) v3

Do you understand why these files get occasionally stuck with that
funny stray_prior_path?

Best Regards,
Dan
