From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Object Write Latency
Date: Mon, 23 Sep 2013 11:03:58 -0500
Message-ID: <5240666E.7010009@inktank.com>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch> <alpine.DEB.2.00.1309200830040.25752@cobra.newdream.net>,<CABZ+qqnXbycX4C_brF4eiRVb0PeA4SKf2kW_d3g8RYxwD6xFDg@mail.gmail.com> <3472A07E6605974CBC9BC573F1BC02E4A52736BE@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:35754 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab3IWQD7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 12:03:59 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so2247781vbg.39
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 09:03:58 -0700 (PDT)
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A52736BE@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Dan van der Ster <dan@vanderster.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/23/2013 10:38 AM, Andreas Joachim Peters wrote:
> We deployed 3 OSDs with an EXT4 using RapidDisk in-memory.
>
> The FS does 140k/s append+sync and the latency is now:
>
> ~1 ms for few byte objects with single replica
> ~2 ms for few byte objects three replica  (instead of 65-80ms)

Interesting!  If you look at the slowest operations in the ceph admin 
socket now with dump_historic_ops, where are those operations spending 
their time?

>
> This gives probably the base-line of the best you can do with the current implementation.
>
> ==> the 80ms are probably just a 'feature' of the hardware (JBOD disks/controller) and we might try to find some tuning parameters to improve the latency slightly.

Hardware definitely plays a huge part in terms of Ceph performance.  You 
can run Ceph on just about anything, but it's surprising how different 
two roughly similar systems can perform.

>
> Could you just explain how the async api functions (is_complete, is_safe) map to the three states
>
> 1) object is transferred from client to all OSDs and is present in memory there
> 2) object is written to the OSD journal
> 3) object is committed from OSD journal to the OSD filesystem
>
> Is it correct that the object is visible by clients only when 3) has happened?

Yes, afaik.

>
> Thanks for your help,
> Andreas.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

