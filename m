From: Sage Weil <sage@newdream.net>
Subject: Re: ceph 0.44+ and leveldb
Date: Fri, 6 Apr 2012 09:49:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204060943510.3020@cobra.newdream.net>
References: <1333689498.19737.11.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53205 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab2DFQuI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 12:50:08 -0400
In-Reply-To: <1333689498.19737.11.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

Hi Laszlo,

On Fri, 6 Apr 2012, Laszlo Boszormenyi wrote:
> Hi Ceph developers,
> 
> It seems you included leveldb in the source of Ceph. It has two serious
> problems.
> First, security. Now leveldb can't be updated to a newer version, only
> with Ceph. Worst, security teams may not notice leveldb is embedded into
> Ceph; meaning the latter would remain unfixed and vulnerable.

The problem here is that libleveldb-dev is only packaged for wheezy and 
precise, and we'd like to build packages for squeeze and oneiric, and 
make the build experience easy for non-debian/ubuntu users.  (I didn't 
check whether it was in rpm-based distros.)

I think the ideal situation would be for the debs to build against the 
debian package, and allow others an easy way to get the correct source 
(by bundling it in the ceph source tarball, or via a simple build script 
that does the equivalent of git submodule update --init).

Do you have a clear picture of how that would work?

> Second, as it doesn't contain fixes for various architectures that a
> separately packaged leveldb has, it can make Ceph fail to build on
> several architectures where leveldb is built otherwise.
> 
> See the Debian build list for example:
> https://buildd.debian.org/status/package.php?p=ceph+leveldb&suite=sid
> 
> Also, leveldb doesn't work on all architectures. Making Ceph less
> portable, which means less users can reach it.
> See the build failures for ia64, mips, powerpc and s390[x]:
> -- cut --
> from ./db/builder.cc:7:
> ./port/atomic_pointer.h:133:2: error: #error Please implement AtomicPointer for this platform.
> make[5]: *** [builder.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [all] Error 2
> make[5]: Leaving directory `/build/buildd-ceph_0.44.1-1-ia64-2UAFHZ/ceph-0.44.1/src/leveldb'
> -- cut --

So the leveldb deb has all those fixes?  That would make things easy for 
us.

sage
