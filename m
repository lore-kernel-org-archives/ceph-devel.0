From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Installing and configuring ceph
Date: Thu, 6 Jan 2011 10:03:15 -0800
Message-ID: <AANLkTi=hiEn8vOBvqjHaNqU=ETFpBeTZ=mHoOyE=V4Lc@mail.gmail.com>
References: <1294327481.3371.163.camel@hermosa.morreale.net>
	<Pine.LNX.4.64.1101060736150.3524@cobra.newdream.net>
	<1294328892.3371.167.camel@hermosa.morreale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64182 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab1AFSDQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jan 2011 13:03:16 -0500
Received: by fxm20 with SMTP id 20so16238011fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Jan 2011 10:03:15 -0800 (PST)
In-Reply-To: <1294328892.3371.167.camel@hermosa.morreale.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pmorreale@novell.com
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

I use

=2E/autogen.sh && CXXFLAGS=3D"-g -O2" ./configure --prefix=3D/usr
--sbindir=3D/sbin --localstatedir=3D/var --sysconfdir=3D/etc --with-deb=
ug

Maybe we should put that into a 1-line script and check it in; I don't =
know.

automake is a little wacky sometimes (in my opinion)... for example, I
think the default sysconf dir is /usr/etc, which most people don't
expect

Colin


On Thu, Jan 6, 2011 at 7:48 AM, Peter W. Morreale <pmorreale@novell.com=
> wrote:
> On Thu, 2011-01-06 at 07:39 -0800, Sage Weil wrote:
>> Hi Peter,
>>
>> On Thu, 6 Jan 2011, Peter W. Morreale wrote:
>> >
>> > I'm having a difficult time installing ceph for the first time by
>> > following the newdream wiki site. =A0Can some kind soul help with =
the
>> > following?
> ..
>> >
>> > Clearly I am missing the larger picture on how to install. =A0Than=
ks in
>> > advance for any info.
>>
>> The wiki is it. =A0Any specific suggestions on what pieces of inform=
ation
>> (beyond the above) that would make it more helpful are welcome!
>>
>
> Thanks Sage. =A0I completely understand on where things stand and yes=
, I
> will make suggestions as I get further along.
>
> Best,
> -PWM
>
>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
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
