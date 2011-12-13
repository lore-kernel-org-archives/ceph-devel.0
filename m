From: pankaj singh <psingh.ait@gmail.com>
Subject: Re: Problem while CEPH setup
Date: Tue, 13 Dec 2011 22:28:17 +0530
Message-ID: <CAPrqf91Ch0UDjmqkp77ZhTQm34D=8jGdT7F921g4qEBUFcaxow@mail.gmail.com>
References: <CAPrqf92pUqDZznQHhnKAwFHwZh0OMWs3r-5VMjWcu_g9ds-ehQ@mail.gmail.com>
	<CAPrqf9335B=mh7KOHLr_hDv2BwTG0T54fQsWG4zMPsyOjgGw1A@mail.gmail.com>
	<Pine.LNX.4.64.1112080827550.2448@cobra.newdream.net>
	<Pine.LNX.4.64.1112080837310.2448@cobra.newdream.net>
	<CAPrqf90QD_evG8a1a8qvkTMbG42-4eFyT2VPZ8S+VPhDubzmpQ@mail.gmail.com>
	<CAORUGqAZHGuysP-xjBbBPm9arWXuLOUrmwL_C_ynAq9ny2jmTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52410 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab1LMQ6T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2011 11:58:19 -0500
Received: by vcbfk14 with SMTP id fk14so4818445vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2011 08:58:18 -0800 (PST)
In-Reply-To: <CAORUGqAZHGuysP-xjBbBPm9arWXuLOUrmwL_C_ynAq9ny2jmTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Its seems that "fix" has been merged into the master, so its resolved.

Regards,
~Pankaj Singh

On Tue, Dec 13, 2011 at 2:55 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Thu, Dec 8, 2011 at 09:25, pankaj singh <psingh.ait@gmail.com> wro=
te:
>> Hi Sage,
>>
>> After pulling the changes, the problem has been resolved.
>>
>> Still, we are getting problem in ceph-mon command. It fails to creat=
e
>> ceph-mon demon.
>>
>> # ceph-mon -c ceph.conf -i 0
>> =A0** WARNING: Ceph is still under development. =A0Any feedback can =
be directed =A0**
>> =A0** =A0 =A0 =A0 =A0 =A0at ceph-devel@vger.kernel.org or http://cep=
h.newdream.net/. =A0 =A0 **
>> starting mon.0 rank 0 at 192.168.56.101:6789/0 mon_data
>> /root/workera/CEPH/mondata/data/mon.0 fsid
>> 531eb76e-9181-41c4-b162-66b05cfda952
>>
>> So we getting timeout when we try to mount ceph client (both fuse an=
d
>> kernel client).
>
> I see no error message there. Do you have an actual error, for exampl=
e
> from the logs in /var/log/ceph/ ?



--=20
Regards,
Pankaj SIngh
Phone No: 8826266889
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
