From: Sage Weil <sage@inktank.com>
Subject: Re: Heavy speed difference between rbd and custom pool
Date: Tue, 19 Jun 2012 09:27:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206190926170.21853@cobra.newdream.net>
References: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro> <4FE01CE7.8000204@profihost.ag>
 <4FE0782A.1060104@inktank.com> <4FE07B2A.7080209@profihost.ag>
 <Pine.LNX.4.64.1206190840550.21853@cobra.newdream.net>
 <418AE5C4-0677-423A-8635-BFCB837B0ADF@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57998 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab2FSQ2C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 12:28:02 -0400
In-Reply-To: <418AE5C4-0677-423A-8635-BFCB837B0ADF@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 19 Jun 2012, Stefan Priebe wrote:
> Am 19.06.2012 um 17:42 schrieb Sage Weil <sage@inktank.com>:
> >> 
> >> But this number 2176 of PGs were set while doing mkcephfs - how is it
> >> calculated?
> > 
> >    num_pgs = num_osds << osd_pg_bits
> > 
> > which is configurable via --osd-pg-bits N or ceph.conf (at mkcephfs time).  
> > The default is 6.
>
> What happens if I add more osds later?

Currently, nothing.  The existing PGs are spread out among a larger number 
of OSDs.  This is partly why the default shoots a bit high.

One of the upcoming items on the todo list is to finish PG 
splitting/merging, which will allow a pool to be resharded into more or 
less PGs so that the data distribution can be adjusted as the cluster 
grows or shrinks.

sage
