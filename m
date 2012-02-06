From: huang jun <hjwsm1989@gmail.com>
Subject: raodsgw--s3 client can't display objects with prefix of "_"
Date: Mon, 6 Feb 2012 10:21:09 +0800
Message-ID: <CABAwU-Y_emMq1DBu3xkZsvXhD87f_tE8NnaYww_GxeFLm3mpeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:62917 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754534Ab2BFCVJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Feb 2012 21:21:09 -0500
Received: by obcva7 with SMTP id va7so6235412obc.19
        for <ceph-devel@vger.kernel.org>; Sun, 05 Feb 2012 18:21:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi, all
Recently, we use s3 client cyberduck to add some files to RADOS, it
seems doesn't support objects named with prefix of '_'.
eg, if we put a object named "_test"(1 prefix "_") in bucket TEST, it
will store in RADOS in another name  "___test"(3 prefix "_").
      but if we list bucket TEST, it sends op whoes oid is "__test"(2
prefix "_"), result the RADOS return ENOENT err.
we trace the debug log,and found where it comes from:
in  "translate_raw_obj" func of  rgw_common.h,
     if (obj.size() >= 2 && obj[1] == '_') {
          obj = obj.substr(1);
         return true;
      }
 why cut the obj name?
 what is "string ns" in struct rgw_obj doing here? Can't we just use
the origin obj name that passed object_name verfication?

-- 
thanks!
huangjun
