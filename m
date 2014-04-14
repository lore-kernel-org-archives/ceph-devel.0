From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph daemon memory utilization: 'heap release' drops use by 50%
Date: Mon, 14 Apr 2014 07:10:58 -0700
Message-ID: <CAPYLRzhN8fyuyOw5KUbHn=6sEaKbUjY=cZAjTKQjd7FVazBDUA@mail.gmail.com>
References: <534BD487.5090507@cam.ac.uk>
	<CAPYLRzhJL93sgo0QnHZHy72f77m4NwZ+nG+LkSU6RP8UEL4PSw@mail.gmail.com>
	<534BEAFC.8000306@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:33988 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbaDNOK7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Apr 2014 10:10:59 -0400
Received: by mail-qa0-f41.google.com with SMTP id j5so8144395qaq.28
        for <ceph-devel@vger.kernel.org>; Mon, 14 Apr 2014 07:10:58 -0700 (PDT)
In-Reply-To: <534BEAFC.8000306@cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David McBride <dwm37@cam.ac.uk>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

Hum. We see scattered reports of this occasionally (although it seems
to clump), but usually it's on self-built distros. It's not behavior
we've encountered on any regular basis and it's not expected. If
you're getting all your packages from Canonical, you should probably
report the bug to them as well =E2=80=94 it might be a tcmalloc issue t=
hey can
resolve in their repo.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Mon, Apr 14, 2014 at 7:04 AM, David McBride <dwm37@cam.ac.uk> wrote:
> On 14/04/14 14:53, Gregory Farnum wrote:
>> What distro are you running on?
>> -Greg
>
> Hi Greg,
>
> This is sitting atop a pre-release build of Ubuntu 14.04, using the
> packages provided by same.
>
> dpkg-query -W ceph shows:
>
> ceph    0.79-0ubuntu1
>
> ceph --version shows:
>
> ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)
>
> Note that I'm currently half-way through nuking my existing cluster (=
to
> reduce my PG count, and experiment with different OSD filesystems); I=
'm
> happy to run experiments, but there'll be a small lag while I bring t=
he
> cluster back up!
>
> Cheers,
> David
> --
> David McBride <dwm37@cam.ac.uk>
> Unix Specialist, University Information Services
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
