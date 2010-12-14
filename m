From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: packaging for ceph-gui
Date: Tue, 14 Dec 2010 13:06:35 -0800
Message-ID: <AANLkTikmi_Ke02Fd4BrRXGCiKHSuQhCwY6UME+QU04Uh@mail.gmail.com>
References: <Pine.LNX.4.64.1012141155100.26702@cobra.newdream.net>
	<1292358476.25794.88.camel@julia.gcs.org.hu>
	<Pine.LNX.4.64.1012141235310.22978@cobra.newdream.net>
	<1292359839.25794.99.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:64570 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759994Ab0LNVGg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Dec 2010 16:06:36 -0500
Received: by fxm18 with SMTP id 18so1243829fxm.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Dec 2010 13:06:35 -0800 (PST)
In-Reply-To: <1292359839.25794.99.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Dec 14, 2010 at 12:50 PM, Laszlo Boszormenyi <gcs@debian.hu> wr=
ote:
> On Tue, 2010-12-14 at 12:37 -0800, Sage Weil wrote:
>> On Tue, 14 Dec 2010, Laszlo Boszormenyi wrote:
>> > =A0It's up to you how to name it. As for the rule of thumb, packag=
es named
>> > after the binary they contain. So it should be gceph, but can be
>> > ceph-gui if you want.
>>
>> I'm inclined to rename gceph to ceph-gui, actually, unless anyone ha=
s any
>> strong opinions about it...
> =A0Either is fine for me, should be gceph after the binary but I admi=
t
> that ceph-gui is more suitable for its name. Still if I've a voting
> right, I'd say ceph-gui suggests it's only a GUI for the CLI binary
> (needs ceph, just calls ceph with it's switches in the background). I=
t's
> not the case, it's a standalone binary, a graphical ceph -> gceph. Of
> course the choice is yours.

Yeah, after some discussion, I think we're sticking with gceph. Sorry
for the email spam :)

Let me know if you have any issues w/ packaging...

Colin

>
>> > The question is, when do you want to merge these changes to rc? Th=
ere
>> > are unstable and gceph trees available, but are they for v0.24 or =
not?
>>
>> The binary is standalone. =A0They should just recommend each other, =
I think.
>> And this is all in the unstable branch (for v0.25), so we can just c=
hange
>> it there.
> =A0OK, will do tomorrow if you decide on how to name its package.
>
> Offtopic: What's your timezone? I'm UTC/GMT +1.
>
> Laszlo/GCS
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
