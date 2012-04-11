From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: [PATCH] Statically binding ports for ceph-osd
Date: Tue, 10 Apr 2012 17:13:14 -0700
Message-ID: <CAPud5_55jJ1tfxD_XVQGJE+5wZe2jhYnwmv3aqXOgT1tbCXOkw@mail.gmail.com>
References: <CAPud5_4Fhjxwb2AjznBNPif8gLUrsJYqtkLX5OzBLMA1JAvw3g@mail.gmail.com>
	<CAPud5_7B8DG4hnVTqBnw7aHuJf8CJnPUjo3ZUfOjDPo89rqvSQ@mail.gmail.com>
	<C1A5CCB0C744475E8F129F38DAE60867@dreamhost.com>
	<CAPud5_7uh6k7=5aT2YH0Lyv23+L=r5Awuw8zdhhdwvhzaWm_qw@mail.gmail.com>
	<Pine.LNX.4.64.1204101651270.18921@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47893 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759845Ab2DKANP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Apr 2012 20:13:15 -0400
Received: by yenl12 with SMTP id l12so241416yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Apr 2012 17:13:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204101651270.18921@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Greg Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Good enough for me, I'll just patch it for the short term.

Thanks!

On Tue, Apr 10, 2012 at 4:51 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 10 Apr 2012, Nick Bartos wrote:
>> Awesome, thanks so much! =A0Can I assume this will make it into the =
next
>> ceph stable release? =A0I'll probably just backport it now before we
>> actually start using it, so I don't have to change the config later.
>
> v0.45 is out today/tomorrow, but it'll be in v0.46.
>
> sage
>
>
>>
>> On Tue, Apr 10, 2012 at 4:16 PM, Greg Farnum
>> <gregory.farnum@dreamhost.com> wrote:
>> > Yep, you're absolutely correct. Might as well let users specify th=
e whole address rather than just the port, though ? since your patch wo=
n't apply to current upstream due to some heartbeating changes I whippe=
d up another one which adds the "osd heartbeat addr" option. It's pushe=
d it to master in commit 6fbac10dc68e67d1c700421f311cf5e26991d39c, but =
you'll want to backport (easy) or carry your change until you upgrade (=
and remember to change the config!). :)
>> > Thanks for the report!
>> > -Greg
>> >
>> >
>> > On Tuesday, April 10, 2012 at 12:56 PM, Nick Bartos wrote:
>> >
>> >> After doing some more looking at the code, it appears that this o=
ption
>> >> is not supported. I created a small patch (attached) which adds t=
he
>> >> functionality. Is there any way we could get this, or something l=
ike
>> >> this, applied upstream? I think this is important functionality f=
or
>> >> firewalled environments, and seems like a simple fix since all th=
e
>> >> other services (including ones for ceph-mon and ceph-mds) already
>> >> allow you to specify a static port.
>> >>
>> >>
>> >> On Mon, Apr 9, 2012 at 5:27 PM, Nick Bartos <nick@pistoncloud.com=
 (mailto:nick@pistoncloud.com)> wrote:
>> >> > I'm trying to get ceph-osd's listening ports to be set statical=
ly for
>> >> > firewall reasons. I am able to get 2 of the 3 ports set statica=
lly,
>> >> > however the 3rd one is still getting set dynamically.
>> >> >
>> >> > I am using:
>> >> >
>> >> > [osd.48]
>> >> > host =3D 172.16.0.13
>> >> > cluster addr =3D 172.16.0.13:6944
>> >> > public addr =3D 172.16.0.13:6945
>> >> >
>> >> > The daemon will successfully bind to 6944 and 6945, but also bi=
nds to
>> >> > 6800. What additional option do I need? I started looking at th=
e
>> >> > code and thought "hb addr =3D 172.16.0.13:6946" would do it, bu=
t
>> >> > specifying that option seems to have no effect (or at least doe=
s not
>> >> > achieve the desired result).
>> >>
>> >>
>> >>
>> >> Attachments:
>> >> - ceph-0.41-osd_hb_port.patch
>> >>
>> >
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
