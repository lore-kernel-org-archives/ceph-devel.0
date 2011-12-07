From: Damien Churchill <damoxc@gmail.com>
Subject: Re: rbd device would disappear after re-boot
Date: Wed, 7 Dec 2011 02:48:58 +0000
Message-ID: <CAFtEh-e9_93PL9rqbmUwCKjPLeQVug9QTWRg=wdQwRj-vt0EXQ@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D943112@WHQBEMAIL1.whq.wistron>
	<CAORUGqDjAW-PpqtfL_hzDKZEk3HbgozBBjip-nBYhG6yYgduTg@mail.gmail.com>
	<8512670932FB654F81AF0FEF1BE6D49D9433C2@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49330 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab1LGCs7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 21:48:59 -0500
Received: by dadv6 with SMTP id v6so100402dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2011 18:48:59 -0800 (PST)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D9433C2@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: tommi.virtanen@dreamhost.com, ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com

On 7 December 2011 02:38,  <Eric_YH_Chen@wistron.com> wrote:
> Hi, Tommi:
>
> Thanks for your suggestion.
>
> We will try to implement a workaround solution for our internal exper=
iment.
>
> I have another little question. Could I map specific image to specifi=
c device?
>
> For example:
> Before re-boot
> id =C2=A0 =C2=A0 =C2=A0pool =C2=A0 =C2=A0image =C2=A0 snap =C2=A0 =C2=
=A0device
> 0 =C2=A0 =C2=A0 =C2=A0 rbd =C2=A0 =C2=A0 foo1 =C2=A0 =C2=A0- =C2=A0 =C2=
=A0 =C2=A0 /dev/rbd0
> 1 =C2=A0 =C2=A0 =C2=A0 rbd =C2=A0 =C2=A0 foo3 =C2=A0 =C2=A0- =C2=A0 =C2=
=A0 =C2=A0 /dev/rbd2
>
> How could I re-map the image(foo3) to device(/dev/rbd2) but skip rbd1=
? =C2=A0The command provided by ceph CLI cannot achieve this.
>
> If I re-map the image to another device, it would not sync with iSCSI=
 configuration and may cause problem.
>

You can use the symlinks created, if memory serves they end up as
something along the lines of:

/dev/rbd/<poolname>/<diskname>:0

> Thanks a lot!
>
>
> -----Original Message-----
> From: Tommi Virtanen [mailto:tommi.virtanen@dreamhost.com]
> Sent: Wednesday, December 07, 2011 3:11 AM
> To: Eric YH Chen/WHQ/Wistron
> Cc: ceph-devel@vger.kernel.org; Chris YT Huang/WHQ/Wistron
> Subject: Re: rbd device would disappear after re-boot
>
> On Tue, Dec 6, 2011 at 01:31, =C2=A0<Eric_YH_Chen@wistron.com> wrote:
>> =C2=A0 Another question about the rbd device. All rbd device would d=
isappear
>> after server re-boot.
>>
>> =C2=A0 Do you have any plan to implement a feature that server would=
 re-map
>> all the device during initialization?
>>
>> =C2=A0 If not, do you have any suggestion (about technical part) if =
we want
>> to implement this feature?
>>
>> =C2=A0 Furthermore, we would like to send a pull request after we fi=
nish it,
>> any policy should we take-care?
>
> Yes, all mappings need to be re-established after a reboot.
>
> There is no convention yet on configuring what should be
> re-established. Right now, putting an "rbd map" in something like
> /etc/rc.local is a decent workaround.
>
> I created http://tracker.newdream.net/issues/1790 to track this featu=
re.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
