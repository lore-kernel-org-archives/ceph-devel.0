From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Heavy speed difference between rbd and custom pool
Date: Tue, 19 Jun 2012 18:24:12 +0200
Message-ID: <418AE5C4-0677-423A-8635-BFCB837B0ADF@profihost.ag>
References: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro> <4FE01CE7.8000204@profihost.ag> <4FE0782A.1060104@inktank.com> <4FE07B2A.7080209@profihost.ag> <Pine.LNX.4.64.1206190840550.21853@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:57350 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab2FSQYV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 12:24:21 -0400
In-Reply-To: <Pine.LNX.4.64.1206190840550.21853@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 19.06.2012 um 17:42 schrieb Sage Weil <sage@inktank.com>:
>> 
>> But this number 2176 of PGs were set while doing mkcephfs - how is it
>> calculated?
> 
>    num_pgs = num_osds << osd_pg_bits
> 
> which is configurable via --osd-pg-bits N or ceph.conf (at mkcephfs time).  
> The default is 6.
What happens if I add more osds later?