From: Sage Weil <sage@newdream.net>
Subject: Re: when create a new pool, Does straw2 applies in crushmap by
 default?
Date: Wed, 19 Aug 2015 03:37:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508190336560.13116@cobra.newdream.net>
References: <CAA-rZjb703OESbaZW=8z_D2h3ePb-hFo3LYQrX_7CsDLpi6USQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37962 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbbHSKhY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 06:37:24 -0400
In-Reply-To: <CAA-rZjb703OESbaZW=8z_D2h3ePb-hFo3LYQrX_7CsDLpi6USQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chen kael <chenji.bupt@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 19 Aug 2015, chen kael wrote:
> Hi,
> 
> When setting up a new enviroment, How can I  make all pools created
> use straw2 other than straw by default?
> Such as ./vstart.sh -l -n -x ,I hope all pools use straw2 ,no need
> change bucket type by myself

 ceph osd crush tunables hammer

will do it, but remember that all clients will need to be hammer or 
later to talk to the cluster.

sage
