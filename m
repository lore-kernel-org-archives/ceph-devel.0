From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, Clang refuses to compile a test
Date: Mon, 7 Dec 2015 22:44:51 +0100
Message-ID: <5665FDD3.90000@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
 <alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
 <565DA3B5.1070608@digiware.nl>
 <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
 <565DC9D4.7060701@digiware.nl> <565DEC36.10102@digiware.nl>
 <565F5E28.8020706@digiware.nl> <5660106F.90202@digiware.nl>
 <5662DEEB.7060208@digiware.nl>
 <CANE=7sX5w36vhpN6TGNc4e_LBEsxcZokzEJX-Qs63zUbS4ynLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:64693 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840AbbLGVpJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Dec 2015 16:45:09 -0500
In-Reply-To: <CANE=7sX5w36vhpN6TGNc4e_LBEsxcZokzEJX-Qs63zUbS4ynLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 5-12-2015 14:02, Xinze Chi (=E4=BF=A1=E6=B3=BD) wrote:
> I think "const int k =3D 12; const int m =3D 4" would pass the compil=
e?


Are these sizes big enough??

--WjW

> 2015-12-05 20:56 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
>> src/test/erasure-code/TestErasureCodeIsa.cc
>>
>> contains snippets, function definition like:
>>
>> buffer::ptr enc[k + m];
>>    // create buffers with a copy of the original data to be able to =
compare
>> it after decoding
>>    {
>>      for (int i =3D 0; i < (k + m); i++) {
>>
>> Clang refuses because the [k+m] size in not known at compiletime.
>> Suggesting to tempate this.
>>
>> How would one normally handle this?
>>
>> I've temporarily made it fixed size 1024*1024.
>> But I'm not sure if that is big enough
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
