From: huang jun <hjwsm1989@gmail.com>
Subject: s3--object name with "%" questions
Date: Fri, 10 Feb 2012 17:06:04 +0800
Message-ID: <CABAwU-bsdR+kwbvUfTcw8AmiT8M_kJz8MKuFNBjpB3WfJ6OXgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39375 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754974Ab2BJJHP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2012 04:07:15 -0500
Received: by bkcjm19 with SMTP id jm19so2605564bkc.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2012 01:07:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,list
 After testing the object-name include "+" in radosgw.now we tested
object-name with "%",
 which was supported by the amazon's object-name rules, either in the
underlayer FS btrfs .
 but it seems not  the case in radosgw, we can not create an object
whoes name include "%",

 after we can create it, then the ListBucket result shows the name of
the object "test%huang" is "test2608ang".
 we trace the debug log, the object-name was changed by "vsnprintf" in
formatter.dump_format, because the "%" is a control character,
 so, there is any methods if user want to store an object  with name
string include  "%".

-- 
thanks,
huangjun
