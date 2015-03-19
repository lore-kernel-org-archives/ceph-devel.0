From: Sage Weil <sage@newdream.net>
Subject: Re: rados_dll: A Windows port of librados
Date: Thu, 19 Mar 2015 08:27:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503190822150.9418@cobra.newdream.net>
References: <CAHJ4zomaFxzJMBo+v50DUX=bycyagzWOfckoXPFcm1THFK8DQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44959 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbbCSP1e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 11:27:34 -0400
In-Reply-To: <CAHJ4zomaFxzJMBo+v50DUX=bycyagzWOfckoXPFcm1THFK8DQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alistair Israel <aisrael@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Alistair,

On Thu, 19 Mar 2015, Alistair Israel wrote:
> Hi, ceph.
> 
> We are pleased to announce our first milestone in bringing Ceph to the
> Windows platform, by porting librados into rados.dll.
> 
> https://github.com/AcalephStorage/rados_dll

This is exciting!
 
> Many thanks to dketor@gmail.com and the ceph-dokan project for
> providing the springboard and early consultation with which we were
> able to embark upon this course (we've also forked ceph-dokan and are
> looking to be active contributors to that project).
> 
> ### Overview
> 
>   * rados_dll is built using mingw, like ceph-dokan
>   * Currently, it builds rados.dll, used by rados_client.exe
>   * rados.dll provides the librados C API (linking C++ using .DLLs is
> problematic)
>   * rados_client.exe follows example code here
> (http://ceph.com/docs/master/rados/api/librados-intro/) to drive
> rados.dll, connect to a Ceph cluster and perform I/O
>   * LGLP v2.1
> 
> ### Details
> 
> Currently, rados_dll is built, similar to ceph-dokan, from source
> files copied over from ceph/src and with _WIN32 specific
> modifications. It is built using gcc, and uses winsock.
> 
> ### Next steps
> 
> We've had to disable cephx authentication for now, obviously we need
> to get this ported and working properly.
> 
> Currently, the build environment has to be carefully prepared by hand.
> We're looking to add scripts to help ease and automate that process.
> 
> We're looking to streamline merging of changes from 'upstream' ceph.
> First, we intend to remove unmodified source files from the src/
> directory and use upstream ceph/src directly.
> 
> Next, we're looking to use tools (e.g. diff/patch, sed) to the apply
> _WIN32 specific modifications in an automated manner whenever possible
> to generate _WIN32 sources.
> 
> We hope to gain enough traction and credibility to contribute _WIN32
> specific sections (with appropriate guards) to ceph core code.
> Eventually, hopefully, we might be able to build rados.dll (along with
> other Ceph components that can be ported to Windows) directly from a
> single set of source files.

I'm glad to see this.  As I said to Ketor about ceph-dokan, the goal 
should definitely be get the portability changes upstream.  There are a 
few other porting effots underway (Solaris, AIX; aarch64, MIPS) and 
ultimately we want to make sure we're building portability wrappers around 
the appropriate pieces to avoid a tangle of #ifdef's or hard to maintain 
forks.  As you isolate these changes, let us know so we can start 
testing and merging them.

> Finally, our Makefile is hand-written (as with ceph-dokan), and we
> welcome any help to be able to standardise on using the autotools
> toolchain to automate that as well (or integrate with upstream).

Would CMake make your life easie?

sage

> ### Roadmap
> 
> We're looking at tackling RBD soon, and provide a native, Windows
> system-level block device backed by Ceph. ;)
> 
> We welcome any and all comments, suggestions, and support.
> 
> ### Who we are
> 
> Acaleph is a small startup headquartered in Singapore, but operating mostly from
> the Philippines, and we provide Ceph deployment, integration, support
> and other services.
> 
> Julio Telan is a graduating student from De La Salle University
> spending his internship at Acaleph, mentored by yours truly.
> 
> Cheers!
> 
> Alistair A. Israel, alistair@acale.ph
> Julio Telan, julio_telan@dlsu.edu.ph
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
