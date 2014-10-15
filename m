From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: 10/14/2014 Weekly Ceph Performance Meeting
Date: Wed, 15 Oct 2014 08:26:20 -0500
Message-ID: <543E75FC.7010509@redhat.com>
References: <e1f8eda8-3711-4f50-8910-20a09daa472f@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:58557 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbaJON0S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Oct 2014 09:26:18 -0400
Received: by mail-ig0-f174.google.com with SMTP id a13so17330054igq.13
        for <ceph-devel@vger.kernel.org>; Wed, 15 Oct 2014 06:26:17 -0700 (PDT)
In-Reply-To: <e1f8eda8-3711-4f50-8910-20a09daa472f@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/15/2014 01:22 AM, Alexandre DERUMIER wrote:
> Hi,
>
> about performance, maybe could it be great to also include client side performance ?

Sure!  Please feel free to add this or other topics that are 
useful/interesting to the etherpad.  Please include your name though so 
we know who's brought it up.  Even if we don't get to everything it will 
provide useful topics for the subsequent weeks.

>
> Currently I see 2 performance problems with librbd:
>
> 1) The cpu usage is quite huge. (I'm cpu bound with 8cores CPU E5-2603 v2 @ 1.80GHz, with 40000iops 4k read using fio-rbd)

Interesting.  Have you taken a look with perf or other tools to see 
where time is being spent?

>
> 2) in qemu, it's impossible to reach more than around 7000iops with 1 disk. (maybe is it also related to cpu or threads number).
>     I have also try with the new qemu iothread/dataplane feature, but it doesn't help.

1 disk meaning 1 OSD, or 1 disk meaning 1 volume on a VM? If its 1 
volume, does adding another volume on the same VM help?  I'm not 
familiar with the new qemu options, so that would be good to discuss at 
the meeting too!

>
>
>
>
>

