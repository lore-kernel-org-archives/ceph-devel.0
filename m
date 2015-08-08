From: Sage Weil <sage@newdream.net>
Subject: Re: make check bot paused
Date: Sat, 8 Aug 2015 04:50:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508080449510.22099@cobra.newdream.net>
References: <55C55500.3000303@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50840 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbbHHLuN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Aug 2015 07:50:13 -0400
In-Reply-To: <55C55500.3000303@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, 8 Aug 2015, Loic Dachary wrote:
> Hi,
> 
> The make check bot is paused until the master branch passes make check 
> again.

Several fixes here that need review:

	https://github.com/ceph/ceph/pull/5515

sage
