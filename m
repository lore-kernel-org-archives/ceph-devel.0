From: Wido den Hollander <wido@42on.com>
Subject: Re: Building Ceph statically linked
Date: Wed, 13 Nov 2013 21:33:11 +0100
Message-ID: <5283E207.8060601@42on.com>
References: <5283DF7D.9080203@42on.com> <5283E000.3040707@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:49442 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab3KMUdM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Nov 2013 15:33:12 -0500
In-Reply-To: <5283E000.3040707@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/13/2013 09:24 PM, Loic Dachary wrote:
>
>
> On 13/11/2013 21:22, Wido den Hollander wrote:
>> Hi,
>>
>> While doing some tests I'm trying to build Ceph statically. I have a
>> bunch of machines where I run Ceph on for these test (mostly RGW now)
>> and I'm running into some library issues when switching from branches.
>>
>> To make my life a bit easier I tried compiling Ceph (especially RGW)
>> statically linked, but somehow I keep ending up with a dynamically
>> linked binary.
>>
>> What I tried:
>>
>> $ env CXXFLAGS="-static" ./configure --enable-static --disable-shared
>> $ make
>>
>> Usually that should spit out a static binary, but 'radosgw' is still
>> dynamic.
>>
>
> I suspect it's because you did not --with-radosgw and it was not
> recompiled.

Nope, I did a 'make clean' first.

Tried it just for the sake of it:
$ CXXFLAGS="-static" ./configure --enable-static --disable-shared 
--with-radosgw
$ make
$ file src/radosgw

"src/radosgw: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), 
dynamically linked (uses shared libs),"

>
> Cheers
>
>> I'm not such a autoconf nor automake guru, so does anybody ever build
>> static binaries with Ceph?
>>
>> Yes, I'm aware they can become very large, but that's not my concern
>> right now. I just want to upload a binary to a machine, run it and see
>> if it does what I'm hoping it does and not having to worry about all
>> the dependencies being there and being the right version.
>>
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
