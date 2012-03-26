From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Increasing the number of PGs
Date: Mon, 26 Mar 2012 16:15:45 -0700
Message-ID: <CAORUGqBzBBoi3TeWcqzyeN7vSW+=FCLM72MnPJfCqOFrQ9iOdg@mail.gmail.com>
References: <20120326213459.e8ace6f3.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45593 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab2CZXQF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 19:16:05 -0400
Received: by pbcun15 with SMTP id un15so6543932pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 16:16:05 -0700 (PDT)
In-Reply-To: <20120326213459.e8ace6f3.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Cl=C3=A1udio_Martins?= <ctpm@ist.utl.pt>
Cc: ceph-devel@vger.kernel.org

2012/3/26 Cl=C3=A1udio Martins <ctpm@ist.utl.pt>:
> =C2=A0Some past messages on this list and some documentation suggest =
that
> increasing pg_num on a cluster with data won't give good results and
> that PG splitting is not functional at this time.
>
> =C2=A0Can anyone clarify if this is still the case as of v0.43 and/or=
 v0.44,
> or is it safe to increase pg_num on a pool with live data?

Sadly, that is still the current state of affairs.

Resources:
http://tracker.newdream.net/issues/1515
http://ceph.newdream.net/docs/master/ops/manage/grow/placement-groups/
http://ceph.newdream.net/wiki/Changing_the_number_of_PGs
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
