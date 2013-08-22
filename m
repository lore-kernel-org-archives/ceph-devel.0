From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: bucket count limit
Date: Thu, 22 Aug 2013 16:11:59 +0200
Message-ID: <CAMNMNTzJ+2sLGur-7QKz+r0FJijTm-iHGqeHTYBWgbUjxoQpvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:57725 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab3HVOMB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 10:12:01 -0400
Received: by mail-qe0-f43.google.com with SMTP id t7so1119712qeb.30
        for <ceph-devel@vger.kernel.org>; Thu, 22 Aug 2013 07:12:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org

Hi,
I think about sharding s3 buckets in CEPH cluster, create
bucket-per-XX (256 buckets) or even bucket-per-XXX (4096 buckets)
where XXX is sign from object md5 url.
Could this be the problem? (performance, or some limits)

--
Regards
Dominik
