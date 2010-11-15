From: Takuya ASADA <syuu@dokukino.com>
Subject: Re: Java binding for RADOS API
Date: Mon, 15 Nov 2010 08:20:58 +0000
Message-ID: <AANLkTimbogvHcoZsFTUPQ9imKcvt9eafOoCp08-dpDgE@mail.gmail.com>
References: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com>
 <1289568944.4894.16.camel@wido-desktop> <AANLkTins-08+N4Wqj-0qSE4XrZ1LaestckCd4RL9w+R2@mail.gmail.com>
 <1289808125.1367.2.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675Ab0KOIVU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Nov 2010 03:21:20 -0500
Received: by wyb28 with SMTP id 28so4143214wyb.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Nov 2010 00:21:18 -0800 (PST)
In-Reply-To: <1289808125.1367.2.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi,

> How did you do this? Did you map all Walrus objects 1:1 to RADOS? If so,
> that should give you pretty large RADOS objects. That is not a problem,
> RADOS can handle that, but performance-wise it isn't the best way to go.
>
> Or does Walrus split it's internal objects into smaller ones?

I didn't know there's performance penalty, so currently it's just 1:1.
I think eucalyptus administration tool split up a VM image to multiple
objects when store it into Walrus,
but that's only for VM image.
Normal S3 put go directly 1:1.

What is the best size when split it up anyway?
Maybe I should refer rbd code?

>> So these are different services, which can work together.
>> I think if both services could integrated into Eucalyptus(or the
>> another IaaS platform such as OpenStack) that will be exciting.
>>
>> Ceph already has radosgw for S3 compatible service anyway, but it
>> looks much easier to use RADOS API from Walrus, so I implemented that
>> way.
>
> Yes, the radosgw from Ceph is proof-of-concept, what RADOS/Ceph is
> capable of. Do you have your Walrus integration online somewhere?

Well, currently my testing environment is on the internal network.
If you want to test it I can setup.

>>
>> > But great work! I think a lot of people don't see the full potential of
>> > RADOS, hope your bindings and phprados will make more people use RADOS.
>> >
>> > If you ask Sage, he might want to setup a new GIT repo for you and a
>> > project in the tracker, so we can keep track of bugs and features.
>> >
>> > Thanks,
>> >
>> > Wido
>
> About the Wiki, you are free to create a page :-)
Okay, thanks.

syuu
