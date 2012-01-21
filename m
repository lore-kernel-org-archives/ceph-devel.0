From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: upgrade from 0.39 to 0.40 failed...
Date: Sat, 21 Jan 2012 09:01:22 -0800
Message-ID: <CAF3hT9DmBpQL5vWFH11G=FpF6VuZEYipyvsj0J2_ZKZtLhcmWA@mail.gmail.com>
References: <4F1ABD5C.1000907@smart-weblications.de>
	<4F1AE704.6010005@widodh.nl>
	<4F1AE824.3000006@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37297 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab2AURBW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Jan 2012 12:01:22 -0500
Received: by iacb35 with SMTP id b35so1268695iac.19
        for <ceph-devel@vger.kernel.org>; Sat, 21 Jan 2012 09:01:22 -0800 (PST)
In-Reply-To: <4F1AE824.3000006@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Sat, Jan 21, 2012 at 8:30 AM, Smart Weblications GmbH - Florian
Wiessner <f.wiessner@smart-weblications.de> wrote:
> Am 21.01.2012 17:25, schrieb Wido den Hollander:
>> Hi,
>>
>>
>> Although I don't think it is related I'd advise you to switch from n=
umeric
>> monitor names to alphanumeric names:
>>
>> A while ago this changed, I also think the configuration doesn't eve=
n allow
>> numeric monitors anymore? (correct me if I'm wrong!)
>>
>
> Well, this config used to work with 0.39 - i did not see any hint in =
the relase
> mail that i have to change something in the config - 0.40 should be m=
ostly a
> stabilization release...
>
> I can change the config etc and setup again when i am able to get my =
data out of
> the current installation.
>
>>>
>>> i did set up ceph without cephx
>>
>> When did you enable cephx? Did you do so from the upgrade to 0.39 to=
 0.40 or
>> earlier?
>
> As stated above, i did not set up ceph with authentication. so there =
was no
> authentication used in 0.39 nor in 0.40
>
> But now somehow authentication seems to be enforced - at least that's=
 what i
> read from the output that ceph -w gives me...

Actually that might just be a red herring =97=A0check the monitor log t=
hat
your ceph -w client tried to connect to and see what it says about the
connection attempt. :)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
