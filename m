From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Heavy speed difference between rbd and custom pool
Date: Tue, 19 Jun 2012 09:29:45 -0700
Message-ID: <D7C8B960-F7C7-4AEC-8321-982E8908E7CA@inktank.com>
References: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro> <4FE01CE7.8000204@profihost.ag> <4FE0782A.1060104@inktank.com> <4FE07B2A.7080209@profihost.ag> <Pine.LNX.4.64.1206190840550.21853@cobra.newdream.net> <418AE5C4-0677-423A-8635-BFCB837B0ADF@profihost.ag>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40803 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2FSQ3z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 12:29:55 -0400
Received: by pbbrp8 with SMTP id rp8so9867233pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 09:29:55 -0700 (PDT)
In-Reply-To: <418AE5C4-0677-423A-8635-BFCB837B0ADF@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The number doesn't change currently (and can't currently be set manually). 

On Jun 19, 2012, at 9:24 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:

> Am 19.06.2012 um 17:42 schrieb Sage Weil <sage@inktank.com>:
>>> 
>>> But this number 2176 of PGs were set while doing mkcephfs - how is it
>>> calculated?
>> 
>>   num_pgs = num_osds << osd_pg_bits
>> 
>> which is configurable via --osd-pg-bits N or ceph.conf (at mkcephfs time).  
>> The default is 6.
> What happens if I add more osds later?--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
