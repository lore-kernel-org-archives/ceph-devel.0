From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: v0.24.2 released
Date: Wed, 26 Jan 2011 22:48:13 +0800
Message-ID: <AANLkTinzcKg+ntYhqojh9H+nviinpsbZ20CR283OfMp7@mail.gmail.com>
References: <Pine.LNX.4.64.1101250808480.3488@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61419 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267Ab1AZOsP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 09:48:15 -0500
Received: by ewy5 with SMTP id 5so180560ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jan 2011 06:48:13 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1101250808480.3488@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Is there any plan to update ceph-client-standalone recently?

Thanks,
Henry

2011/1/26 Sage Weil <sage@newdream.net>:
> This is a bugfix release. =C2=A0Changes since v0.24.1 include:
>
> =C2=A0* osd: fix journal ordering bug/crash
> =C2=A0* osd: fix long sync delay
> =C2=A0* osd: don't overflow journal size
> =C2=A0* osd: snapshot trimming bugs
> =C2=A0* osd: fix messenger connection issues after restart
> =C2=A0* osd: don't crash on no-journal case
> =C2=A0* mds: fix double-pinning of stray inodes (crash)
> =C2=A0* mds: don't block signals after restart
> =C2=A0* mds: fix journaling of root inode layout policy
> =C2=A0* mds: fix journal dump
> =C2=A0* mds: C_Gather locking fix
> =C2=A0* msgr: fix connection cleanup on non-daemons
> =C2=A0* monclient: fix locking
>
> Relevant URLs:
>
> =C2=A0* Direct download at: http://ceph.newdream.net/download/ceph-0.=
24.2.tar.gz
> =C2=A0* For Debian and Ubuntu packages, see http://ceph.newdream.net/=
wiki/Debian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Henry Chang
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
