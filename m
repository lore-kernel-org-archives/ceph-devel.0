From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Ceph 0.42: Cannot make RPM from spec-file (unpackaged file ceph-dencoder)
Date: Tue, 21 Feb 2012 11:38:03 -0800
Message-ID: <CAF3hT9AF=xb-rJ=JWWxspsbQSCeFGWwu+MKETC5YeC54h9ZVAA@mail.gmail.com>
References: <4008345.82nISvLeLu@pc10>
	<Pine.LNX.4.64.1202211107120.30694@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39299 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab2BUTiE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 14:38:04 -0500
Received: by yenm8 with SMTP id m8so3091229yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 11:38:03 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1202211107120.30694@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Guido Winkelmann <guido-ceph@thisisnotatest.de>, ceph-devel@vger.kernel.org

On Tue, Feb 21, 2012 at 11:07 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 21 Feb 2012, Guido Winkelmann wrote:
>> Hi,
>>
>> With Ceph 0.42, I am unable to create an RPM from supplied spec-file=
=2E
>>
>> When running rpmbuild -ba ceph-0.42/ceph.spec, the command fails at =
the end
>> with this:
>>
>> Checking for unpackaged file(s): /usr/lib/rpm/check-files
>> /root/rpmbuild/BUILDROOT/ceph-0.42-6.fc14.x86_64
>> error: Installed (but unpackaged) file(s) found:
>> =A0 =A0/usr/bin/ceph-dencoder
>>
>>
>> RPM build errors:
>> =A0 =A0 Installed (but unpackaged) file(s) found:
>> =A0 =A0/usr/bin/ceph-dencoder
>>
>> I could get it to build anyway by including the line
>>
>> %{_bindir}/ceph-dencoder
>>
>> in the files section of the spec file.
>
> Adding ceph-dencoder (and man page) to the .deb and .rpm now. =A0Than=
ks!

Wouldn't it be better to only install those with the ceph-devel
packages? Users won't ever want those binaries.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
