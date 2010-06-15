From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: setup ceph cluster failed
Date: Tue, 15 Jun 2010 13:31:41 -0700
Message-ID: <AANLkTik8gRPzwBzzI8rJGp2b-o6dpoFzRcGJZORC81sY@mail.gmail.com>
References: <AANLkTikdrTuquXK2sr5rz4rRASJWHvkVzkw4Y26rusds@mail.gmail.com>
	<AANLkTikuhGLl59papaPJPvfN584gPi-B10xiXIZNrS-O@mail.gmail.com>
	<AANLkTimknLJUt0GetPjwA7ZV9t_DWb1btOFMtd8XXY80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57583 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab0FOUbm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jun 2010 16:31:42 -0400
Received: by vws13 with SMTP id 13so1693488vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jun 2010 13:31:41 -0700 (PDT)
In-Reply-To: <AANLkTimknLJUt0GetPjwA7ZV9t_DWb1btOFMtd8XXY80@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Min Zhou <coderplay@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 15, 2010 at 1:17 PM, Min Zhou <coderplay@gmail.com> wrote:
> Here is my ceph.conf at /home/ceph/ceph.conf
=2E. snip
> =A0 =A0 =A0 pid file =3D $CEPH_CONF/out/$name.pid
Currently there are only a limited number of variables that you can
use for replacement: $type, $id, $num, $name and $host. You can't use
environment variables yet, although adding it might be a good idea.

> =A0 =A0 =A0 mon data =3D $CEPH_OSD_DIR/dev/mon0"
=2E..
> =A0 =A0 =A0 mon data =3D $CEPH_OSD_DIR/dev/mon1"
The same goes here. Note also that you're missing quotes anyway.


Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
