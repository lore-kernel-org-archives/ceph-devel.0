From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Thu, 31 May 2012 21:49:10 -0700
Message-ID: <CA2A1C92-866C-404D-ADF1-E2299A197B3B@cs.ucsc.edu>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com> <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com> <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu> <05C460A496DC45689D6578B20D699425@inktank.com> <217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu> <CAHwdYF00BLvDHDWHXs2CFuLS9AdA+BVNa0YLKHRf9c56eUFhtg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:54372 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab2FAEtM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 00:49:12 -0400
In-Reply-To: <CAHwdYF00BLvDHDWHXs2CFuLS9AdA+BVNa0YLKHRf9c56eUFhtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nam Dang <namd@de.cs.titech.ac.jp>
Cc: Greg Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>


On May 31, 2012, at 9:44 PM, Nam Dang wrote:

> I pulled the Java lib from https://github.com/noahdesu/ceph/tree/wip-java-cephfs
> However, I use ceph 0.47.1 installed directly from Ubuntu's repository
> with apt-get, not the one that I built with the java library. I
> assumed that since the java lib is just a wrapper.
> 
>>> There are only two segfaults that I've ever encountered, one in which the C wrappers are used with an unmounted client, and the error Nam is seeing (although they
>>> could be related). I will re-submit an updated patch for the former, which should rule that out as the culprit.
> 
> No, this occurs when I call mount(null) with the monitor being taken
> down. The library should throw an Exception instead,

I agree. I'll push changes to the tree soon. Thanks.

- Noah