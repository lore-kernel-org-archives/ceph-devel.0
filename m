From: Tim O'Donovan <tim@icukhosting.co.uk>
Subject: Re: is rados block cluster production ready ?
Date: Mon, 21 May 2012 09:18:02 +0100
Message-ID: <4FB9FA3A.3000705@icukhosting.co.uk>
References: <531ff5f3-11d5-488e-adfb-68000f3c36c0@mailpro> <c1099add-5872-4b8b-9250-9dd33791a776@mailpro> <CADvuQREa3PXCG4Udvuy45wHUKBAruc40md_cOrssXYTN+8-JJw@mail.gmail.com> <4FB9F82F.9050208@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.interdns.co.uk ([83.170.124.66]:57349 "HELO
	smtp2.interdns.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751455Ab2EUISF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 04:18:05 -0400
In-Reply-To: <4FB9F82F.9050208@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> That's great but if you go the way of having for example 8x OSDs per
> server with 8 single Disks - how can i archieve that ceph is splitting
> my files to the correct servers for redundancy?

I believe this is handled by CRUSH:

http://ceph.com/wiki/Custom_data_placement_with_CRUSH


Regards,
Tim O'Donovan
