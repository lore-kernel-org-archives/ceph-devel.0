From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: how to remove laggy mds ?
Date: Fri, 3 Feb 2012 13:19:34 -0800
Message-ID: <CAORUGqD2q3G+aEGVBJ4+68YAyA+Wy_0RyGi=J_f3qMRHLG_Ljg@mail.gmail.com>
References: <4F2C3A10.1040605@shadow.gt.owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32832 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab2BCVTz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 16:19:55 -0500
Received: by wgbdt10 with SMTP id dt10so4277663wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2012 13:19:54 -0800 (PST)
In-Reply-To: <4F2C3A10.1040605@shadow.gt.owl.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Jens_Rehp=C3=B6hler?= <jens@shadow.gt.owl.de>
Cc: ceph-devel@vger.kernel.org

On Fri, Feb 3, 2012 at 11:48, Jens Rehp=C3=B6hler <jens@shadow.gt.owl.d=
e> wrote:
> one of my test mds servers died a few days ago. (hardware crash) I wi=
ll
> not buy a new one.
>
> Is there any chance to remove this laggy mds ?

Start the mds daemon somewhere. If you don't want to fix/replace the
hardware, well, start it somewhere else. It has no local state.

Decreasing the number of active mdses is not currently supported.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
