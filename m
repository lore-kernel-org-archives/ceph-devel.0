From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Thu, 7 Jun 2012 23:54:04 +0400
Message-ID: <CABYiri_BOv8NoTKTuHWyZMS4nA0oc3RH4XjdFqzF_i58X8xVRA@mail.gmail.com>
References: <21601270.dfB0BsVfyn@pc10> <47203FB1-758C-46E9-A49A-6F9896B663DC@profihost.ag>
 <3039502.NLSCFOhhFU@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63415 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112Ab2FGTy0 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jun 2012 15:54:26 -0400
Received: by lahd3 with SMTP id d3so716920lah.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 12:54:25 -0700 (PDT)
In-Reply-To: <3039502.NLSCFOhhFU@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

Hmm, can`t reproduce that(phew!). Qemu-1.1-release, 0.47.2, guest/host
mainly debian wheezy. Only one main difference with my setup from
yours is a underlying fs - I`m tired of btrfs unpredictable load
issues and moved back to xfs.

BTW you calculate sha1 in test suite, not sha256 as you mentioned above=
=2E

On Thu, Jun 7, 2012 at 10:37 PM, Guido Winkelmann
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
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Guido
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
