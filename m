From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Appearing messages per 10 sec
Date: Tue, 29 May 2012 10:55:03 -0700
Message-ID: <CADvuQRHszFehxiq-D0uQV+hLXK35rC3DR2xHK=kBfJ43h2NJ-g@mail.gmail.com>
References: <20120528185235.CBC5.33BC0F0F@bit-isle.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42993 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab2E2RzY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 13:55:24 -0400
Received: by pbbrp8 with SMTP id rp8so6270394pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 10:55:24 -0700 (PDT)
In-Reply-To: <20120528185235.CBC5.33BC0F0F@bit-isle.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomoki BENIYA <beniya@bit-isle.co.jp>
Cc: ceph-devel@vger.kernel.org

On Mon, May 28, 2012 at 3:35 AM, Tomoki BENIYA <beniya@bit-isle.co.jp> =
wrote:
> Following messages are appearing per 10 sec on terminal of mds.1.
> But, not appearing on mds.0.
>
> What does these mean? And, how to stop these?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Message from syslogd@mds1 at May 28 19:26:03 ...
> =C2=A0ceph-mds: 2012-05-28 19:26:03.497958 7fede74e5700 =C2=A00 mds.0=
=2Ebal =C2=A0 mds.0 mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0=
=2E05> =3D 0 ~ 0

That looks like
https://github.com/ceph/ceph/blob/master/src/mds/MDBalancer.cc#L472
which looks like a diagnostic message only output by the root MDS.
That's why you only see it on one of your MDS servers.

It's a harmless status message. It's logged at a fairly high priority,
but you can ignore it.

The decision to output it to a console is made by your syslog daemon,
and that is the right place to configure that.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
