From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Heavy speed difference between rbd and custom pool
Date: Tue, 19 Jun 2012 08:01:30 -0500
Message-ID: <4FE0782A.1060104@inktank.com>
References: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro> <4FE01CE7.8000204@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:48413 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab2FSNBi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 09:01:38 -0400
Received: by ghrr11 with SMTP id r11so4556665ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 06:01:38 -0700 (PDT)
In-Reply-To: <4FE01CE7.8000204@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

On 06/19/2012 01:32 AM, Stefan Priebe - Profihost AG wrote:
> Am 19.06.2012 06:41, schrieb Alexandre DERUMIER:
>> Hi Stephann
>> recommandations are 30-50 PGS by osd if I remember.
>>
> rbd, data and metadata have 2176 PGs with 12 OSD. This is 181,333333333
> per OSD?!
>
> Stefan

That's probably fine, it just means that you will have a better 
pseudo-random distribution of OSD combinations (It does have higher 
cpu/memory overhead though).  Figuring out how many PGs you should have 
per OSD depends on a lot of factors including how many OSDs you have, 
how many nodes, CPU, memory, etc.  I'm guessing ~180 per OSD won't cause 
problems.  On the other hand, with low OSD counts you could probably 
have fewer and be fine too.

Mark
