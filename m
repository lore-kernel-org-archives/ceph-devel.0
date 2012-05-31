From: Sage Weil <sage@inktank.com>
Subject: Re: differents ip/network link for osd replication and client->osd
 ?
Date: Thu, 31 May 2012 09:27:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205310926130.28422@cobra.newdream.net>
References: <e816b4c6-b8fe-4050-b72d-32d69e75e686@mailpro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33205 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab2EaQ1o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:27:44 -0400
In-Reply-To: <e816b4c6-b8fe-4050-b72d-32d69e75e686@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 31 May 2012, Alexandre DERUMIER wrote:
> Hi,
> Is it possible to use differents ip / network link for 
> 
> - replication between osd
> - network between client and osd 
> 
> ?
> 
> I would like to use differents swichs/network card for osd replication.

Yep:

[osd]
	public network = 1.2.3.4/24
	cluster network = 192.168.0.0/16

will make ceph-osd choose IPs in those subnets.  You can also specify 
'public addr' or 'cluster addr' to a specific IP, although that's more 
tedious to configure.

sage
