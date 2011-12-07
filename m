From: Christian Brunner <chb@muc.de>
Subject: Re: 'ceph -w' in 0.39
Date: Wed, 7 Dec 2011 21:20:07 +0100
Message-ID: <CAO47_-_R97_p7R8djYyhypnxTzS7JGC5Vea6eqA3Jw4Dbeyt1w@mail.gmail.com>
References: <CAO47_--yZib5-zpwDutQSdiw7f8CWu=2CE0jNVAVP2fD4nrcZA@mail.gmail.com>
	<Pine.LNX.4.64.1112051342290.13773@cobra.newdream.net>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54393 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757618Ab1LGUUI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 15:20:08 -0500
Received: by vcbfk14 with SMTP id fk14so825299vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2011 12:20:07 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1112051342290.13773@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

2011/12/5 Sage Weil <sage@newdream.net>:
> Hi Christian,
>
> On Mon, 5 Dec 2011, Christian Brunner wrote:
>> I've just updated to 0.39. Everything seems to be fine, except one
>> minor thing I noticed:
>>
>> 'ceph -w' output stops after a few minutes. With "debug ms =3D 1" it
>> ends with these lines:
>>
>> 2011-12-05 14:45:52.939300 7fc700637700 -- 10.255.0.21:0/14145 <=3D=3D
>> mon.2 10.255.0.22:6789/0 315 =3D=3D=3D=3D mon_observe_notify(v452555=
0 1303
>> bytes v4525550) v1 =3D=3D=3D=3D 1354+0+0 (339634604 0 0) 0x7fc6f4000=
920 con
>> 0x874070
>> 2011-12-05 14:45:52.939319 =A0 =A0pg v4525550: 2776 pgs: 2776
>> active+clean; 3362 GB data, 1646 GB used, 57135 GB / 59615 GB avail
>>
>> After that, silence...
>
> I just pushed a fix for this to the stable branch.

Thanks! It's working now.

Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
