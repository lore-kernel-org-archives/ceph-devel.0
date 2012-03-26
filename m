From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: rados df does not report reads (rd and rd KB stays
 constant)
Date: Mon, 26 Mar 2012 10:09:45 -0700
Message-ID: <76ED0140BDEE4D7B8DA439D73D9BD6CA@dreamhost.com>
References: <CADdPHGs-e-MwD6Cr5L9W_JgH0UmZSTJhN2NBuPtpOUBiih9GDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60076 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932667Ab2CZRJw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Mar 2012 13:09:52 -0400
Received: by mail-ob0-f174.google.com with SMTP id eh20so5376725obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Mar 2012 10:09:51 -0700 (PDT)
In-Reply-To: <CADdPHGs-e-MwD6Cr5L9W_JgH0UmZSTJhN2NBuPtpOUBiih9GDQ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Majer <stefan.majer@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Friday, March 23, 2012 at 7:07 AM, Stefan Majer wrote:
> Hi,
> 
> i use rados df to collect several statistics of our ceph cluster for
> monitoring purpose. But the reporting of rd and rd KB is broken,
> because it does not change over time.
> wr and wr KB reflect really well our storage usage.
> 
> So this seems to be broken. We have ceph-0.4.2 installed.
> 
> here are two outputs of rados df with 2 seconds inbetween.
> [root@sc00 ~]# rados df
> pool name category KB objects clones
> degraded unfound rd rd KB wr
> wr KB
> data - 499713 123
> 0 0 0 0 0
> 123 499713
> metadata - 0 0
> 0 0 0 0 0
> 0 0
> rbd - 3229400110 798827
> 0 0 0 7429 24682
> 371028901 17579250219
> total used 6474458716 798950
> total avail 56006434852
> total space 62480893568
> 
> [root@sc00 ~]# rados df
> pool name category KB objects clones
> degraded unfound rd rd KB wr
> wr KB
> data - 499713 123
> 0 0 0 0
> 0 123 499713
> metadata - 0 0
> 0 0 0 0
> 0 0 0
> rbd - 3229400110 798827
> 0 0 0 7429 24682
> 371028936 17579250619
> total used 6474458716 798950
> total avail 56006434852
> total space 62480893568


Sage made a bug for this:
http://tracker.newdream.net/issues/2209

Thanks for the report!
