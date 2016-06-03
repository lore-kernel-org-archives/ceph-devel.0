From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Shall we remove static libraries from *-dev debian pacakges?
Date: Fri, 3 Jun 2016 13:39:53 -0400
Message-ID: <20160603173953.GA27895@ultraspiritum.eng.arb.redhat.com>
References: <CAJE9aOMma9roYzaTnPE7WdSf4s93QDqTvy6N87YcMgRuyQiR4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbcFCRkR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 3 Jun 2016 13:40:17 -0400
Content-Disposition: inline
In-Reply-To: <CAJE9aOMma9roYzaTnPE7WdSf4s93QDqTvy6N87YcMgRuyQiR4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 04/06/2016, kefu chai wrote:
> Hi Cephers,
>
> As your know, we are trying to ditch autotools and moving to the cmake
> building system. Currently, we ship both static (.a) and shared
> libraries (.so) and their .la files in
> lib{rbd,rgw,rados,cephfs,radosstriper}-dev debian packages, but only
> package the shared libraries in rpm packages. When working on the
> cmake, I find it's a little bit tricky to prepare both static and
> shared libraries in cmake, see [1].
> 
> So questions:
> 
> - Is it fine if we don't ship static libraries any more in the *-dev
> .deb packages just like .rpms?

Debian policy does not, to my understanding, require us to provide
static libraries. It demands only that if we have them they should be
in the -devel package.

All other things being equal I have a soft preference to ship static
libraries.

All other things are not equal.

Our static library is not a /good/ static library. We produce,
broadly, one object file per /topic/. This means any user of our
static library would link in a great deal of code even if it called
only a few functions.  If we want an efficient static library, we need
to shatter many of our source files into directories in which each
file would contain roughly one function. (Interdependence might
require more for some.)

I don't think static linking is important enough to justify the time
and bother If some users demand it was, we could reconsider. If a
developer passionately wanted to support static linking I'd be in
favor of letting them.

> - What about the .la files? can we remove them also when switching
>   to cmake?

.la files are worthless: libtool's analog of what badly trained dog
leaves on the carpet. Most unkind things one could say about libtool
are true. Devil take it, with all its bookkeeping detritus to follow.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
