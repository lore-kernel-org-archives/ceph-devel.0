From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: QoS Control for RBD I/Os?
Date: Fri, 16 Jan 2015 01:57:51 +0800
Message-ID: <CACJqLyZyGxY82caFT01iCoV7u4+RUDk3JMdW6rUYL=96A3WDbQ@mail.gmail.com>
References: <E5173F87-4790-4151-9B2A-3FE6E8F11E96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35353 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbbAOR5w convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 12:57:52 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so16369680wgg.11
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 09:57:51 -0800 (PST)
In-Reply-To: <E5173F87-4790-4151-9B2A-3FE6E8F11E96@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cheng Cheng <ccheng.leo@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Cheng cheng,

There already exists a
bp(wiki.ceph.com/Planning/Blueprints/Giant/Add_QoS_capacity_to_librbd)
but still no one to implement it.

If you are interested in this, I think we can make it father. If not,
I would like to pick it up later. :-)


On Fri, Jan 16, 2015 at 1:53 AM, Cheng Cheng <ccheng.leo@gmail.com> wro=
te:
> Hi Ceph,
>
> I am wondering is there a mechanism to prioritize the rbd_aio_write/r=
bd_aio_read I/Os? Currently all RBD I/Os are issued in FIFO to rados la=
yer, and there is NO QoS mechanism to control the priority of these I/O=
s.
>
> A QoS mechanism will be beneficial when performing certain management=
 operations, such as flatten. When flatten a image, the outstanding I/O=
s do get throttled by =E2=80=9Crbd_concurrent_management_ops=E2=80=9D. =
However this won't guarantee normal I/Os are not affected, as outstandi=
ng normal I/Os are still competing with concurrent management ops.
>
> Anyone know how/where to implement this QoS mechanism?
>
> Thanks!
> Cheng
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
