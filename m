From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Thu, 24 May 2012 13:53:01 -0500
Message-ID: <4FBE838D.4000303@inktank.com>
References: <4FBE415E.8030702@profihost.ag> <CAJCPpW+SKnnVUaDEAsCkKyZwMVrHCRJF2C8zqB4eORgwW5p=1Q@mail.gmail.com> <4FBE7ABC.5020502@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46940 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab2EXSxE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 14:53:04 -0400
Received: by yhmm54 with SMTP id m54so122499yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 11:53:03 -0700 (PDT)
In-Reply-To: <4FBE7ABC.5020502@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stefan,

Thanks for the info!  I've been testing on 3.4 for the last couple of 
days but haven't run into that problem here.  It looks like your journal 
has writes going to it quickly and then things stall as it tries to 
write out to your data disk.  I wonder if any of the data actually makes 
it to the disk...  Can you run iostat or collectl or something and see 
what kind of write throughput you get to the OSD data disks?

Thanks,
Mark

On 05/24/2012 01:15 PM, Stefan Priebe wrote:
>
> Am 24.05.2012 16:55, schrieb Mark Nelson:
>> Hi Stefan,
>>
>> Were these both tested on fresh filesystems?  If you still have any
>> 3.0.30 available, could you try a couple of longer running tests (say 5
>> minutes) and see how they compare?
>
> Yes with 3.4 it totally stalls. Tested with XFS and btrfs. Client 
> always had the same Kernel. So i just changed the kernel on osd side.
>
> Kernel 3.4
> http://pastebin.com/raw.php?i=CApKbSNj
>
> Kernel 3.0.30
> http://pastebin.com/raw.php?i=kZ7rnwcM
>
> Stefan

