From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: SUSE install/config issue...
Date: Mon, 27 Dec 2010 16:45:31 -0800
Message-ID: <AANLkTik6JUpj3qgnh4iSb0P0VTt9xpSL-mwh-5atan_=@mail.gmail.com>
References: <1293491636.12960.8.camel@hermosa.morreale.net>
	<AANLkTikqntKK1sWbt-bVOQYviNZxpL6bGkysyeKvhFKS@mail.gmail.com>
	<1293494432.12960.16.camel@hermosa.morreale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51008 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab0L1Apd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Dec 2010 19:45:33 -0500
Received: by fxm20 with SMTP id 20so9451771fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Dec 2010 16:45:32 -0800 (PST)
In-Reply-To: <1293494432.12960.16.camel@hermosa.morreale.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: pmorreale@novell.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Peter,

I wasn't sure which option you had picked on that page--
install-from-source, or install-from-opensuse-build-service.

It might be better if you build from source for now. We have made lots
of improvements and I don't know when the openSuSE build service last
updated their package. It should be pretty straightforward-- install
required libraries, then autogen + configure + make -j 8 + make
install. I think more details are on the wiki page.

If you want to build the kernel client, there's a page about it here:
http://ceph.newdream.net/wiki/Building_kernel_client

As sort of a hello world project, though, I would recommend trying cfus=
e first.

Colin


On Mon, Dec 27, 2010 at 4:00 PM, Peter W. Morreale <pmorreale@novell.co=
m> wrote:
> On Mon, 2010-12-27 at 15:30 -0800, Colin McCabe wrote:
>> Hi Peter,
>>
>> The cfuse binary is part of ceph. Normally, it would be installed by
>> make install. Try re-running configure and make, making sure to
>> specify ./configure --with-fuse
>>
>> Also, you might want to consider using the kernel client, since its
>> performance is higher.
>>
>> P.S. I just changed the "installing on SuSE" wiki page to recommend
>> configure --with-fuse, since it also recommends cfuse.
>>
>> cheers,
>> Colin
>
> Thanks Colin.
>
> Totally confused at this point. =A0:-) =A0I had assumed that by using=
 the
> SUSE packages, everything *was* built and installed.
>
> So this means the SUSE packages are incomplete? =A0(Yes, I realize it=
 is
> 11.2, thus old...)
>
> As for performance, not too worried at the moment, I have this instal=
led
> on 3 VMs, merely for testing and gaining familiarity... =A0I will mov=
e it
> to a lab after I get a chance to play with it and understand what I a=
m
> doing.
>
> Am I to understand that one has a choice of using a user-space client=
 or
> a kernel client? =A0The SUSE packages did reference a kernel module.
>
> Perhaps the src tree has documentation on this? =A0Obviously I am mis=
sing
> the bigger picture...
>
> Best,
> -PWM
>
>
>>
>>
>> On Mon, Dec 27, 2010 at 3:13 PM, Peter W. Morreale <pmorreale@novell=
=2Ecom> wrote:
>> >
>> > I'm attempting to install ceph for the first time on openSUSE 11.2=
,
>> > using the packages out of factory. =A0I used the wiki page:
>> > http://ceph.newdream.net/wiki/Installing_on_SuSE under the "Comple=
x
>> > System" part. =A0All appears to be fine other than I cannot seem t=
o find
>> > the 'cfuse' comand/script. =A0A find of root failed to locate it a=
s well.
>> >
>> >
>> > Where do I find the 'cfuse' command/script?
>> >
>> > Thx
>> > -PWM
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
