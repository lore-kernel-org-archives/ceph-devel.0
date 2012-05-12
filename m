From: Jiri Horky <jiri.horky@gmail.com>
Subject: Re: ioreplay allows replaying fs traces from a strace log file
Date: Sat, 12 May 2012 09:31:58 +0000 (UTC)
Message-ID: <loom.20120512T112741-717@post.gmane.org>
References: <CAORUGqAPAnC6fJZgvZhbwHY6VNQa3+T8DRBBfiRwBmf4kBRCyw@mail.gmail.com> <4F874EDC.7030409@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36925 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab2ELJkE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 12 May 2012 05:40:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ST8nz-0001gB-GV
	for ceph-devel@vger.kernel.org; Sat, 12 May 2012 11:40:03 +0200
Received: from ip-62-24-86-17.net.upcbroadband.cz ([62.24.86.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 12 May 2012 11:40:03 +0200
Received: from jiri.horky by ip-62-24-86-17.net.upcbroadband.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 12 May 2012 11:40:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Mark Nelson <mark.nelson <at> dreamhost.com> writes:

> 
> I played around with this about a month back during a rados bench run, 
> but had some trouble getting it to work when strace was attached to an 
> already running process.  I didn't end up spending a lot of time on it 
> though.  Jeff Layton also wrote a strace analyzer tool specifically for 
> IO, but it needs a bit of work to support -f.  His stuff can be found here:
> 
> http://clusterbuffer.wetpaint.com/page/Strace+Analyzer
> 
> Mark

Hi Mark,

I am the developer of the ioreplay app (ioapps suite). I came across this post, 
could you please provide more details on the problem with replaying of 
"incomplete" strace files? It is certainly possible that there is a bug as this 
functionality was not thoroughly  tested. I willing to fix it and help you with 
that. Your sample strace file + ignore/map files + arguments would help.

Cheers
Jiri Horky


