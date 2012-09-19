From: Sage Weil <sage@inktank.com>
Subject: Re: Memory usage of ceph-mds
Date: Wed, 19 Sep 2012 13:48:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net>
References: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40904 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2ISUsO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 16:48:14 -0400
In-Reply-To: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 19 Sep 2012, Tren Blackburn wrote:
> Hey List;
> 
> I'm in the process of rsyncing in about 7TB of data to Ceph across
> approximately 58565475 files (okay, so I guess that's not so
> approximate). It's only managed to copy a small portion of this so far
> (about 35GB) and the server that currently is the mds master shows the
> ceph-mds process closing in on 2GB of RAM used. I'm getting a little
> nervous about this steep increase.
> 
> fern ceph # ps wwaux | grep ceph-mds
> root     29943  3.7  0.9 2473884 1915468 ?     Ssl  08:42  11:22
> /usr/bin/ceph-mds -i 1 --pid-file /var/run/ceph/mds.1.pid -c
> /etc/ceph/ceph.conf
> 
> Thank in advance!

That's not necessarily a problem.  The mds memory usage is controlled via 
the 'mds cache size' knob which defaults to 100,000.  You might try 
halving that and restarting the MDS.

sage

> 
> t.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
