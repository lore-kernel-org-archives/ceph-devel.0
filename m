From: Sage Weil <sage@inktank.com>
Subject: Re: Seg Fault on rgw 0.61.1 with cluster in 0.61
Date: Thu, 16 May 2013 10:35:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305161033310.28450@cobra.newdream.net>
References: <367CC0B0FC02EE47BF7482398BD623C55E230EFF@DB3PRD0311MB416.eurprd03.prod.outlook.com> <CABBk=J_QaRUFmq_gPHeywkkRSJaaAzMz0eM8jZ15+FQKuQo5Bw@mail.gmail.com> <51922B01.5060900@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59467 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab3EPRfJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 13:35:09 -0400
In-Reply-To: <51922B01.5060900@debian.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Faidon Liambotis <paravoid@debian.org>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Yann ROBIN <yann.robin@youscribe.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 14 May 2013, Faidon Liambotis wrote:
> On 05/10/13 19:02, Yehuda Sadeh wrote:
> > Sounds to me like package versioning mismastch. Could it be that one
> > of the ceph packages was on a different version (e.g., librados).
> 
> I attempted to install and run radosgw 0.61.1 on a system with a 0.56.4
> librados and it segfaulted with the same backtrace as the one in this thread.
> 
> If a newer radosgw can't work with an older librados, this should be reflected
> on the package relationships -- hopefully without nasty Breaks/Conflicts, but
> with a proper librados SONAME bump that will allow coinstability between
> librados2 and e.g. librados3. Or symbol versioning could be employed to
> provide backwards compatibility.
> 
> This installed-but-segfaulting combination of packages shouldn't be allowed by
> apt to exist on the system. FWIW, if these were packages in Debian (and,
> presumably, Ubuntu), that would be a severity: serious/release critical bug.

I believe this is actually a problem with radosgw statically linking some 
of the same stuff that librados includes, and not with the librados ABI 
changes.  We need to fix that somehow.. In the meantime, though, setting 
the radosgw package to require a matching librados2 ought to do the trick.

> It'd also be nice to be able to do things like mixing newer radosgw while also
> keeping the old librados2 on the system. My use case is that I have monitors
> and radosgw on the same boxes and I'd like to keep monitors on bobtail, while
> at the same time use some of the much needed radosgw cuttlefish features.

ceph-common need sto match the librados2 version, but ceph (which contains 
ceph-mon) does not, so you should be able to have dufferent ceph-mon and 
radosgw versions if we do the above.

sage
