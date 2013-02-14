From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: radosgw: Update a key's meta data
Date: Thu, 14 Feb 2013 15:37:06 +0100
Message-ID: <CAF6-1L6rnEW2Gyfci_n8ffJcd5-fow-9zw1+75z40bz7TS24gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:53422 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab3BNOhI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 09:37:08 -0500
Received: by mail-bk0-f42.google.com with SMTP id jk7so1095294bkc.15
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 06:37:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was wondering how I could update a key's metadata like the "Content-Type".

The solution on S3 seem to be to copy the key on itself and replacing
meta data. If I do that in ceph, will it work ? And more importantly,
will it be done "intelligently" (i.e. without copying the actual file
data around).

I tried reading the code, but although part of the code seem to hint
at support for this (in rgw_rest_s3.cc), some other part seem to not
look at all if the src == dst  (like rgw_op.cc).

Cheers,

     Sylvain Munaut
