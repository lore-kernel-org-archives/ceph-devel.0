From: Sage Weil <sage@newdream.net>
Subject: Re: RPMs on build.opensuse.org
Date: Wed, 12 Oct 2011 13:02:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110121257320.13152@cobra.newdream.net>
References: <Pine.LNX.4.64.1110041025030.23052@cobra.newdream.net>
 <201110071216.12793.cndegen@suse.de> <Pine.LNX.4.64.1110092117360.26432@cobra.newdream.net>
 <4E928DFD.40803@suse.de> <Pine.LNX.4.64.1110101937300.7288@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47630 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab1JLUCM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2011 16:02:12 -0400
In-Reply-To: <Pine.LNX.4.64.1110101937300.7288@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: ceph-devel@vger.kernel.org, Christian Degen <cndegen@suse.de>, PChadwick@suse.com, dona.holmberg@dreamhost.com, Bryan Bogensberger <bryan@newdream.net>

Hey,

The Fedora 14/15 i586 failures came up on IRC.  It looks like the 
openbuild fedora environments don't have redhat-rpm-config installed, and 
as a result the RPM_OPT_FLAGS are building for i386 instead of something a 
bit less ancient.

For now I can hack around that in the .spec, but presumably that should be 
fixed on build.opensuse.org?

Reposting the IRC conversation here for posterity:

(11:10:53 AM) danpb: Tv|work: i can't remember exactly why - its in email 
threas somewhere,  but  Fedora does   -march=i386  -mtune=i686 
(11:11:11 AM) Tv|work: danpb: because somebody had an early pentium 
machine that they really really loved?
(11:12:08 AM) Tv|work: some googling tells me fedora switched from i386 to 
i586 default in 2009: 
http://lists.fedoraproject.org/pipermail/devel-announce/2009-March/000378.html
(11:12:22 AM) Tv|work: 
http://fedoraproject.org/wiki/Features/ArchitectureSupport
(11:12:40 AM) danpb: sagewk: before this line of ceph.spec.in 
(11:12:40 AM) danpb:    make -j$(getconf _NPROCESSORS_ONLN) 
CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
(11:13:07 AM) danpb: try doing something like      
(11:13:07 AM) danpb: export RPM_OPT_FLAGS=`echo $RPM_OPT_FLAGS | sed -e 
's/i386/i486/'`
(11:13:39 AM) Tv|work: 
http://fedoraproject.org/wiki/Features/F12X86Support says i686 for F12 -- 
etc
(11:15:44 AM) sagewk: danpb: oh right, this section is just shell
(11:20:33 AM) danpb: Tv|work: hmm, yes, it could be the suse builders 
don't have  a redhat-rpm-config installed to set the opts correctly then 
(11:25:48 AM) danpb: Tv|work: sagewk  ah yes, i confirmed the machine i 
had this problem on was missing  'redhat-rpm-config' package. installing 
that fixes the compile flags to -march=i686 -mtune=atom

sage



On Mon, 10 Oct 2011, Sage Weil wrote:

> Hi Hannes!
> 
> On Mon, 10 Oct 2011, Hannes Reinecke wrote:
> > Hi Sage,
> > On 10/10/2011 06:39 AM, Sage Weil wrote:
> > > Hey everyone,
> > > 
> > > Over the last few days I've wasted far more hours than I care to
> > > remember/admit futzing around with the ceph.spec file.  The goal is to use
> > > build.opensuse.org (or maybe a private instance) to build RPMs for
> > > multiple platforms, including opensuse, sles, fedora, rhel, and centos.
> > > 
> > > 	https://build.opensuse.org/package/show?package=ceph&project=home%3Aliewegas
> > > 
> > > A few things:
> > >   - I can't build packages in the actual RHEL environments because some
> > >     legal thing makes the -devel packages unavailable, so you need to look
> > >     at the CentOS ones instead.
> > >   - A bunch of debian targets are listed, but I didn't pull the debian/ dir
> > >     out of the tarball, so those show up as excluded currently.
> > >   - The tarball that in the build.opensuse.org repo is a snapshot from
> > >     recent master, not the actual ceph-0.36.tar.gz.  The .spec file also
> > >     has several changes that aren't in ceph.git yet.  Work from the
> > >     openbuild versions and I'll integrate back into the upstream once
> > >     things actually work.
> > > 	https://build.opensuse.org/package/files?package=ceph&project=home%3Aliewegas
> > > 
> > > Here is where things currently stand:
> > > 
> > >   - openSUSE_Tumbleweed, openSUSE_Factory, openSUSE_11.4, openSUSE_11.3
> > >     - Seems to build fine...
> > >     - ...but there are errors about insserv I have no idea how to fix:
> > > 
> > > insserv: FATAL: service network has to be enabled to use service ceph
> > > insserv: exiting now!
> > > /sbin/insserv failed, exit code 1
> > > 
> > >   - SLE_11, SLE_11_SP1:
> > >     - The configure libedit check defines LIBEDIT_LIBS, which includes
> > >       -lcurses, and ncurses-devel gets installed, but
> > > 
> > > /usr/lib64/gcc/x86_64-suse-linux/4.3/../../../../x86_64-suse-linux/bin/ld:
> > > cannot find -lcurses
> > > 
> > >       This is annoying, because the configure macro is the one deciding to
> > >       link that in in the first place...  Do I need to list some other
> > >       ncurses -devel package explicitly as a build depenency??
> > > 
> > > 
> > >   - Fedora_14, 15 i586:
> > >     - The atomic test and set stuff doesn't seem to work on a uint32_t:
> > > 
> > > /home/abuild/rpmbuild/BUILD/ceph-0.36/src/common/simple_spin.cc:42:
> > > undefined reference to `__sync_bool_compare_and_swap_4'
> > > 
> > > 
> > >   - Suddenly build.opensuse.org isn't showing build logfiles anymore
> > >     ('remote error: no socket attached'), so I don't have details on the
> > >     others.  :(
> > > 
> > > In case it isn't obvious, I know next to nothing about writing spec
> > > files, and have probably made a mess of things trying to make it happy on
> > > all of these platforms.  Any help here would be greatly appreciated!
> > > 
> > Hmm. Seems this hasn't been send in your direction, but I've already put ceph
> > in the buildservice:
> > 
> > home:hreinecke:storage
> > 
> > The insserv thing is easy to workaround; just don't enable service ceph when
> > installing the package :-)
> 
> Hmm, yeah... Is that the right thing to do though?  Don't RPMs normally 
> enable the serve when you install them?
> 
> > But note I had to fiddle with the spec file a bit (the one from git tree seems
> > to be a bit outdated).
> > And I've had to do two minor tweaks for openSUSE/SLES:
> > - 'docdir' is defined in configure.ac; this prohibits it to be redefined from
> > the commandline. We should rather leave it empty and have it specified via the
> > --docdir switch.
> > - openSUSE/SLES installs the fastcgi headers in its own subdir,
> >   so we need some configure logic to test for this.
> 
> I've fixed both of these in the upstream ceph.git, at least...
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
