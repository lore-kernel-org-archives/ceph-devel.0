From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: What ports do each of the ceph daemons listen on?
Date: Tue, 29 Mar 2011 15:13:45 -0700
Message-ID: <20110329221345.GB25743@dreamer>
References: <AANLkTik7Q6B2mDApjWTq_AvLNhbEUTA2Ojr-gq9s=FFq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43995 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab1C2WNt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2011 18:13:49 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik7Q6B2mDApjWTq_AvLNhbEUTA2Ojr-gq9s=FFq@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jay Hacker <jayqhacker@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Mar 29, 2011 at 04:27:38PM -0400, Jay Hacker wrote:
> I'd like to be able to open just the required ports in my firewall.

Typically, monitors are on TCP port 6789, but (especially when
multiple are deployed on a single host, for testing) may also use
6789+n, up to how many monitors you have. Ultimately, it's whatever
the config file says to listen on.

Anything else will open (multiple!) ephemeral ports in the range
6800..6900, and register with the monitors. These constants are
defined in src/include/msgr.h. For example, in my dev cluster, as
created by vstart.sh, cosd binds to 3 dynamic ports.

It seems there's supposed to be some support for configuring static
ports to listen on, by putting something like this in the config file:

[osd.0]
	public addr = 10.1.2.3:4567

But that definitely does not work, if you include the port (it tries
to bind multiple sockets to the same static port). Using just the IP
does let you pick what IP address the daemon uses.

I filed ticket http://tracker.newdream.net/issues/957 about that.

-- 
:(){ :|:&};:
