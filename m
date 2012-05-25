From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Thu, 24 May 2012 20:53:03 -0500
Message-ID: <4FBEE5FF.7080907@inktank.com>
References: <4FBE415E.8030702@profihost.ag> <CAJCPpW+SKnnVUaDEAsCkKyZwMVrHCRJF2C8zqB4eORgwW5p=1Q@mail.gmail.com> <4FBE7ABC.5020502@profihost.ag> <4FBE838D.4000303@inktank.com> <4FBE8662.1070801@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53006 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab2EYBxH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 21:53:07 -0400
Received: by ghrr11 with SMTP id r11so291456ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 18:53:06 -0700 (PDT)
In-Reply-To: <4FBE8662.1070801@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/24/2012 02:05 PM, Stefan Priebe wrote:
> Am 24.05.2012 20:53, schrieb Mark Nelson:
>> Hi Stefan,
>>
>> Thanks for the info! I've been testing on 3.4 for the last couple of
>> days but haven't run into that problem here. It looks like your journal
>> has writes going to it quickly and then things stall as it tries to
>> write out to your data disk.
> That's a good point. Right now while testing i'm using a tmpfs ramdisk 
> for the journal and have set journal dio = false in ceph.conf? Might 
> this be the difference / problem?
>
> 3.2.18 works fine too.

Honestly I don't know if tmpfs journal with dio = false would lead to 
that kind of behavior.  Anything interesting in the logs if you turn 
debugging up?

>
> > I wonder if any of the data actually makes
>> it to the disk... Can you run iostat or collectl or something and see
>> what kind of write throughput you get to the OSD data disks?
> none... so it seems get's never transferred from journal to disk.

This might be a stupid question, but writes to those partitions work 
outside of Ceph with the new kernel right?

>
> Stefan

Thanks,
Mark
