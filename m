From: Pete Zaitcev <zaitcev@kotori.zaitcev.us>
Subject: Re: Client debugging  and rados_conf_set()
Date: Wed, 25 Feb 2015 19:51:36 -0700
Message-ID: <20150225195136.16991296@guren.zaitcev.lan>
References: <20150224194501.38982e51@guren.zaitcev.lan>
	<alpine.DEB.2.00.1502242133330.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from takane.zaitcev.us ([96.126.117.152]:41048 "EHLO
	takane.zaitcev.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbbBZCvk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 21:51:40 -0500
In-Reply-To: <alpine.DEB.2.00.1502242133330.25838@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Tue, 24 Feb 2015 21:36:07 -0800 (PST)
Sage Weil <sage@newdream.net> wrote:

> >   ldout(cct, 1) << "setting wanted keys" << dendl;
> > 	rc = rados_conf_set(rados, "debug_rados", "20/20");

>   rados_conf_set(rados, "log_to_stderr", "true");

Thanks a lot, that worked!

-- Pete
