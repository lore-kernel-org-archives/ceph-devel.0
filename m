From: Gregory Farnum <greg@gregs42.com>
Subject: Re: QoS Control for RBD I/Os?
Date: Thu, 15 Jan 2015 09:59:16 -0800
Message-ID: <CAC6JEv9Cmnpoopghpdb=tmuXk-DQGy8LaJaY3qyOn-v0Qexbnw@mail.gmail.com>
References: <E5173F87-4790-4151-9B2A-3FE6E8F11E96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:53530 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbbAOR7R convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 12:59:17 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so16276515iec.12
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 09:59:17 -0800 (PST)
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com. [209.85.223.174])
        by mx.google.com with ESMTPSA id qd4sm446268igc.22.2015.01.15.09.59.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 09:59:16 -0800 (PST)
Received: by mail-ie0-f174.google.com with SMTP id at20so16306548iec.5
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 09:59:16 -0800 (PST)
In-Reply-To: <E5173F87-4790-4151-9B2A-3FE6E8F11E96@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cheng Cheng <ccheng.leo@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 15, 2015 at 9:53 AM, Cheng Cheng <ccheng.leo@gmail.com> wro=
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

Sadly, there's no QoS in RBD right now. It sounds like you're more
concerned about preventing management from impacting client IO, but
even in this case it's a distributed problem (flatten for instance
involves moving data between storage machines), which is still an open
research topic as far as I know. I don't think you'll ever be able to
get a guarantee, and simply doing one movement at a time is probably
as good as you can get in the medium term. :(
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
