From: Gregory Farnum <greg@inktank.com>
Subject: Re: Removed directory is back in the Ceph FS
Date: Tue, 4 Dec 2012 13:40:32 -0800
Message-ID: <CAPYLRzgRegP3Bxb1a7BVm-amYuEpSTfp7WkG6yC_4UrAdS6Pig@mail.gmail.com>
References: <CAOGW2pyKcL=vs7p2i3yDNCC1Vxoh6cx053vECVCm=Twt7H4M5A@mail.gmail.com>
	<CAOGW2pzG466Q3p-EXwx6_jxOjazPa3yxO8H6UtDDaLxVgu7rbg@mail.gmail.com>
	<CAPYLRzgi4uQHYX9W4o+_EQvrw4KyU57Siq2XtU+GgNRAFLgPRw@mail.gmail.com>
	<CAOGW2pzvo4Vm3twRHgbBzs_-RKtJ5s6g7n9_pUXzDUjJn2MaWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:37535 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab2LDVkd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 16:40:33 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3449285iay.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 13:40:32 -0800 (PST)
In-Reply-To: <CAOGW2pzvo4Vm3twRHgbBzs_-RKtJ5s6g7n9_pUXzDUjJn2MaWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Franck Marchand <fmarchand@agaetis.fr>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Can you try and reproduce this again using v0.55? There are a number
of (community!) patches in there that could have fixed this issue.
-Greg

On Tue, Nov 20, 2012 at 2:14 AM, Franck Marchand <fmarchand@agaetis.fr> wrote:
> Hi Gregory !
>
> Thx to have a look on this.
>
> I mounted the ceph fs from multiple clients. I did a rm -rf myfolder
> from a client.
> I use the ceph-fs-common (0.48-2argonaut) to mount my ceph fs.
>
> Franck
>
> 2012/11/20 Gregory Farnum <greg@inktank.com>:
>> On Tue, Nov 13, 2012 at 3:23 AM, Franck Marchand <fmarchand@agaetis.fr> wrote:
>>> Hi,
>>>
>>> I have a weird pb. I remove a folder using a mounted fs partition. I
>>> did it and it worked well.
>>
>> What client are you using? How did you delete it? (rm -rf, etc?) Are
>> you using multiple clients or one, and did you check it on a different
>> client?
>>
>>> I checked later to see if I had all my folders in ceph fs ... : the
>>> folder I removed was back and I can't remove it ! Here is the error
>>> message I got :
>>>
>>> rm -rf 2012-11-10/
>>> rm cannot remove `2012-11-10': Directory not empty
>>>
>>> This folder is empty ...
>>> So anybody had the same pb ? Am I doing something wrong ?
>>
>> This sounds like a known but undiagnosed problem with the MDS
>> "rstats". The part where your client reported success is a new
>> wrinkle, though.
>> -Greg
>>
>>
>>>
>>> Thx
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
