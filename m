From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Compiling for FreeBSD
Date: Fri, 4 Dec 2015 10:44:21 -0800
Message-ID: <CAJ4mKGZ+wjum+R3=pBS8urko4D1B_D+eKjytWE_uDdFcGW6sSA@mail.gmail.com>
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
	<565DC9D4.7060701@digiware.nl>
	<CAOtMX2jWDOLqmjY=S9PorKeaHDgTx5WyMo8jiV3LxOS4K67dMg@mail.gmail.com>
	<565DE234.6070505@digiware.nl>
	<CAOtMX2j5xJBnYoNdxTGGQFz-fTVX2xQka2NuyUZuOPpsft6HuA@mail.gmail.com>
	<alpine.DEB.2.00.1512011034550.19170@cobra.newdream.net>
	<565DEA60.7010608@digiware.nl>
	<CAAM7YAmzq3a_kqXE2ZgK_fp4i6QduY49aXqiWVNK3F59iZUFRA@mail.gmail.com>
	<565F5A03.7020401@digiware.nl>
	<CAAM7YA=Q6gbBbN92a9KigAXw4e_SrshQ6Q8mC1Xff+vxQQkrKw@mail.gmail.com>
	<5661DBB8.1040505@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36465 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbLDSoX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Dec 2015 13:44:23 -0500
Received: by wmww144 with SMTP id w144so73183383wmw.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Dec 2015 10:44:22 -0800 (PST)
In-Reply-To: <5661DBB8.1040505@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Sage Weil <sage@newdream.net>, Alan Somers <asomers@freebsd.org>, Mykola Golub <mgolub@mirantis.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Dec 4, 2015 at 10:30 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 3-12-2015 01:27, Yan, Zheng wrote:
>> On Thu, Dec 3, 2015 at 4:52 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> On 2-12-2015 15:13, Yan, Zheng wrote:
>
>>> I see that you have disabled uuid?
>>> Might I ask why?
>>
>> not disable. Currently ceph uses boost uuid implementation. so no need
>> to link to libuuid.
>
> And
>
>>>>>> The uuid transition to boost::uuid has happened since then (a few months
>>>>>> back) and I believe Rohan's AIX and Solaris ports for librados (that just
>>>>>> merged) included a fix for the sockaddr_storage issue:
>
> I cannot seem to find the package or port that defines boost::uuid.
> So how did you make it available to the build system?

http://www.boost.org/doc/libs/1_59_0/libs/uuid/

It's part of the boost labyrinth. I think in Debian it's just part of
libboost-dev, but you might need to dig around in whatever packaging
you're using for FreeBSD.
-Greg
