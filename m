From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: a question about laggy mds
Date: Wed, 23 Mar 2011 19:27:46 -0700
Message-ID: <AANLkTimecWXyouv-0R8RuZampTyf=zQq3-UBBvJZ=axE@mail.gmail.com>
References: <AANLkTikFcmEcyEjoVcT_s-3dTvqLsiy8MhmXW-ZSD6to@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46765 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab1CXC1s convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2011 22:27:48 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8794CC065
	for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 19:27:48 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 376FAC063
	for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 19:27:48 -0700 (PDT)
Received: by ewy4 with SMTP id 4so2327467ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2011 19:27:46 -0700 (PDT)
In-Reply-To: <AANLkTikFcmEcyEjoVcT_s-3dTvqLsiy8MhmXW-ZSD6to@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

2011/3/23 huang jun <hjwsm1989@gmail.com>:
> Hi all=A3=AC
> There are two mds in the ceph cluster=A3=ACone is active and the othe=
r is
> standby.  In my test,  I found the mds0 was marked as laggy, and it
> was taken over by the standby soon. And it will take a long time for
> the standby to become active if there are a great many of requests
> from the client. I want to know under what circumstances mds would be
> marked as laggy.

The MDS gets marked laggy if it goes too long without sending a
"beacon" to the monitors. This generally happens if the MDS gets
overloaded by client requests for some reason -- or if it simply
crashes. Your config looks okay so either your MDS doesn't have the
resources it needs for the workload you're using, or the workload
breaks our default config/algorithms.

The amount of time it takes for a standby to take over is generally
determined by 3 things:
1) Time to declare an mds down (this is when it's marked laggy)
2) Time to replay the MDS journal
3) Time to handle client replay requests

Usually (2) and (3) are dominated by (1), and I'm surprised this isn't
the case for you... What's your workload look like?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
