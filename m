From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: rbd device would disappear after re-boot
Date: Wed, 7 Dec 2011 09:31:03 -0800
Message-ID: <CAORUGqAhUEZXnjzpxvG0d7q5K-zjvefN5LQhTqiyYSRTLk+tGg@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D943112@WHQBEMAIL1.whq.wistron>
 <CAORUGqDjAW-PpqtfL_hzDKZEk3HbgozBBjip-nBYhG6yYgduTg@mail.gmail.com> <8512670932FB654F81AF0FEF1BE6D49D9433C2@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36128 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506Ab1LGRbZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 12:31:25 -0500
Received: by eekd41 with SMTP id d41so710389eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2011 09:31:24 -0800 (PST)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D9433C2@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

On Tue, Dec 6, 2011 at 18:38,  <Eric_YH_Chen@wistron.com> wrote:
> I have another little question. Could I map specific image to specifi=
c device?
>
> For example:
> Before re-boot
> id =C2=A0 =C2=A0 =C2=A0pool =C2=A0 =C2=A0image =C2=A0 snap =C2=A0 =C2=
=A0device
> 0 =C2=A0 =C2=A0 =C2=A0 rbd =C2=A0 =C2=A0 foo1 =C2=A0 =C2=A0- =C2=A0 =C2=
=A0 =C2=A0 /dev/rbd0
> 1 =C2=A0 =C2=A0 =C2=A0 rbd =C2=A0 =C2=A0 foo3 =C2=A0 =C2=A0- =C2=A0 =C2=
=A0 =C2=A0 /dev/rbd2
>
> How could I re-map the image(foo3) to device(/dev/rbd2) but skip rbd1=
? =C2=A0The command provided by ceph CLI cannot achieve this.
>
> If I re-map the image to another device, it would not sync with iSCSI=
 configuration and may cause problem.

I'm just confirming what Damien said. Don't rely on the numbering to
be consistent even from one boot to another; we provide a udev helper
that assigns more permanent names, based on the pool, image name, and
potentially snapshot name. You'll get a symlink like
/dev/rbd/POOL/IMAGE or /dev/rbd/POOL/IMAGE@SNAP, use that name.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
