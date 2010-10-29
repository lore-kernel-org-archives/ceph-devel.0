From: Nat N <phenisha@gmail.com>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Fri, 29 Oct 2010 12:06:40 +1100
Message-ID: <AANLkTikT8PyiTP4_5rzn3VD_NVpJ-+z6LmyNXCVW2gui@mail.gmail.com>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
	<1288128642.10847.95.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
	<1288282588.10847.131.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:32856 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab0J2BGl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Oct 2010 21:06:41 -0400
Received: by qyk12 with SMTP id 12so6098383qyk.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Oct 2010 18:06:40 -0700 (PDT)
In-Reply-To: <1288282588.10847.131.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

>> Hi Jim,
>>
>> It turns out Henry's problem was actually cause by a bad fix on my p=
art,
>> d91f2438 in ceph-client.git. =A0(Unfortunately that made it into 2.6=
=2E36!)
>> Reverting that commit fixed things for him.
>>
>> I pushed that revert to the ceph-client.git master branch, or you ca=
n
>> revert it yourself. =A0master also includes everything that's been m=
erged
>> for 2.6.37-rc1, so you may want to revert it yourself and keep the 2=
=2E6.36
>> stuff.
>>

How can i revert this if I have simply downloaded the kernel source
from kernel.org?

Thanks
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
