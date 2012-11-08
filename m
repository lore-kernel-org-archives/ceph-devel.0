From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: problems creating new ceph cluster when using journal on block
 device
Date: Thu, 08 Nov 2012 11:41:02 -0600
Message-ID: <509BEEAE.3000805@inktank.com>
References: <CACkq2mozdJackj__AB_ZJnN5KR9mdqN_LRG8RPu0hN1qh_8e_g@mail.gmail.com> <509B6883.4010406@widodh.nl> <509B6C2E.2050708@catalyst.net.nz> <CACkq2mr=dmHX+Z6fTMUvct78pa9RWeGid5vHK1vNw1_S-NWgDw@mail.gmail.com> <CACkq2mqtRq_s6=UxrF1ADaFuf2tETDB2GSdXCPdi4mG7Ei9wow@mail.gmail.com> <CACkq2mqkFEeivwRnrKURkfTiMFjq0jqN8ED8A+BxdJoQaBG1DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61085 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab2KHRk6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 12:40:58 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so4577021iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 09:40:57 -0800 (PST)
In-Reply-To: <CACkq2mqkFEeivwRnrKURkfTiMFjq0jqN8ED8A+BxdJoQaBG1DQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/08/2012 11:36 AM, Travis Rhoden wrote:
> Solved!
>
> I stumbled into the solution while switching from block device to a
> file.  I was being bit by running mkcephfs multiple times -- it wasn't
> really failing on the journal, it was failing because the OSD data
> disk had been initialized before.  I couldn't see that until I used a
> file for the journal and then I see log output like:

Yeah, that was a change that landed a couple of months ago.  It's really 
important now to blow away the old data (I just reformat) if you want a 
totally clean ceph deployment rather than just running mkcephfs.

>
> === osd.0 ===
> 2012-11-08 16:41:37.677620 7ffc3cfcd780 -1 provided osd id 0 != superblock's -1
> 2012-11-08 16:41:37.678726 7ffc3cfcd780 -1  ** ERROR: error creating
> empty object store in /var/lib/ceph/osd/ceph-0: (22) Invalid argument
>
> I unmounted the OSD's that had been touched before, reformatted them,
> and then remounted.  I setup ceph.conf to use block devices for the
> journals, and then everything proceeded normally.
>
> So the final relevant bits from my ceph.conf file look like:
>
> [osd]
>          osd journal size = 0
>          journal dio = true
>          journal aio = true
>
> [osd.0]
>          host = ceph1
>          osd journal = /dev/sda5
>
> [osd.1]
>          host = ceph1
>          osd journal = /dev/sda6
> ...
>
> Thanks,
>
>   - Travis
>
> On Thu, Nov 8, 2012 at 10:08 AM, Travis Rhoden <trhoden@gmail.com> wrote:
>> One more thing -- Google search says this is harmless -- I see quite a
>> few of these in syslog:
>>
>> hdparm: sending ioctl 2285 to a partition!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

