From: Ali Maredia <ali@linuxbox.com>
Subject: Re: Building Ceph using CMake
Date: Tue, 17 Dec 2013 15:09:03 -0500 (EST)
Message-ID: <1045611233.81.1387310943871.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1417102805.191.1385512980002.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3441 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab3LQUJI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Dec 2013 15:09:08 -0500
In-Reply-To: <1417102805.191.1385512980002.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, Noah Watkins <noah.watkins@inktank.com>

All,

To illustrate the benefit of using CMake to build ceph I timed builds of the ceph base (a list of targets is below) on my local machine with an Intel Core 2 Duo processor that have two 2.2 GHz cores.

Here are the results I got. The following are the real times building the same exact targets.

      Build/Command   |   Make base   | Make base -j2 |
=======================================================
 Autotools trial run 1| 58mins 31secs | 39mins 31secs |
=======================================================
 Autotools trial run 2| 58mins 28secs |       -       |
=======================================================
 CMake trial run 1    | 18mins 55secs | 10mins 31secs |
=======================================================
 CMake trial run 2    | 18mins 35secs | 11mins 43secs |
=======================================================

Most of the speedup can be attributed to the fact that libtool is compiling both PIC and non-PIC versions of every source file. CMake just builds everything with -fPIC. We don't have an opinion on the matter, but you may want to consider doing the same with the autotools build.

Many source files are compiled into several targets causing them to be built multiple time. With the CMake build I was able to pull them into static libraries and link them into the targets that needed them.

In conclusion I don't have a precise apples-to-apples comparison of cmake vs. automake, but I hope my switch over to CMake has highlighted some ways to improve upon the build system and increase developer productivity and would love to hear thoughts and comments on the matter.

-Ali

----- Original Message -----
From: "Matt W. Benjamin" <matt@linuxbox.com>
To: "Noah Watkins" <noah.watkins@inktank.com>
Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>, "Ali Maredia" <ali@linuxbox.com>
Sent: Tuesday, November 26, 2013 7:43:00 PM
Subject: Re: Building Ceph using CMake

We are finding the cmake build system to be a big help, the compile-link-run
cylces seem much shorter.

Matt

----- "Noah Watkins" <noah.watkins@inktank.com> wrote:

> On Nov 26, 2013, at 2:06 PM, Ali Maredia <ali@linuxbox.com> wrote:
> 
> > Hi all,
> > 
> > I'm a student working on a project to make ceph build faster and to
> help with efforts to port ceph to other platforms using cmake. 
> 
> CMake is awesome. Also, you might be interested in checking out the
> portability work going on at github.com/ceph/ceph wip-port.
> 
> -Noah
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
