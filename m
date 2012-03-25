From: ruslan usifov <ruslan.usifov@gmail.com>
Subject: Re: periodically delays when one of mons dies
Date: Sun, 25 Mar 2012 12:17:54 +0400
Message-ID: <CAHULbCm=LrjVwQtRJ4CzgdJbt93Yh4H_C5KCqPrFtxDgVVxA2w@mail.gmail.com>
References: <CAHULbC=doKVD1Y72qO9kpbi4YoQ6EginOLsbGC_cGrLRPcyV_Q@mail.gmail.com>
	<CAHULbCnLxNd4j9f3Nfa7-hr0DJ8A_b_sge+1haunDqbPbS1siA@mail.gmail.com>
	<63F3EB16E0CC4D6E9AC1F738A38838F0@dreamhost.com>
	<CAHULbCk90QZ7J0gc+_8V7LW9i5Amz2jxSo6QPJKx3Pp90Q4SBg@mail.gmail.com>
	<Pine.LNX.4.64.1203231729120.6414@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51599 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab2CYIRz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Mar 2012 04:17:55 -0400
Received: by ghrr11 with SMTP id r11so3415083ghr.19
        for <ceph-devel@vger.kernel.org>; Sun, 25 Mar 2012 01:17:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203231729120.6414@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: Greg Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

2012/3/24 Sage Weil <sage@newdream.net>:
> On Fri, 23 Mar 2012, ruslan usifov wrote:
>> Sorry for my bad English.
>>
>> I mean that, if throw pacemaker we organize fault tolerant monitor
>> (monitor that will work all time - even in fail case), we prevent
>
> The other key thing to keep in mind is that this is completely unnece=
ssary
> with Ceph. =9AJust run 3 (or 5, or 7, or whatever) monitors, and indi=
vidual
> ceph-mon failures won't affect the availability. =9ACeph clients are =
smart
> enough to find a non-failed monitor, and the cluster manages consiste=
ncy
> and so forth on it's own.
>
> The whole point is to _avoid_ kludgey proxy/failover solutions like
> this...
>
> sage

Yes, you right and I agree with you, but if "Ceph clients are smart
enough to find a non-failed monitor" why they not smart to prevent
connect to failed monitor until it fully restore, so now I have
periodical delays when client try to connect to failed monitor,
=D3ertainly finally it find live monitor and all work fine, and with
failover i try to solve problem of this delays
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
