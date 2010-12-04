From: Christian Brunner <chb@muc.de>
Subject: Re: crashed+down+peering
Date: Sat, 4 Dec 2010 21:28:59 +0100
Message-ID: <AANLkTinTGHy-SPDNev0wXfgzU5-JR4RYe36fnnF4Pg60@mail.gmail.com>
References: <AANLkTi=qVPB4ouEySHKAbRZLo7YgSyq6MdyY3LkT5JfS@mail.gmail.com>
	<Pine.LNX.4.64.1012021126270.1982@cobra.newdream.net>
	<AANLkTikQkU6xmcvQ52Z=xBZgXubZ67hGAaZfUrqUdaKd@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40035 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab0LDU3A convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Dec 2010 15:29:00 -0500
Received: by iwn6 with SMTP id 6so1454461iwn.19
        for <ceph-devel@vger.kernel.org>; Sat, 04 Dec 2010 12:28:59 -0800 (PST)
In-Reply-To: <AANLkTikQkU6xmcvQ52Z=xBZgXubZ67hGAaZfUrqUdaKd@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

>> On Thu, 2 Dec 2010, Christian Brunner wrote:
>>> We have simulated the simultanious crash of multiple osds in our
>>> environment. After starting all the cosd again, we have the followi=
ng
>>> situation:
>>>
>>> 2010-12-02 16:18:33.944436 =A0 =A0pg v724432: 3712 pgs: 1 active, 3=
605
>>> active+clean, 1 crashed+peering, 46 down+peering, 56
>>> crashed+down+peering, 3 active+clean+inconsistent; 177 GB data, 365=
 GB
>>> used, 83437 GB / 83834 GB avail; 1/93704 degraded (0.001%)
>>>
>>> When I set of an "rbd rm" command for one of our rbd volumes, it se=
ems
>>> to hit the the "crashed+down+peering" pg. After that the command is
>>> stuck.
>>
>> The pg isn't active, so any IO will hang until peering completes. =A0=
What
>> version of the code are you running? =A0If it's something from unsta=
ble
>> from the last couple of weeks it's probably related to problems ther=
e;
>> please upgrade and restart the osds. =A0If it's the latest and great=
est
>> 'rc', we should look at the logs to see what's going on!
>
> We are running 0.23 - I will upgrade to the latest 'rc' tomorrow.

Upgrading to the latest rc version worked well. Everything is working
again and all, except one pg are "active+clean". However there is one
pg marked as "active+clean+inconsistent".

What can I do about an inconsistent group? I general a short
description of the possible pg states would be helpful.

Thanks,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
