From: Sage Weil <sage@newdream.net>
Subject: Re: Debs must not contain /var/run
Date: Fri, 9 Sep 2011 21:17:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109092117040.17656@cobra.newdream.net>
References: <CAORUGqDWnPYmDpXqjpMitdDV7bAKnrHKFFu2zqzD4cT-X90UmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49406 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab1IJELp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Sep 2011 00:11:45 -0400
In-Reply-To: <CAORUGqDWnPYmDpXqjpMitdDV7bAKnrHKFFu2zqzD4cT-X90UmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 9 Sep 2011, Tommi Virtanen wrote:
> Hi. Commit a73d5 is bad. Debs must not contain /var/run; the FHS
> defines /var/run as being emptied at boot, so there is no permanent
> storage there. Any subdirectories you need there must be re-created by
> the init scripts.
> 
> http://ceph.newdream.net/gitbuilder-deb-amd64/log.cgi?log=a73d53fdcb2a0734812bc3159e929dde7ae9089f

BTW the good news here is that the deb gitbuilder does a lintian check at 
the end and errors out on this.  Yay!

sage

