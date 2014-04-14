From: David McBride <dwm37@cam.ac.uk>
Subject: Re: Ceph daemon memory utilization: 'heap release' drops use by 50%
Date: Mon, 14 Apr 2014 15:14:54 +0100
Message-ID: <534BED5E.3000801@cam.ac.uk>
References: <534BD487.5090507@cam.ac.uk>	<CAPYLRzhJL93sgo0QnHZHy72f77m4NwZ+nG+LkSU6RP8UEL4PSw@mail.gmail.com>	<534BEAFC.8000306@cam.ac.uk> <CAPYLRzhN8fyuyOw5KUbHn=6sEaKbUjY=cZAjTKQjd7FVazBDUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:47078 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbaDNOOz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Apr 2014 10:14:55 -0400
In-Reply-To: <CAPYLRzhN8fyuyOw5KUbHn=6sEaKbUjY=cZAjTKQjd7FVazBDUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On 14/04/14 15:10, Gregory Farnum wrote:
> Hum. We see scattered reports of this occasionally (although it seems
> to clump), but usually it's on self-built distros. It's not behavior
> we've encountered on any regular basis and it's not expected. If
> you're getting all your packages from Canonical, you should probably
> report the bug to them as well =E2=80=94 it might be a tcmalloc issue=
 they can
> resolve in their repo.

Hi,

That's useful information.   I'll investigate further and flag it
upstream if it looks like a repeatable problem.

Thanks!

Cheers,
David
--=20
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Information Services
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
