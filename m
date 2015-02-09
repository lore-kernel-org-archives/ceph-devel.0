From: David McBride <dwm37@cam.ac.uk>
Subject: Re: Bounding OSD memory requirements during peering/recovery
Date: Mon, 09 Feb 2015 10:38:16 +0000
Message-ID: <54D88E18.7080708@cam.ac.uk>
References: <54D78939.4000708@cam.ac.uk> <54D7C1A7.1090907@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:51684 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759582AbbBIKh4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 05:37:56 -0500
Received: from dmcbride-adsl.demon.co.uk ([62.49.26.146]:43203 helo=[10.0.0.49])
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
	with esmtpsa (PLAIN:dwm37) (TLSv1.2:DHE-RSA-AES128-SHA:128)
	id 1YKlj1-00032r-D7 (Exim 4.82_3-c0e5623) for ceph-devel@vger.kernel.org
	(return-path <dwm37@cam.ac.uk>); Mon, 09 Feb 2015 10:37:55 +0000
In-Reply-To: <54D7C1A7.1090907@cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel <ceph-devel@vger.kernel.org>

On 08/02/15 20:05, David McBride wrote:

>   https://github.com/ceph/autobuild-ceph/pull/22
>
> I've not tried to replicate the gitbuilder environment directly, so
> these changes are untested, though should work =E2=80=94 at least, on=
ce
> someone's added 'clang' to the list of packages to be autoprovisioned=
!

I've now updated this pull request; now also implemented:

  * Updates to fabfile.py to cause clang (and clang-analyzer on RPM
    machines) to be installed prior to builds.

  * Added the '-analyze' hostname affix, which causes Ceph to be built
    with the 'scan-build' static-analysis wrapper.  As a side-effect of
    compilation, a static-analysis of Ceph's code will also be run; the
    resulting report will be deposited in scan-build.tmp/.

  * Tweaked the environment of clang builds so that it shouldn't
    generate spurious errors when being run with versions of
    ccache < 3.2.

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
