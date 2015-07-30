From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] dropping old distros: el6, precise 12.04, debian wheezy?
Date: Thu, 30 Jul 2015 13:31:41 -0600
Message-ID: <CAANLjFrtH3DVB7qVF=D-Xx9jF1hqs==d8ku9JS0A3n=Fu=UgRQ@mail.gmail.com>
References: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36121 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbG3Tbm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 15:31:42 -0400
Received: by wicgb10 with SMTP id gb10so5162379wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jul 2015 12:31:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Ceph-User <ceph-users@ceph.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I agree that for the distros and version in question, Ceph releases
already released on them should provide bug support until EoL of Ceph
or the distro version, whichever is shorter.
Since we are so far into Infernalis and Jewel development cycle, would
it be better to make Jewel the last supported release on these
distros/versions? It would not be as much as a surprise and give
admins a little more time to transition (we are currently looking to
migrate to CentOS7 on the client side, but it will take some time so
this is also a personal request). I can understand and appreciate that
the Ceph team is stretched thin trying to maintain such a large
breadth of compatibility.

Thank you for reading,

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVunuVCRDmVDuy+mK58QAAxvkP/0QqygaVYU9fV2bu3URb
wvU4+2MT8W1zt9reYl+/42f709Us+7Abho90cMya61sIt+5t9h8oEms/5qwt
ejx6CY3WX9x5Zobku1taUUtjtW3ZGZUcQ2JegO18WwqrSXfomd1vNvgB5JsJ
KtDCv2/oCMLZWrFCXcAeoLkb/n3dwnctlsNs58911PERP7EAIMOVFBb5asee
mUoyE06Nj5RUb5r2D7XfrcBxDb6eII0KLzpjbveGrUddoMgRPm2BVbab4N84
HDM330+3vg59pKsaRjU8wEgk4yuJtbxG1SaJMDEJKWHJNe+K5MFRX/FFtfMg
6P5ygDIn+7EK5EZLgRhJl0CTUCpXKa2/bc0tZzcwqV+YXmmAvAIHLa2hjpG9
1llSOlzKIR7lputbFbUHKJzgAOLG/nOOoUTGmnWqiTDEPrj3gOdI2sqaNWoX
50pT50pvkf64Pl1RXWPafveiX4pmZcK0jAYhqZTZ7Cpa0TfuyBfsDHZTzI6k
YWunqhjqsm8mMFAr8ppjCK52e246iAdA1G7iXuPNE1yrtwhsHDc9VbqX8llT
GaevOTQQygCZ/0b4adt+HWBQTZgLi0bxIyBEo7Pg75+f8yzawTpWWx5tM4JR
yKkADT8+hid8PK6YwUrsaYnRhdRunAZv9BdvOulXyJ9azcCHSzlJWeYWHEwq
krdm
=m+W6
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Jul 30, 2015 at 7:54 AM, Sage Weil <sweil@redhat.com> wrote:
> As time marches on it becomes increasingly difficult to maintain proper
> builds and packages for older distros.  For example, as we make the
> systemd transition, maintaining the kludgey sysvinit and udev support for
> centos6/rhel6 is a pain in the butt and eats up time and energy to
> maintain and test that we could be spending doing more useful work.
>
> "Dropping" them would mean:
>
>  - Ongoing development on master (and future versions like infernalis and
> jewel) would not be tested on these distros.
>
>  - We would stop building upstream release packages on ceph.com for new
> releases.
>
>  - We would probably continue building hammer and firefly packages for
> future bugfix point releases.
>
>  - The downstream distros would probably continue to package them, but the
> burden would be on them.  For example, if Ubuntu wanted to ship Jewel on
> precise 12.04, they could, but they'd probably need to futz with the
> packaging and/or build environment to make it work.
>
> So... given that, I'd like to gauge user interest in these old distros.
> Specifically,
>
>  CentOS6 / RHEL6
>  Ubuntu precise 12.04
>  Debian wheezy
>
> Would anyone miss them?
>
> In particular, dropping these three would mean we could drop sysvinit
> entirely and focus on systemd (and continue maintaining the existing
> upstart files for just a bit longer).  That would be a relief.  (The
> sysvinit files wouldn't go away in the source tree, but we wouldn't worry
> about packaging and testing them properly.)
>
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
