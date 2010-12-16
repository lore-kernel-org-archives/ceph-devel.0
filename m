From: Sage Weil <sage@newdream.net>
Subject: Re: stripping of ceph class objects
Date: Thu, 16 Dec 2010 15:55:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012161554360.30610@cobra.newdream.net>
References: <AANLkTiko9b3h46WcQU_z8PMwMatmRc1Jh-OY4S6j0R=M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44135 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab0LPXua (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 18:50:30 -0500
In-Reply-To: <AANLkTiko9b3h46WcQU_z8PMwMatmRc1Jh-OY4S6j0R=M@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Laszlo Boszormenyi <gcs@debian.hu>, ceph-devel@vger.kernel.org

On Thu, 16 Dec 2010, Yehuda Sadeh Weinraub wrote:
>  we just installed the latest ceph debian packages and it seems that
> the class objects (that are installed in /usr/lib/rados-classes/) are
> stripped. We need to keep a few symbols visible on those shared
> objects, namely, all the symbols that start with '__cls_'. Our regular
> automake resulted binaries keeps those symbols, but I guess that the
> debian packaging strips them.

Just to be clear, the package before the recent changes preserved those 
symbols.  I can't remember exactly how, but it was a bit of hack.

sage



> These symbols have the class name and version in them, which helps us
> in cases where the ceph installation is running on a cluster that
> consists of multiple architectures. A script running on the monitor
> thus should be able to identify the class name and version no matter
> what its architecture is.
> 
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
