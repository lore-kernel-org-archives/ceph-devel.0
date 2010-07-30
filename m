From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: [PATCH] debian: create standalone client-tools package for
 mount.ceph
Date: Fri, 30 Jul 2010 08:13:35 +0000 (UTC)
Message-ID: <i2u1jf$hnt$1@dough.gmane.org>
References: <1280476219-16538-1-git-send-email-thomas@chaschperli.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36894 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab0G3INs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Jul 2010 04:13:48 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Oekiw-0006MU-Ew
	for ceph-devel@vger.kernel.org; Fri, 30 Jul 2010 10:13:46 +0200
Received: from zux221-125-110.adsl.green.ch ([81.221.125.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 10:13:46 +0200
Received: from thomas by zux221-125-110.adsl.green.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 10:13:46 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Fri, 30 Jul 2010 09:50:19 +0200 schrieb Thomas Mueller:

> on a client the server-side is IMHO not needed. Move the mount util to a
> dedicated package.

... and maybe move the rbd util also to client-tools?

- Thomas

