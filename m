From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: is rados block cluster production ready ?
Date: Mon, 21 May 2012 10:25:25 +0200
Message-ID: <4FB9FBF5.5050908@profihost.ag>
References: <531ff5f3-11d5-488e-adfb-68000f3c36c0@mailpro> <c1099add-5872-4b8b-9250-9dd33791a776@mailpro> <CADvuQREa3PXCG4Udvuy45wHUKBAruc40md_cOrssXYTN+8-JJw@mail.gmail.com> <4FB9F82F.9050208@profihost.ag> <4FB9FA3A.3000705@icukhosting.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55397 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab2EUIZ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 04:25:26 -0400
In-Reply-To: <4FB9FA3A.3000705@icukhosting.co.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim O'Donovan <tim@icukhosting.co.uk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 21.05.2012 10:18, schrieb Tim O'Donovan:
>> That's great but if you go the way of having for example 8x OSDs per
>> server with 8 single Disks - how can i archieve that ceph is splitting
>> my files to the correct servers for redundancy?
> 
> I believe this is handled by CRUSH:
> 
> http://ceph.com/wiki/Custom_data_placement_with_CRUSH
Thanks!

Stefan
