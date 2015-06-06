From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: packaging init systems in a more autoools style way.
Date: Sat, 06 Jun 2015 03:37:54 -0700
Message-ID: <mkuii5$o9s$1@ger.gmane.org>
References: <556F1E19.6080704@suse.com> <alpine.DEB.2.00.1506030919460.9814@cobra.newdream.net> <556F6480.1090901@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50878 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbbFFKiM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 6 Jun 2015 06:38:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Z1BUP-0005Tb-G1
	for ceph-devel@vger.kernel.org; Sat, 06 Jun 2015 12:38:09 +0200
Received: from 66.87.139.119 ([66.87.139.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2015 12:38:09 +0200
Received: from eternaleye by 66.87.139.119 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2015 12:38:09 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Owen Synge wrote:

<snip>

> If I underwstand right you favor the user interface as:
> 
> --with-init=systemd
> --with-init=sysv
> --with-init=upstart
> --with-init=bsd

Please do be sure to make --with-init=systemd respect the
--with-systemdsystemunitdir=PATH option, as some distros rely on that to 
properly place the unit files. (It's a near-universal feature in autoconf-
based packages that use systemd; rsyslog and dbus are examples)


