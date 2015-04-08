From: Sage Weil <sage@newdream.net>
Subject: Re: ms_crc_data false
Date: Wed, 8 Apr 2015 15:40:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504081539090.4469@cobra.newdream.net>
References: <BC97738F8E7C8742BABED7F06FB9DF9166416855@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41541 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbbDHWkM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 18:40:12 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166416855@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 8 Apr 2015, Deneau, Tom wrote:
> With 0.93, I tried 
>     ceph tell 'osd.*' injectargs '--ms_crc_data=false' '--ms_crc_header=false'
> 
> and saw the changes reflected in ceph admin-daemon
> 
> But having done that, perf top still shows time being spent in crc32 routines.
> Is there some other parameter that needs changing?

The osd still does a CRC for the purposes of write journaling.  This can't 
be disabled currently.  You shouldn't see this come up on reads...

sage
