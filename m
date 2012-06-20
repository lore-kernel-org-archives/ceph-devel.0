From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Heavy speed difference between rbd and custom pool
Date: Wed, 20 Jun 2012 16:21:42 -0700
Message-ID: <4FE25B06.5080207@inktank.com>
References: <bfd5bdd7-1959-445f-8016-7b98ae5eb6e9@mailpro> <4FE01CE7.8000204@profihost.ag> <4FE0782A.1060104@inktank.com> <4FE07B2A.7080209@profihost.ag> <Pine.LNX.4.64.1206190840550.21853@cobra.newdream.net> <418AE5C4-0677-423A-8635-BFCB837B0ADF@profihost.ag> <D7C8B960-F7C7-4AEC-8321-982E8908E7CA@inktank.com> <4FE171D1.2040807@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40171 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758530Ab2FTXVp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 19:21:45 -0400
Received: by pbbrp8 with SMTP id rp8so1242915pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 16:21:45 -0700 (PDT)
In-Reply-To: <4FE171D1.2040807@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 06/19/2012 11:46 PM, Stefan Priebe - Profihost AG wrote:
> Am 19.06.2012 18:29, schrieb Dan Mick:
>> The number doesn't change currently (and can't currently be set
>> manually).
>
> OK thanks, so for extending the storage this will be pretty important.
> Do you have any plans for which version this feature will be complete?
>
> Stefan

It is one of the next things on our list, and depends on the fixup of 
'pg splitting' (which once worked, but other features have made it
impractical without rework).  Until then we have tracker issues about 
the subject:

http://tracker.newdream.net/issues/1515
osd: pg split

http://tracker.newdream.net/issues/84
mon: auto adjust pg_num as pool grows

http://tracker.newdream.net/issues/85
osd: pg_num shrink
