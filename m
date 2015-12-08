From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Tue, 8 Dec 2015 16:59:26 +0100
Message-ID: <5666FE5E.6090908@digiware.nl>
References: <CAOtMX2j5xJBnYoNdxTGGQFz-fTVX2xQka2NuyUZuOPpsft6HuA@mail.gmail.com>
 <alpine.DEB.2.00.1512011034550.19170@cobra.newdream.net>
 <565DEA60.7010608@digiware.nl>
 <CAAM7YAmzq3a_kqXE2ZgK_fp4i6QduY49aXqiWVNK3F59iZUFRA@mail.gmail.com>
 <565F5A03.7020401@digiware.nl>
 <CAAM7YA=Q6gbBbN92a9KigAXw4e_SrshQ6Q8mC1Xff+vxQQkrKw@mail.gmail.com>
 <5661DBB8.1040505@digiware.nl>
 <CAJ4mKGZ+wjum+R3=pBS8urko4D1B_D+eKjytWE_uDdFcGW6sSA@mail.gmail.com>
 <5661F358.2060401@digiware.nl> <5666AB1D.5010101@digiware.nl>
 <20151208123656.GA22774@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:61781 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756147AbbLHP7p (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Dec 2015 10:59:45 -0500
In-Reply-To: <20151208123656.GA22774@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, "Yan, Zheng" <ukernel@gmail.com>, Sage Weil <sage@newdream.net>, Alan Somers <asomers@freebsd.org>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 8-12-2015 13:36, Mykola Golub wrote:
> On Tue, Dec 08, 2015 at 11:04:13AM +0100, Willem Jan Withagen wrote:
>> On 4-12-2015 21:11, Willem Jan Withagen wrote:
>>
>> One larger problem with libraries I have is the stuff with dlopen.
>>
>> In ./configure it seems that most of the code is short-circuited, and -ldl
>> gets appended in the Makefile.am's by default. The code there is rather hard
>> to parse.
>>
>> FreeBSD has this in libc, so no specific includes needed.
>>
>> Now the question is how do I cleanly fix this without breaking just
>> about every other platform?
>
> Could you provide particular examples? Because what I see in the
> master is usually like below:
>
> if LINUX
> xio_server_LDADD += -ldl
> endif
>
> If you see somewhere -ldl is added unconditionally it is likely to
> have to be fixed the same way.

Several of the test makefiles did not have this.
For this I've patched at least:
src/tools/Makefile-server.am
src/tracing/Makefile.am
src/erasure-code/Makefile.am
src/rgw/Makefile.am

And this is indeed what I've added ATM to get my tests compiled.
But I really wonder if this is the way to go, instead of fixing it
in configure and be done with it. Just like wiht most of the other
libraries that are setup thru automake/configure. That would also
help other ports,  then for that port one does not have to augment
again all locations.

AND if new tests would be written, we do not have to check if all
exempts are correctly covered.

--WjW
