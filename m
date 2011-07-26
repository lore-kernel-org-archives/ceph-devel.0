From: Christian Brunner <chb@muc.de>
Subject: Re: peering PGs
Date: Tue, 26 Jul 2011 10:06:25 +0200
Message-ID: <CAO47_-_UMAs5sgcV+iMa8dnV4JkrHSi9x+q54vPRac2Xwo1taQ@mail.gmail.com>
References: <CAO47_-87BvxVrgAXEqX6y59Mv_fmNZ9b=BK056OUiCSrt9Dwng@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61369 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab1GZIG0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2011 04:06:26 -0400
Received: by vws1 with SMTP id 1so117811vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jul 2011 01:06:26 -0700 (PDT)
In-Reply-To: <CAO47_-87BvxVrgAXEqX6y59Mv_fmNZ9b=BK056OUiCSrt9Dwng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

OK  I've solved this by myself.

Since I knew that ther is replication between

osd001 and osd005,

as well as

osd001 and osd015,
osd001 and osd012,

I decided to take osd005, osd012 and osd015 offline. After that ceph
started to rebuild the PGs on other nodes.

Everything is fine now.

Regards,
Christian

2011/7/26 Christian Brunner <chb@muc.de>:
> Another kernel crash another invalid ceph state...
>
> A memory allocation failure in the kernel (ixgbe) of one OSD-Server
> lead to a domino effect in our ceph cluster with "0 up, 0 in".
>
> When I restarted the cluster everything came up again. But I still
> have 6 peering PGs:
>
> pg v5898472: 3712 pgs: 3706 active+clean, 6 peering; 745 GB data, 775
> GB used, 57642 GB / 59615 GB avail
>
> # ceph pg dump -o - | grep peering
> 0.190 =A0 22 =A0 =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 901=
12 =A0 92274688 =A0 =A0 =A0 =A0200
> =A0200 =A0 =A0 peering 6500'1256 =A0 =A0 =A0 7167'1063 =A0 =A0 =A0 [1=
5,1] =A0[15,1]
> 6500'1256 =A0 =A0 =A0 2011-07-22 11:22:55.798745
> 3.18d =A0 385 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 15294=
98 1566204928 =A0 =A0 =A0300
> =A0300 =A0 =A0 peering 7013'134376 =A0 =A0 7167'20162 =A0 =A0 =A0[15,=
1] =A0[15,1]
> 6933'132427 =A0 =A0 2011-07-22 11:22:56.488471
> 0.4c =A0 =A09 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 3=
6864 =A0 37748736 =A0 =A0 =A0 =A0200
> =A0200 =A0 =A0 peering 6500'673 =A0 =A0 =A0 =A07163'1095 =A0 =A0 =A0 =
[12,1] =A0[12,1]
> 6500'673 =A0 =A0 =A0 =A02011-07-22 11:22:20.226119
> 3.49 =A0 =A0171 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 671=
467 =A0687580272 =A0 =A0 =A0 295
> =A0295 =A0 =A0 peering 7013'10276 =A0 =A0 =A07163'2879 =A0 =A0 =A0 [1=
2,1] =A0[12,1]
> 6933'9455 =A0 =A0 =A0 2011-07-22 11:22:20.701854
> 0.35e =A0 6 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 245=
76 =A0 25165824 =A0 =A0 =A0 =A0200
> =A0200 =A0 =A0 peering 6500'628 =A0 =A0 =A0 =A07163'1142 =A0 =A0 =A0 =
[12,1] =A0[12,1]
> 6500'628 =A0 =A0 =A0 =A02011-07-22 11:22:19.267804
> 3.35b =A0 198 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 79180=
0 =A0810803200 =A0 =A0 =A0 297
> =A0297 =A0 =A0 peering 7013'66727 =A0 =A0 =A07163'5759 =A0 =A0 =A0 [1=
2,1] =A0[12,1]
> 6933'65715 =A0 =A0 =A02011-07-22 11:22:20.035265
>
>
> "ceph pg map" is consistent with "ceph pg dump":
>
> # ceph pg map 0.190
> 2011-07-26 08:46:19.330981 mon <- [pg,map,0.190]
> 2011-07-26 08:46:19.331981 mon1 -> 'osdmap e7273 pg 0.190 (0.190) ->
> up [15,1] acting [15,1]' (0)
>
>
> But directorys of the PGs are present on multiple nodes (for example
> on osd005 for 0.190):
>
> /ceph/osd.001/current/0.190_head
> /ceph/osd.001/snap_1650435/0.190_head
> /ceph/osd.001/snap_1650445/0.190_head
> /ceph/osd.005/current/0.190_head
> /ceph/osd.005/snap_1572317/0.190_head
> /ceph/osd.005/snap_1572323/0.190_head
> /ceph/osd.015/current/0.190_head
> /ceph/osd.015/snap_1467152/0.190_head
>
> Any hint on how to proceed yould be great.
>
> Thanks,
> Christian
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
