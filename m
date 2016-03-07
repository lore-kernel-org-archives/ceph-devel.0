From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: master build failure with boost 1.60
Date: Mon, 7 Mar 2016 13:03:39 -0700
Message-ID: <CAANLjFqgFzN+WvzdN9q27JmHE4kFh3SP+LMQEWfXXckRMGe_4A@mail.gmail.com>
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
	<56DDB0B0.2090005@suse.com>
	<CAANLjFqR2TDcuCQh=Avo5UyDNskjStPt5o_Jk3ehJ4Bhug1whg@mail.gmail.com>
	<1897896272.61850279.1457380603124.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36627 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbcCGUDl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 15:03:41 -0500
Received: by mail-vk0-f53.google.com with SMTP id c3so130193584vkb.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Mar 2016 12:03:40 -0800 (PST)
In-Reply-To: <1897896272.61850279.1457380603124.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I was able to do what I needed to with avl_set/rbtree/avltree, just
http://www.boost.org/doc/libs/1_59_0/doc/html/intrusive/map_multimap.html
looks like it may provide a cleaner interface that would be closer to
the STL in C++. This was introduced in 1.59.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.6
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJW3d6RCRDmVDuy+mK58QAAXSAP/3gXRVAAuhVgoEmUnX6s
r+BrNqYoXZ5+lpXZbMNmZBfNeXKZSOeQW51Vjy4xHsYhi3nj29SDedwoc4Bq
DA+es5JN/8etfr3SZgyfA6DMnvsNpUT/OO1mSjpkiPsExG6lK4iVKf1Y/M9B
dXfHmeP3lVUMD08qgqzCgaYEoxQfI42tvF+PubcxfDp0OOq9/+SFD68YT+tL
PmA1BVjnCBtuPMmy4OzsbD7TFSdqr8rATUTW2TzkaxUMRN61oZnFqBwVjkj2
ZfdFtuZj1/W1+ddHnVbM0xz3asM7kUJUblPMGBXH+jVTr2Jq9/ftqB/fh3hS
45QGSjET6KJOPd3W3S2Kqbccpf2UZAThPFLz1+oNCls3Efn/3sBOsbQJNNBr
tSq3nJKa7oUqDF0Fs2hRQzEzYu5MnV9dN8dmW9eZSs3tbTtcWVQjfYve1NP1
+udkXyPQtnc4YY5EvDi/Xn6Yoh6NHxkbw2hZa1WmEQEbTb3X4CBZHNKLXAxR
Yx1PW08UPQrdhxUwQ41khvcVlElx9DLPwGnMlZQzvF4wnuEPqBSFNCqB2Eeh
pEB81e5gnR2Qwx7oHywh2aZpTxf9ybUsQvaCBettqmSUB66N36V/3eGTfHQH
CDdMw02iBD6PpG/FNq6Nkyh7D5y8duz2zrN2rvD1gpMWcssFIhbcXzH1ba4S
VZhU
=FBbh
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Mar 7, 2016 at 12:56 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> Hi Robert,
>
> What were you unable to do with Boost intrusive avl_set/rbtree/avltree in versions below 1.6?
>
> Matt
>
> ----- Original Message -----
>> From: "Robert LeBlanc" <robert@leblancnet.us>
>> To: "Abhishek Lekshmanan" <abhishek@suse.com>
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Sent: Monday, March 7, 2016 12:31:22 PM
>> Subject: Re: master build failure with boost 1.60
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> If we use boost 1.60, we can use intrusive maps which would be a lot
>> easier in that code. I had to not use them to keep compatibility with
>> older versions. I'm surprised that it is broken in newer versions.
>> I'll see if I can figure out what is going wrong here.
>> -----BEGIN PGP SIGNATURE-----
>> Version: Mailvelope v1.3.6
>> Comment: https://www.mailvelope.com
>>
>> wsFcBAEBCAAQBQJW3brlCRDmVDuy+mK58QAAUkEQAK29Zc6W3IgBung03c1T
>> md86mP1i6uBqyA4oFTmM4r4CF5dCQRrrAHXSd/1cM9bcvFmsir1LAjEalKaP
>> f8P+lOPbHE8InQBe1b/pcS9vC2CaK8QeceONJBaEzlqwMaGFsIIFvlUd38jf
>> 7Az/GlfRL+34LxAnShXQQJNTy8U7qqGp4ugRZSVPz9QaZDOayArfv3mlwzpD
>> rzmXDWeq4JqGhtKdwlWiGdB6EF7t9BdbFzYFCcUyJ5v9G3kTMQJ7ROnv4Zu2
>> ZoPVKcQ0wnjwxQSZVLGnvw1sYHeO9vUItqaMDl3RjpQrjXx25FpNY/9NrInT
>> b14V/yEaDVyK1y85a2nLTwVVkRPq8GMXIJtvkCSV5sS2Zoo8Y85sX8SAL6qq
>> y/hn4Uq73T+CBGq3Gy6Key7VnvzGcq9EvVw+3UnMkaxdyZOAQy/ly0lYLjpF
>> SBw51h9ExPpl0pRACkkoa+64NeAlej3Zqk2c2EgB4+WGjuUhdSMxSmSmhLDw
>> +VYQhz/GMHB+M7AkNIW9Cgo/muCM5jbhkU6wbHB6fKvohpA23UwWXBsK6AU+
>> xjWJw0PuSYwpUsKYoD/U4F0YUDM39CQC6qpP1iCeVeptiuKzg7JWi0jh7myN
>> mkuSjPo90ypaLa3kioX69Hr9BcCTTZ82wMjn44A5e3PV8Tvict2CYmCua57U
>> Stp2
>> =DdLX
>> -----END PGP SIGNATURE-----
>> ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>
>>
>> On Mon, Mar 7, 2016 at 9:47 AM, Abhishek Lekshmanan <abhishek@suse.com>
>> wrote:
>> >
>> >
>> > On 03/07/2016 03:49 PM, Karol Mroz wrote:
>> >> Hi folks,
>> >>
>> >> We've recently hit a build failure on ceph master for which Abhishek has
>> >> opened
>> >> a bug: http://tracker.ceph.com/issues/14998.
>> >>
>> >> Our rolling distribution (openSUSE Tumbleweed) has pushed out boost 1.60
>> >> which looks to be at the heart of the failure. Is boost 1.60 to be
>> >> supported in
>> >> Jewel?
>> >
>> > Reverting https://github.com/ceph/ceph/pull/7654 makes the build
>> > succeed, of course that is not the solution, but might indicate where we
>> > may need fixing
>> >
>> > Regards
>> > Abhishek
>> >
>> >> Thanks!
>> >>
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
