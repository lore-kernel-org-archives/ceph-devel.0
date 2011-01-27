From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogcXVlc3Rpb24gYWJvdXQgbG9nZ2VyLmNj?=
Date: Wed, 26 Jan 2011 21:28:07 -0800
Message-ID: <AANLkTi=oNR8J=M2ShaJ2watNnC4s=oxHnXhe2TeTqnqi@mail.gmail.com>
References: <Pine.LNX.4.64.1101250808480.3488@cobra.newdream.net>
	<D0C67741759ABD4BBD8D3A5CB815606E07E64C@mail.cloud-valley.com.cn>
	<AANLkTimHxjuKQVGkC=XGVh7bQgqDTyEKbuH98CNZkFrX@mail.gmail.com>
	<D0C67741759ABD4BBD8D3A5CB815606E07E65E@mail.cloud-valley.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40806 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab1A0F2I convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jan 2011 00:28:08 -0500
Received: by ewy5 with SMTP id 5so629141ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jan 2011 21:28:07 -0800 (PST)
In-Reply-To: <D0C67741759ABD4BBD8D3A5CB815606E07E65E@mail.cloud-valley.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Longguang Yue <longguang_yue@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jan 26, 2011 at 5:36 PM, Longguang Yue
<longguang_yue@tcloudcomputing.com> wrote:
> I update 0.23.1 =A0to 0.24.2. =A0 I do not success in running ceph 0.=
24* version.!!!!!!
>
> L meet lots of error. =A0 This is step:
> 1.make ceph.rpm ---------------ok
> 2.mkcephfs --------------------;first time is ok,but when run /etc/in=
it.d/ceph -a start , lots of error occur!!!!!!
> 3.mkcephfs second time ,
>> common/Mutex.h: In function 'void Mutex::Lock(bool)':
>> common/Mutex.h:118: FAILED assert(r =3D=3D 0)
>> =A0ceph version 0.24.2 (commit:f7572de5cb87eb7157217be4975ae66d90831=
bb7)
>> =A01: (SafeTimer::shutdown()+0x6b1) [0x44a101]
>> =A02: (FlusherStopper::~FlusherStopper()+0x58) [0x444788]
>> =A03: (exit()+0xe1) [0x3716a379c1]
>> =A04: (__libc_start_main()+0x104) [0x3716a1ee84]
>> =A05: /usr/bin/cconf() [0x416769]
You're going to need to be a little more clear about how you're
encountering these errors. Let me make sure I've got this clear:
1) You compile the code and make the RPM and that goes fine.
2) You run mkcephfs (and the output from that is in your attached
mkcephfs.txt?).
3) You try and run etc/init.d/ceph -a start, and get errors. Which
errors do you get?
4) You run mkcephfs again?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
