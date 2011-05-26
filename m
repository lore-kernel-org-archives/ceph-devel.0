From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: question about pg mapping
Date: Thu, 26 May 2011 13:36:20 -0400
Message-ID: <BANLkTi=ZnoK4Gsb_ZcsK6h-6ovUav=N52A@mail.gmail.com>
References: <BANLkTinTakGWiorMJP95Zu8F-CWCWOvU8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51498 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab1EZRgW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2011 13:36:22 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 09719C407
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:36:22 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id ADA5EC403
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:36:21 -0700 (PDT)
Received: by eyx24 with SMTP id 24so371238eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:36:20 -0700 (PDT)
In-Reply-To: <BANLkTinTakGWiorMJP95Zu8F-CWCWOvU8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 20, 2011 at 3:05 AM, Henry C Chang <henry.cy.chang@gmail.co=
m> wrote:
> Hi all,
>
> In my ceph cluster, I saw a pg membership change as below:
>
> At osdmap epch 160, pg 1.184 was mapped to [4, 6].
>
> =A0 =A0 =A0 =A0osdmaptool: osdmap file '160'
> =A0 =A0 =A0 =A0 parsed '1.184' -> 1.184
> =A0 =A0 =A0 =A01.184 raw [4,6] up [4,6] acting [4,6]
>
> At osdmap epoch 161, however, pg 1.184 was mapped to [0, 5].
>
> =A0 =A0 =A0 =A0osdmaptool: osdmap file '161'
> =A0 =A0 =A0 =A0 parsed '1.184' -> 1.184
> =A0 =A0 =A0 =A01.184 raw [0,5] up [0,5] acting [0,5]
>
> The osdmap are attached.
> Is it normal that the pg membership changes like this? I thought at
> least one member will stay in the pg in this case?
What caused the osd map to change?
And did the mapping stay that way, or did it get overridden in one of
the subsequent map updates?

In general we'd expect the mappings to maintain membership, but I
don't think it's a guarantee. What you will see, though, are manual
overrides of the CRUSH mapping to a different acting set in subsequent
updates, as the new OSDs in the PG start peering and realize that an
old OSD would be better-suited for the job (since it has data and none
of them do).
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
