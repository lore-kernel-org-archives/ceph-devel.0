From: Sage Weil <sage@newdream.net>
Subject: Re: Client debugging  and rados_conf_set()
Date: Tue, 24 Feb 2015 21:36:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502242133330.25838@cobra.newdream.net>
References: <20150224194501.38982e51@guren.zaitcev.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36900 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbbBYFgH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 00:36:07 -0500
In-Reply-To: <20150224194501.38982e51@guren.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@kotori.zaitcev.us>
Cc: ceph-devel@vger.kernel.org

On Tue, 24 Feb 2015, Pete Zaitcev wrote:
> Hello:
> 
> I noticed that RadosClient.cc is full of interesting printouts, like so:
> 
>   ldout(cct, 1) << "setting wanted keys" << dendl;
> 
> So, I tried to enable them by doing this:
> 
> 	rc = rados_conf_set(rados, "debug_rados", "20/20");
> 
> However, the above produces no output. What am I missing? How are these
> printouts made visible conventionally?

Ha!  I saw that on twitter but couldn't tell what you were trying to do.

 log_to_stderr = true

in ceph.conf or

  rados_conf_set(rados, "log_to_stderr", "true");

or

  --log-to-stderr

on the command line.  You may also be able to do

  CEPH_ARGS="--log-to-stderr"

(although it depends on whether the binary is calling env_to_args()).

sage
