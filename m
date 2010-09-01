From: H Chang <heracles@gmail.com>
Subject: support for multiple data placement policies
Date: Wed, 1 Sep 2010 14:33:02 -0400
Message-ID: <AANLkTin8GVQfPmV0d3xGThEMPYeRMKYuCR1b6Fk5XPre@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38788 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab0IASdE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Sep 2010 14:33:04 -0400
Received: by gyd8 with SMTP id 8so3136415gyd.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Sep 2010 11:33:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph team,

I'm a newbie in Ceph, so please bear with me if my question sounds stupid.

I'd like to explore the possibility to support multiple placement
policies in Ceph.

For example, suppose each user using Ceph has its own placement policy
which may be different from one user to another.
So, all the files created by the user and their replicas will be placed based on
the user's policy. Essentially each user would have its own CRUSH map.

Do you think Ceph could somehow be modified to support this kinda scenario?
If so, where do we start?

Regards,
HS
