From: Sage Weil <sage@newdream.net>
Subject: Re: ceph pg query - num_objects_missing_on_primary
Date: Wed, 23 Sep 2015 14:40:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509231439430.11876@cobra.newdream.net>
References: <BLU175-W24FED0B3FA4DF17C772645DF440@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44306 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839AbbIWVkm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 17:40:42 -0400
In-Reply-To: <BLU175-W24FED0B3FA4DF17C772645DF440@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 23 Sep 2015, GuangYang wrote:
> Hello,
> While doing a 'ceph pg {id} query', it dumps the info from all peers, however, for all peers, it only shows 'num_objects_missing_on_primary', which is the same across all peers.
> 
> Isn't it better to show the 'num_objecgts_missing' for the peer rather than primary?

Probably, yeah.  I think this is just an artifact of being lazy when 
implementing query... we dumped whatever was convenient without 
considering it too carefully.  Adding a section for missing would 
definitely be useful.

sage
