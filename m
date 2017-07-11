From: Sage Weil <sage@newdream.net>
Subject: Re: Cmake: determening Ceph version when there is no git checkout.
Date: Tue, 11 Jul 2017 14:34:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707111434220.3424@piezo.novalocal>
References: <7683db13-17fc-44a8-cb6c-bcc83048378a@digiware.nl> <alpine.DEB.2.11.1707111404340.3424@piezo.novalocal> <992deb10-b689-ebf7-947c-e7abefcdb878@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47917 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932722AbdGKOeu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 10:34:50 -0400
In-Reply-To: <992deb10-b689-ebf7-947c-e7abefcdb878@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 11 Jul 2017, Willem Jan Withagen wrote:
> On 11-7-2017 16:05, Sage Weil wrote:
> > On Tue, 11 Jul 2017, Willem Jan Withagen wrote:
> >> Hi,
> >>
> >> I'm doing some work to be ready when Luminous gets fully released.
> >> But I now run into the following code from src/CMakeLists.txtx
> >> ====
> >> # the src/.git_version file may be written out by make-dist; otherwise
> >> # we pull the git version from .git
> >> option(ENABLE_GIT_VERSION "build Ceph with git version string" ON)
> >> if(${ENABLE_GIT_VERSION})
> >>   get_git_head_revision(GIT_REFSPEC CEPH_GIT_VER)
> >>   git_describe(CEPH_GIT_NICE_VER --always)
> >>   #if building from a source tarball via make-dist
> >>   if(${CEPH_GIT_VER} STREQUAL "GITDIR-NOTFOUND")
> >>     message(STATUS "Ceph/.git directory not found, parsing
> >> ${CMAKE_CURRENT_SOURCE_DIR}/.git_version for CEPH_GIT_VER and
> >> CEPH_GIT_NICE_VER")
> >>     file(STRINGS ${CMAKE_CURRENT_SOURCE_DIR}/.git_version
> >> CEPH_GIT_SHA_AND_TAG)
> >>     list(GET CEPH_GIT_SHA_AND_TAG 0 CEPH_GIT_VER)
> >>     list(GET CEPH_GIT_SHA_AND_TAG 1 CEPH_GIT_NICE_VER)
> >>   endif(${CEPH_GIT_VER} STREQUAL "GITDIR-NOTFOUND")
> >>   # remove 'v' prefix from raw git version
> >>   string(SUBSTRING ${CEPH_GIT_NICE_VER} 1 -1 CEPH_GIT_NICE_VER)
> >> else(${ENABLE_GIT_VERSION})
> >>   set(CEPH_GIT_VER "no_version")
> >>   set(CEPH_GIT_NICE_VER "Development")
> >> endif(${ENABLE_GIT_VERSION})
> >> ====
> >>
> >> This build the Ceph version from data in the .git repo.
> >> But that is not how FreeBSD packaging works. There a tarbal is fetched
> >> but that does not contain any git info.
> >>
> >> Work is done in:
> >> 	/usr/ports/net/ceph/work/ceph-12.1.0
> >> and that is about all where I can extract some versioning from.
> >>
> >> Does anybody have suggestions for an easy way out?
> >> Other than hardcode it in the Makefile as an option to CMake.
> > 
> > Take a look at the make-dist script; it puts the git version info in a 
> > tarball that has everything needed to build.  (i.e., it writes out 
> > the .git_version file referenced above.)
> 
> I think I used the wrong words....
> 
> The make-dis script begins with:
> if [ ! -d .git ]; then
>     echo "no .git present.  run this from the base dir of the git checkout."
>     exit 1
> fi
> 
> When I say tarball, I mean that the FreeBSD packaging system will fetch
> something like:
> https://codeload.github.com/ceph/ceph-v12.1.0_GH0.tar.gz
> 
> And that tar file does not contain ANY git information.
> So I have to extract that from somewhere/something else. All I know is
> the TAG v12.1.0. So if I want to have a git hash in the version I need
> to construct it from that, or use that reference to fetch the hash.
> 
> Otherwise I'll need to put it in the package makefile everytime, I
> release a new version.

Can you instead fetch the tarball from download.ceph.com?  Those 
tarballs are generated with make-dist and already include the 
.git_version information.

sage
