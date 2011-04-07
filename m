From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-client-standalone.git
Date: Thu, 7 Apr 2011 15:11:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104071510220.18507@cobra.newdream.net>
References: <1302164488.1922.11.camel@cephhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51812 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024Ab1DGWIS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 18:08:18 -0400
In-Reply-To: <1302164488.1922.11.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Wu <cpwu@tnsoft.com.cn>
Cc: ceph-devel@vger.kernel.org

Hi Jeff,

On Thu, 7 Apr 2011, Jeff Wu wrote:
> Hi ,
> we are using ceph-client-standalone.git,
> i have seen that some bugs had been fixed at ceph-client.git ,
> then, could you update these patchs to ceph-client-standalone.git ? 

I've updated the tree to the latest ceph-client.git.  I haven't backported 
the recent changes to old kernels, though.. that's a much more painful 
process I don't have time for at the moment.  (Patches for that would be 
welcome, of course!)

Thanks!
sage

