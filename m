From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Slow OSD detection
Date: Fri, 21 Nov 2014 15:07:47 -0600
Message-ID: <546FA9A3.8090908@redhat.com>
References: <CALgKBSmF=Au_CPNRBRwvMrDejs2=JuqO4zf-AzQfT04uyqnTtg@mail.gmail.com> <CA+4uBUbxsK-TwWvWjr_ynVOjsRic5YD+Qm2CbzwPxgyTWMs7kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:54935 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaKUVHs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Nov 2014 16:07:48 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so322132igi.0
        for <ceph-devel@vger.kernel.org>; Fri, 21 Nov 2014 13:07:48 -0800 (PST)
In-Reply-To: <CA+4uBUbxsK-TwWvWjr_ynVOjsRic5YD+Qm2CbzwPxgyTWMs7kg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com, Sreenath BH <bhsreenath@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It'd be nice if something like slow OSD detection could exist outside of 
calamari and itself by an event that we record in the logs and make 
available via the admin socket (so that calamari could pick it up). 
That way folks could get it into logstash and other system monitoring 
tools (say PCP/Nagios/etc).

Mark

On 11/21/2014 02:58 PM, Samuel Just wrote:
> It's still an open item.  #ceph-devel would be a good place to bounce
> ideas.  Through the admin_socket and perf_counter machinery, the osds
> already expose a bunch of information about queue length, latency,
> etc.  This might actually fit well in calamari, which already gathers
> a bunch of those stats.
> -Sam
>
> On Thu, Nov 20, 2014 at 9:00 PM, Sreenath BH <bhsreenath@gmail.com> wrote:
>> Hi All
>>
>> Slow OSD detection is mentioned as one of the projects ideas in
>> https://wiki.ceph.com/Development/Project_Ideas
>>
>> I am interested in implementing this. Is this still an open item?
>>
>> thanks,
>> Sreenath
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

