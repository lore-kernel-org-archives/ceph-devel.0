From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 07:17:12 -0500
Message-ID: <4FC60FC8.207@inktank.com>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:51220 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab2E3MRS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 08:17:18 -0400
Received: by gglu4 with SMTP id u4so3374915ggl.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 05:17:18 -0700 (PDT)
In-Reply-To: <4FC5FEC1.90103@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Stefan Majer <stefan.majer@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/30/2012 06:04 AM, Stefan Priebe - Profihost AG wrote:
> Am 30.05.2012 09:19, schrieb Stefan Majer:
>> Hi,
>>
>> ok, so your replication level is 2 and you have 2*1GB/sec right ?
> Generally yes - but for this new test it was just 1*1GB/s (see below).
>
>> do you have a iostat -x 3 output and or a dstat from all effected
>> machines during your rados bench runs as well ?
> As the output looks exactly the same on all OSDs here is it from ONE osd:
>
> Kernel 3.4:
> http://pastebin.com/raw.php?i=sV9vKsWy
>
> Kernel 3.0:
> http://pastebin.com/raw.php?i=eafjpPpK
>
> Stefan

Would you mind installing blktrace and running "blktrace -o test-3.4 -d 
/dev/sdb" on the OSD node during a short (say 60s) test on 3.4?

If you could archive/send me the results, that might help us get an idea 
of what is actually getting sent out to the disk.  Your data disk 
throughput on 3.0 looks pretty close to what I normally get (including 
on 3.4).  I'm guessing the issue you are seeing on 3.4 is probably not 
the seek problem I mentioned earlier (unless something is causing so 
many seeks that it more or less paralyzes the disk).

Mark
