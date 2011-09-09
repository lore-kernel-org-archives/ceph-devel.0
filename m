From: Sage Weil <sage@newdream.net>
Subject: Re: Debs must not contain /var/run
Date: Fri, 9 Sep 2011 09:16:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109090912270.29097@cobra.newdream.net>
References: <CAORUGqDWnPYmDpXqjpMitdDV7bAKnrHKFFu2zqzD4cT-X90UmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43053 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989Ab1IIQK6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2011 12:10:58 -0400
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

Reverted!  Looks like the ceph init script is already creating the 
pid_file dir.

This came up because we were configuring radosgw's socket to be in 
/var/run/ceph, but it didn't exist.  The radosgw package doesn't even have 
an init script at this point, though (since it's not strictly required 
that you run it that way), so whatever.  At some point we should decide 
how much to encourage/streamline that mode of running it...

sage
