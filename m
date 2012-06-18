From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: OSD crash
Date: Mon, 18 Jun 2012 08:41:28 +0200
Message-ID: <4FDECD98.8010101@profihost.ag>
References: <4FDC82BA.5030102@profihost.ag> <4FDC8B56.7080507@profihost.ag> <Pine.LNX.4.64.1206171416150.20239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59069 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab2FRGl3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 02:41:29 -0400
In-Reply-To: <Pine.LNX.4.64.1206171416150.20239@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 17.06.2012 23:16, schrieb Sage Weil:
> Hi Stefan,
>
> I opened http://tracker.newdream.net/issues/2599 to track this, but the
> dump strangely does not include the ceph version or commit sha1.  What
> version were you running?
Sorry that was my build system it accidently removed the .git dir while 
builing so the version string couldn't be compiled in.

It was 5efaa8d7799347dfae38333b1fd6e1a87dc76b28

Stefan
