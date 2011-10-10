From: Hannes Reinecke <hare@suse.de>
Subject: Re: RPMs on build.opensuse.org
Date: Mon, 10 Oct 2011 08:17:33 +0200
Message-ID: <4E928DFD.40803@suse.de>
References: <Pine.LNX.4.64.1110041025030.23052@cobra.newdream.net> <201110071216.12793.cndegen@suse.de> <Pine.LNX.4.64.1110092117360.26432@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37245 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab1JJGRf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Oct 2011 02:17:35 -0400
In-Reply-To: <Pine.LNX.4.64.1110092117360.26432@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Christian Degen <cndegen@suse.de>, PChadwick@suse.com, dona.holmberg@dreamhost.com, Bryan Bogensberger <bryan@newdream.net>

Hi Sage,
On 10/10/2011 06:39 AM, Sage Weil wrote:
> Hey everyone,
>
> Over the last few days I've wasted far more hours than I care to
> remember/admit futzing around with the ceph.spec file.  The goal is t=
o use
> build.opensuse.org (or maybe a private instance) to build RPMs for
> multiple platforms, including opensuse, sles, fedora, rhel, and cento=
s.
>
> 	https://build.opensuse.org/package/show?package=3Dceph&project=3Dhom=
e%3Aliewegas
>
> A few things:
>   - I can't build packages in the actual RHEL environments because so=
me
>     legal thing makes the -devel packages unavailable, so you need to=
 look
>     at the CentOS ones instead.
>   - A bunch of debian targets are listed, but I didn't pull the debia=
n/ dir
>     out of the tarball, so those show up as excluded currently.
>   - The tarball that in the build.opensuse.org repo is a snapshot fro=
m
>     recent master, not the actual ceph-0.36.tar.gz.  The .spec file a=
lso
>     has several changes that aren't in ceph.git yet.  Work from the
>     openbuild versions and I'll integrate back into the upstream once
>     things actually work.
> 	https://build.opensuse.org/package/files?package=3Dceph&project=3Dho=
me%3Aliewegas
>
> Here is where things currently stand:
>
>   - openSUSE_Tumbleweed, openSUSE_Factory, openSUSE_11.4, openSUSE_11=
=2E3
>     - Seems to build fine...
>     - ...but there are errors about insserv I have no idea how to fix=
:
>
> insserv: FATAL: service network has to be enabled to use service ceph
> insserv: exiting now!
> /sbin/insserv failed, exit code 1
>
>   - SLE_11, SLE_11_SP1:
>     - The configure libedit check defines LIBEDIT_LIBS, which include=
s
>       -lcurses, and ncurses-devel gets installed, but
>
> /usr/lib64/gcc/x86_64-suse-linux/4.3/../../../../x86_64-suse-linux/bi=
n/ld:
> cannot find -lcurses
>
>       This is annoying, because the configure macro is the one decidi=
ng to
>       link that in in the first place...  Do I need to list some othe=
r
>       ncurses -devel package explicitly as a build depenency??
>
>
>   - Fedora_14, 15 i586:
>     - The atomic test and set stuff doesn't seem to work on a uint32_=
t:
>
> /home/abuild/rpmbuild/BUILD/ceph-0.36/src/common/simple_spin.cc:42:
> undefined reference to `__sync_bool_compare_and_swap_4'
>
>
>   - Suddenly build.opensuse.org isn't showing build logfiles anymore
>     ('remote error: no socket attached'), so I don't have details on =
the
>     others.  :(
>
> In case it isn't obvious, I know next to nothing about writing spec
> files, and have probably made a mess of things trying to make it happ=
y on
> all of these platforms.  Any help here would be greatly appreciated!
>
Hmm. Seems this hasn't been send in your direction, but I've already=20
put ceph in the buildservice:

home:hreinecke:storage

The insserv thing is easy to workaround; just don't enable service=20
ceph when installing the package :-)

But note I had to fiddle with the spec file a bit (the one from git=20
tree seems to be a bit outdated).
And I've had to do two minor tweaks for openSUSE/SLES:
- 'docdir' is defined in configure.ac; this prohibits it to be=20
redefined from the commandline. We should rather leave it empty and=20
have it specified via the --docdir switch.
- openSUSE/SLES installs the fastcgi headers in its own subdir,
   so we need some configure logic to test for this.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
