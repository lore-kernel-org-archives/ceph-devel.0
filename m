From: Sage Weil <sage@newdream.net>
Subject: Re: failed to open http://apt-mirror.front.sepia.ceph.com
Date: Wed, 23 Sep 2015 06:11:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509230611360.11876@cobra.newdream.net>
References: <56027EE3.5080909@gmail.com> <56027F1D.90508@gmail.com> <56028812.1050207@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41409 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015AbbIWNLx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 09:11:53 -0400
In-Reply-To: <56028812.1050207@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: wangsongbo <songbo1227@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 23 Sep 2015, Loic Dachary wrote:
> Hi,
> 
> On 23/09/2015 12:29, wangsongbo wrote:
> > 64.90.32.37 apt-mirror.front.sepia.ceph.com
> 
> It works for me. Could you send a traceroute 
> apt-mirror.front.sepia.ceph.com ?

This is a private IP internal to the sepia lab.  Anythign outside the lab 
shouldn't be using it...

sage
