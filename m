From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: osd_pool_default_size
Date: Fri, 26 Oct 2012 10:17:19 +0200
Message-ID: <CAOLwVUkvCQm-_UF=OsykCfw+CH7CPxBaXZrwDtH19M-T5EPrgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54446 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757225Ab2JZIRl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 04:17:41 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2254209lag.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 01:17:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers!

Some question about this parameter:

- Why does this parameter need to be in the [mon] section to work?
- In my ceph.conf I set a default size of 3:

# rados mkpool lol
successfully created pool lol

# ceph osd dump | grep lol
pool 31 'lol' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num 8
pgp_num 8 last_change 430 owner 18446744073709551615

Now if I retrieve the admin daemon I get,

# ceph --admin-daemon /var/run/ceph/ceph-osd.0.asok config show | grep
'osd_pool_default_size'
osd_pool_default_size = 2

Why? Did I something wrong?

Thanks :)

Cheers!
