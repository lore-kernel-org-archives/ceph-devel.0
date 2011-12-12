From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Problem while CEPH setup
Date: Mon, 12 Dec 2011 13:25:57 -0800
Message-ID: <CAORUGqAZHGuysP-xjBbBPm9arWXuLOUrmwL_C_ynAq9ny2jmTQ@mail.gmail.com>
References: <CAPrqf92pUqDZznQHhnKAwFHwZh0OMWs3r-5VMjWcu_g9ds-ehQ@mail.gmail.com>
 <CAPrqf9335B=mh7KOHLr_hDv2BwTG0T54fQsWG4zMPsyOjgGw1A@mail.gmail.com>
 <Pine.LNX.4.64.1112080827550.2448@cobra.newdream.net> <Pine.LNX.4.64.1112080837310.2448@cobra.newdream.net>
 <CAPrqf90QD_evG8a1a8qvkTMbG42-4eFyT2VPZ8S+VPhDubzmpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34922 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab1LLV0T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2011 16:26:19 -0500
Received: by faar15 with SMTP id r15so1741556faa.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2011 13:26:18 -0800 (PST)
In-Reply-To: <CAPrqf90QD_evG8a1a8qvkTMbG42-4eFyT2VPZ8S+VPhDubzmpQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pankaj singh <psingh.ait@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Dec 8, 2011 at 09:25, pankaj singh <psingh.ait@gmail.com> wrote=
:
> Hi Sage,
>
> After pulling the changes, the problem has been resolved.
>
> Still, we are getting problem in ceph-mon command. It fails to create
> ceph-mon demon.
>
> # ceph-mon -c ceph.conf -i 0
> =C2=A0** WARNING: Ceph is still under development. =C2=A0Any feedback=
 can be directed =C2=A0**
> =C2=A0** =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0at ceph-devel@vger.kernel.=
org or http://ceph.newdream.net/. =C2=A0 =C2=A0 **
> starting mon.0 rank 0 at 192.168.56.101:6789/0 mon_data
> /root/workera/CEPH/mondata/data/mon.0 fsid
> 531eb76e-9181-41c4-b162-66b05cfda952
>
> So we getting timeout when we try to mount ceph client (both fuse and
> kernel client).

I see no error message there. Do you have an actual error, for example
from the logs in /var/log/ceph/ ?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
