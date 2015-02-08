From: David McBride <dwm37@cam.ac.uk>
Subject: Re: Bounding OSD memory requirements during peering/recovery
Date: Sun, 08 Feb 2015 20:05:59 +0000
Message-ID: <54D7C1A7.1090907@cam.ac.uk>
References: <54D78939.4000708@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:43279 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233AbbBHUFk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Feb 2015 15:05:40 -0500
Received: from cpc17-cmbg14-2-0-cust484.5-4.cable.virginm.net ([86.6.155.229]:56826 helo=[192.168.8.2])
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
	with esmtpsa (PLAIN:dwm37) (TLSv1.2:DHE-RSA-AES128-SHA:128)
	id 1YKY6t-0001b5-pd (Exim 4.82_3-c0e5623) for ceph-devel@vger.kernel.org
	(return-path <dwm37@cam.ac.uk>); Sun, 08 Feb 2015 20:05:39 +0000
In-Reply-To: <54D78939.4000708@cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel <ceph-devel@vger.kernel.org>

On 08/02/15 16:05, David McBride wrote:

> Reading around the subject, I came across `leaksanitiser`, a clang/LL=
VM:
> facility:
>
>   https://code.google.com/p/address-sanitizer/wiki/LeakSanitizer
>
> =E2=80=A6 as well as ticket #9756, which suggests using Clang's other=
 static
> analysis capabilities to help flag potentially problematic code:
>
>   http://tracker.ceph.com/issues/9756

I've gone ahead and implemented this.  I've submitted a pull-request vi=
a=20
Github, visible here:

  https://github.com/ceph/autobuild-ceph/pull/22

I've not tried to replicate the gitbuilder environment directly, so=20
these changes are untested, though should work =E2=80=94 at least, once=
=20
someone's added 'clang' to the list of packages to be autoprovisioned!

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
