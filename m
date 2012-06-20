From: Sage Weil <sage@inktank.com>
Subject: Re: filestore btrfs trans
Date: Wed, 20 Jun 2012 09:09:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206200907420.14284@cobra.newdream.net>
References: <4FE19B56.6010808@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40265 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756999Ab2FTQJA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 12:09:00 -0400
In-Reply-To: <4FE19B56.6010808@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 20 Jun 2012, Stefan Priebe - Profihost AG wrote:
> Hello list,
> 
> i've looked at the wiki (http://ceph.com/wiki/Ceph.conf) but there is no exact
> desciption what filestore btrfs trans does. It seems it is false by default.
> 
> Should it be enabled when using btrfs?

Nope.  This is the obsolete trans start/end ioctls that we don't use.  We 
should remove this code.

sage
