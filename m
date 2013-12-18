From: Pawel Stefanski <pejotes@gmail.com>
Subject: fix for issue with RGW on larger than 528k downloads
Date: Wed, 18 Dec 2013 10:53:21 +0100
Message-ID: <CAC96waHg9nm3txHCDdqMeKZboBKgt1c-DoVQ+irJ3u7fWrGD5w@mail.gmail.com>
Reply-To: pejotes@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:62254 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab3LRJxW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 04:53:22 -0500
Received: by mail-wg0-f52.google.com with SMTP id x13so7280921wgg.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Dec 2013 01:53:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hello!

We are struggling with issue on downloading bigger files since some
time, on ceph-users there were some complains about this but without
any conclusions or with misunderstood cause (as a solution there was
proposed new http serwer for example nginx, where the cause is
somewhere in radosgw).

I see that cluster at dreamhost suffered the same issue recently,
could community get the same path/workaround for the stalling download
issue ?

http://www.dreamhoststatus.com/2013/12/17/dreamobjects-trouble-with-large-objects/

Thanks in advance!

best regards!
-- 
Pawel
