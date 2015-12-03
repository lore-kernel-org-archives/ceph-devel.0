From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Compiling for FreeBSD, runtimes for seperate tests.
Date: Thu, 3 Dec 2015 13:06:31 -0800
Message-ID: <CAJ4mKGaMWy-_JALeYKAXf3rJim_7e5KPG+ivZC5rEtq2aK+GOg@mail.gmail.com>
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
	<565DEC36.10102@digiware.nl>
	<565F5E28.8020706@digiware.nl>
	<5660106F.90202@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36193 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbbLCVGc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 16:06:32 -0500
Received: by wmww144 with SMTP id w144so38023256wmw.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 13:06:31 -0800 (PST)
In-Reply-To: <5660106F.90202@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 3, 2015 at 1:50 AM, Willem Jan Withagen <wjw@digiware.nl> w=
rote:
> On 2-12-2015 22:10, Willem Jan Withagen wrote:
>
>> Running gmake check
>
>
> Now I start wondering how long certain tests are able to run:
>
> I've killed:
>          unittest_chain_xattr
> because it was running already voor 12 hours.
>
> And unittest_lfnindex is also running for > 20 minutes....

Well, 12 hours is ludicrous, but a few of the tests really do take 20
minutes =E2=80=94 I think the shec EC one? I don't have any better info=
 than
that for you, though. I mostly just wait on the gitbuilders.
-Greg


>
> Is there a way to specify something like a max runtime for these test=
s?
> So that I am able to run the testset repeatedly, to monitor regressio=
n
> once I start changing code.
>
> I saw Loic talk about some of the expected test runtimes.
> But having a better feeling per specific test would be useful in gett=
ing
> the test to progress
>
> Thanx,
> --WjW
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
