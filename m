From: Samuel Just <sam.just@inktank.com>
Subject: Re: OSD memory leaks?
Date: Mon, 17 Dec 2012 10:12:05 -0800
Message-ID: <CA+4uBUY6Vf0HU71bL8z-3QhbsSSv+LRXFyfAiHHoNAzMw=5dLw@mail.gmail.com>
References: <CAOLwVUmJb0y39dg3zTv=c4iPSkjLBhG3L7L4=L7Ms96iP-SiWw@mail.gmail.com>
	<CAOLwVUnRqj+u7Vn2De+zAfvXLpYhj=tNggGZZdOH+m_xj2SMCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52454 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab2LQSMH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 13:12:07 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so7566889vcd.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 10:12:06 -0800 (PST)
In-Reply-To: <CAOLwVUnRqj+u7Vn2De+zAfvXLpYhj=tNggGZZdOH+m_xj2SMCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Are you having network hiccups?  There was a bug noticed recently that
could cause a memory leak if nodes are being marked up and down.
-Sam

On Mon, Dec 17, 2012 at 12:28 AM, S=E9bastien Han <han.sebastien@gmail.=
com> wrote:
> Hi guys,
>
> Today looking at my graphs I noticed that one over 4 ceph nodes used =
a
> lot of memory. It keeps growing and growing.
> See the graph attached to this mail.
> I run 0.48.2 on Ubuntu 12.04.
>
> The other nodes also grow, but slowly than the first one.
>
> I'm not quite sure about the information that I have to provide. So
> let me know. The only thing I can say is that the load haven't
> increase that much this week. It seems to be consuming and not giving
> back the memory.
>
> Thank you in advance.
>
> --
> Regards,
> S=E9bastien Han.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
