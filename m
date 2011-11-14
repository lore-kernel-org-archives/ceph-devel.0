From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: ceph and ext4
Date: Mon, 14 Nov 2011 14:09:41 +0100
Message-ID: <CAMvP8PAuBbG_hcgjD+WJGRFo=p59Um3HAAoRN5zjuRPWjsLh1A@mail.gmail.com>
References: <4EC10664.1080501@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56368 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab1KNNKD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 08:10:03 -0500
Received: by gyc15 with SMTP id 15so4850558gyc.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 05:10:02 -0800 (PST)
In-Reply-To: <4EC10664.1080501@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

what about limit on xattr size ? Is it still limited to 4KB ?



On Mon, Nov 14, 2011 at 1:15 PM, Martin Mailand <martin@tuxadero.com> w=
rote:
> Hi Christian,
> I am not sure if you noticed, but your ext4 bug is fixed in mainline.=
 I am
> running a ceph cluster with 40+ vms for over a week by now, without a=
ny
> problems. An fsck.ext4 shows the ext4 is clean.
> The performance of ext4 is much better than btrfs, no rise in the loa=
d of
> the osd's.
>
> -martin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
