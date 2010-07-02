From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: PATCH: ceph.spec.in
Date: Fri, 02 Jul 2010 21:42:38 +0200
Message-ID: <4C2E412E.1010408@chaschperli.ch>
References: <i0k73i$g5f$2@dough.gmane.org> <Pine.LNX.4.64.1007020802470.17984@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:45076 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab0GBTmt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jul 2010 15:42:49 -0400
In-Reply-To: <Pine.LNX.4.64.1007020802470.17984@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

On 02.07.2010 17:04, Sage Weil wrote:
> Applied this, sans the unpackaged files part.. those are for debugging and
> testing, and don't need to be installed.  (That probably means 'make
> install' should ignore them...)

as long as they are installed with "make install" (at least with mock) 
the build of the packages fail with the message that there are 
unpackaged files and no rpm's are produced.


- Thomas
