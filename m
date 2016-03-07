From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: master build failure with boost 1.60
Date: Mon, 7 Mar 2016 10:31:22 -0700
Message-ID: <CAANLjFqR2TDcuCQh=Avo5UyDNskjStPt5o_Jk3ehJ4Bhug1whg@mail.gmail.com>
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
	<56DDB0B0.2090005@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33752 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbcCGRbX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 12:31:23 -0500
Received: by mail-vk0-f41.google.com with SMTP id k1so108669144vkb.0
        for <ceph-devel@vger.kernel.org>; Mon, 07 Mar 2016 09:31:22 -0800 (PST)
In-Reply-To: <56DDB0B0.2090005@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

If we use boost 1.60, we can use intrusive maps which would be a lot
easier in that code. I had to not use them to keep compatibility with
older versions. I'm surprised that it is broken in newer versions.
I'll see if I can figure out what is going wrong here.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.6
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJW3brlCRDmVDuy+mK58QAAUkEQAK29Zc6W3IgBung03c1T
md86mP1i6uBqyA4oFTmM4r4CF5dCQRrrAHXSd/1cM9bcvFmsir1LAjEalKaP
f8P+lOPbHE8InQBe1b/pcS9vC2CaK8QeceONJBaEzlqwMaGFsIIFvlUd38jf
7Az/GlfRL+34LxAnShXQQJNTy8U7qqGp4ugRZSVPz9QaZDOayArfv3mlwzpD
rzmXDWeq4JqGhtKdwlWiGdB6EF7t9BdbFzYFCcUyJ5v9G3kTMQJ7ROnv4Zu2
ZoPVKcQ0wnjwxQSZVLGnvw1sYHeO9vUItqaMDl3RjpQrjXx25FpNY/9NrInT
b14V/yEaDVyK1y85a2nLTwVVkRPq8GMXIJtvkCSV5sS2Zoo8Y85sX8SAL6qq
y/hn4Uq73T+CBGq3Gy6Key7VnvzGcq9EvVw+3UnMkaxdyZOAQy/ly0lYLjpF
SBw51h9ExPpl0pRACkkoa+64NeAlej3Zqk2c2EgB4+WGjuUhdSMxSmSmhLDw
+VYQhz/GMHB+M7AkNIW9Cgo/muCM5jbhkU6wbHB6fKvohpA23UwWXBsK6AU+
xjWJw0PuSYwpUsKYoD/U4F0YUDM39CQC6qpP1iCeVeptiuKzg7JWi0jh7myN
mkuSjPo90ypaLa3kioX69Hr9BcCTTZ82wMjn44A5e3PV8Tvict2CYmCua57U
Stp2
=DdLX
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Mar 7, 2016 at 9:47 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>
>
> On 03/07/2016 03:49 PM, Karol Mroz wrote:
>> Hi folks,
>>
>> We've recently hit a build failure on ceph master for which Abhishek has opened
>> a bug: http://tracker.ceph.com/issues/14998.
>>
>> Our rolling distribution (openSUSE Tumbleweed) has pushed out boost 1.60
>> which looks to be at the heart of the failure. Is boost 1.60 to be supported in
>> Jewel?
>
> Reverting https://github.com/ceph/ceph/pull/7654 makes the build
> succeed, of course that is not the solution, but might indicate where we
> may need fixing
>
> Regards
> Abhishek
>
>> Thanks!
>>
>
