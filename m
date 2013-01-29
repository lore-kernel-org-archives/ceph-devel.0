From: Martin B Nielsen <martin@unity3d.com>
Subject: Re: Ceph Production Environment Setup?
Date: Tue, 29 Jan 2013 13:39:33 +0100
Message-ID: <CAD3n6hHo2Pt3ipxjCoSoxmtgpxLJv-48EjBo-wqXa5h9TTaH+g@mail.gmail.com>
References: <CAPhYxPxYfsWfY96OvSfzG9mNMphAY8z5U-zYDp3Vw2nZ1yWNjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:45060 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756885Ab3A2Mje (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 07:39:34 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so354355oag.16
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 04:39:33 -0800 (PST)
In-Reply-To: <CAPhYxPxYfsWfY96OvSfzG9mNMphAY8z5U-zYDp3Vw2nZ1yWNjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: femi anjorin <femi.anjorin@gmail.com>
Cc: ceph-devel@vger.kernel.org

There is also the hardware recommendation page in the ceph docs (
http://ceph.com/docs/master/install/hardware-recommendations/ )

Basically they recommend something like ~ 1GHz CPU (or 1 core/osd),
500M-1GB RAM pr OSD daemon. Also most run with 1 OSD daemon pr. disk
(so if you put 16x disk pr. node you'll vastly overpower your atom
cpu)

Overall, while the cluster chugs along happily the hw specs are
relatively modest; as soon as it starts to recover you'll see high
cpu/mem usage.

Cheers,
Martin


On Tue, Jan 29, 2013 at 3:56 AM, femi anjorin <femi.anjorin@gmail.com> wrote:
>
> Please can anyone  an advise  on how exactly a CEPH production
> environment should look like? and what the configuration files should
> be. My hardwares include the following:
>
> Server A, B, C configuration
> CPU - Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz
> RAM - 16GB
> Hard drive -  500GB
> SSD - 120GB
>
> Server D,E,F,G,H,J configuration
> CPU - Intel(R) Atom(TM) CPU D525   @ 1.80GHz
> RAM - 4 GB
> Boot drive -  320gb
> SSD - 120 GB
> Storage drives - 16 X 2 TB
>
> I am thinking of these configurations but i am not sure.
> Server A - MDS and MON
> Server B - MON
> Server C - MON
> Server D, E,F,G,H,J - OSD
>
> Regards.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
