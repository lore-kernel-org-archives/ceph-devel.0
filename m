From: Sage Weil <sage@newdream.net>
Subject: Re: Read speed. again.
Date: Sat, 2 Jul 2011 13:45:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107021345060.15043@cobra.newdream.net>
References: <4E0F5D8F.6050000@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41202 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab1GBUmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Jul 2011 16:42:40 -0400
In-Reply-To: <4E0F5D8F.6050000@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Sat, 2 Jul 2011, Fyodor Ustinov wrote:
> Hi!
> 
> ceph 0.30
> 
> the rate of re-reading the file 10G. 13 OSD servers (ie the file is already in
> the cache in OSD servers).
> 
> cfuse: 118 MB/s
> 
> kenel (3.0.0-rc3): 84.0 MB/s
> 
> :(

Yeah, this is still on the list.  We can include it in the next sprint 
(starting next week).

sage

