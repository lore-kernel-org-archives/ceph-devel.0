From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: packaging init systems in a more autoools style way.
Date: Wed, 03 Jun 2015 15:36:04 -0600
Message-ID: <556F7344.4030003@redhat.com>
References: <556F1E19.6080704@suse.com> <alpine.DEB.2.00.1506030919460.9814@cobra.newdream.net> <556F6480.1090901@suse.com> <alpine.DEB.2.00.1506031344370.26591@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39441 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbbFCVgF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Jun 2015 17:36:05 -0400
In-Reply-To: <alpine.DEB.2.00.1506031344370.26591@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Owen Synge <osynge@suse.com>
Cc: ceph-devel@vger.kernel.org

On 06/03/2015 02:45 PM, Sage Weil wrote:
> Sounds good to me.  It could (should?) even error out if no init
system is
> specified?  Otherwise someone will likely be in for a surprise.

I was picturing that we'd just autodetect based on OS version (eg Ubuntu
15.04 should default to --with-init=systemd). It's one less thing to get
wrong during the build process.

What do you think?

- Ken
