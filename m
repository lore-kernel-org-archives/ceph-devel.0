From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: [ceph-users] Mounting Ceph on Linux/Windows
Date: Fri, 6 Dec 2013 11:25:15 -0500 (EST)
Message-ID: <1703010054.44.1386347115829.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <287502324.42.1386347088605.JavaMail.root@thunderbeast.private.linuxbox.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4123 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab3LFQZj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 11:25:39 -0500
In-Reply-To: <287502324.42.1386347088605.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, Knut Moe <kmoe66@gmail.com>, James Harper <james.harper@bendigoit.com.au>

Hi,

The CMake integration can help with this, as it can generate nmake files,
vs project files, etc.

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> On Fri, 6 Dec 2013, James Harper wrote:
> > > 
> > > > For win32 my current scheme is to just throw out all the
> configure and
> > > > automake stuff and have a static makefile, so the build
> procedure is 'cd
> > > > win32; make'. Do you think that's acceptable?
> > > 
> > > I think that's a fine, certainly as a place to start.  (I'm not
> sure there
> > > is going to be a better solution that doesn't rely on mingw32 or
> cygwin or
> > > something.)
> > > 
> > > > I suppose the configure
> > > > could be modified to work with a mingw32 cross compile under
> Linux, but
> > > > it might be a bit of a stretch to make it work in mingw32
> environment
> > > > under Windows (or maybe it's easy... I've never used mingw32
> under
> > > > Windows). At this time the configure and Makefile stuff would
> need to be
> > > > able to build only selective bits as a lot of stuff doesn't
> currently
> > > > build under Windows, and some may never build... osd under
> windows
> > > would
> > > > be a pretty big project for something with very limited appeal
> (imho)
> > > 
> > > Yep!

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
