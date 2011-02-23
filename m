From: H Chang <heracles@gmail.com>
Subject: remove PG
Date: Wed, 23 Feb 2011 10:57:06 -0500
Message-ID: <AANLkTimGyBpOPWKDV6iOHUqkDWvcQ_biSJzvsLuE+=JJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35206 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab1BWP5H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 10:57:07 -0500
Received: by yib19 with SMTP id 19so268525yib.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 07:57:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I was browsing PG management code in Ceph, and have one question.

It appears that an OSD could send a PG removal request to another OSD.
The recipient OSD would then remove that particular PG from its pg_map.

I'd like to know under what circumstances an OSD would want to remove PGs.

Thanks,
HS
