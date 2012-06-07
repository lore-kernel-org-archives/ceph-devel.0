From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Thu, 7 Jun 2012 15:53:18 -0600
Message-ID: <CALFpzo6sPgf+iK_1asQM0zW_mmmoW0yMjWC8PCc7=qCH=BVdYg@mail.gmail.com>
References: <21601270.dfB0BsVfyn@pc10>
	<47203FB1-758C-46E9-A49A-6F9896B663DC@profihost.ag>
	<3039502.NLSCFOhhFU@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54438 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933058Ab2FGVxU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 17:53:20 -0400
Received: by eaak11 with SMTP id k11so537312eaa.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 14:53:18 -0700 (PDT)
In-Reply-To: <3039502.NLSCFOhhFU@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Maybe I did something wrong with your iotester, but I had to mkdir
=2E/iotest to get it to run. I straced and found that it died on 'no
such file'.

On Thu, Jun 7, 2012 at 12:37 PM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Am Donnerstag, 7. Juni 2012, 20:18:52 schrieb Stefan Priebe:
>> I think the test script would help a lot so others can test too.
>
> Okay, I've attached the program. It's barely 2 KB. You need Boost 1.4=
5+, CMake
> 2.6+ and Crypto++ to compile it.
>
> Warning: This will fill up your harddisk completely, which is not a g=
ood idea
> on in-production machines.
>
> =A0 =A0 =A0 =A0Guido
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
