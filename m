From: Sage Weil <sage@inktank.com>
Subject: Re: ceph admin command: debuggging
Date: Thu, 8 Aug 2013 15:09:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308081508360.986@cobra.newdream.net>
References: <20130808160417.3589315c@doppio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57412 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966758Ab3HHWJ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 18:09:27 -0400
In-Reply-To: <20130808160417.3589315c@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 8 Aug 2013, Andreas Bluemle wrote:
> Hi,
> 
> maybe this is the wrong list - but I am looking for
> logging support for the /usr/bin/ceph adminstration
> comamand.
> 
> This is build from the same source as the ceph daemons are.
> 
> For the daemons, logging is controlled for the different
> comoponents of a daemon on behalf of configuration file
> directives (e.g. "debug ms" for the message I/O).
> 
> Can this be applied to the /usr/bin/ceph command, too?
> And where would the log file go?

You are probably looking for:

 --log-to-stderr     (make log output go to stderr)
 --log-file <filename>

and you can make some noise with

 --debug-ms 1
 --debug-monc 10

(for example)

sage
