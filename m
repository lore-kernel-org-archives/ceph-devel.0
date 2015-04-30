From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CephFS + Erasure coding
Date: Thu, 30 Apr 2015 14:20:50 -0700
Message-ID: <CAC6JEv-pqbJ3JzV4MayJPF=1TAgVs0pm1=FxHvpScX2UsH4Otw@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD83D5B@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34999 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbbD3VUv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Apr 2015 17:20:51 -0400
Received: by iejt8 with SMTP id t8so77926035iej.2
        for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2015 14:20:51 -0700 (PDT)
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com. [209.85.223.172])
        by mx.google.com with ESMTPSA id p8sm1752705iga.13.2015.04.30.14.20.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 14:20:50 -0700 (PDT)
Received: by iecrt8 with SMTP id rt8so77812391iec.0
        for <ceph-devel@vger.kernel.org>; Thu, 30 Apr 2015 14:20:50 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD83D5B@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Apr 30, 2015 at 1:55 PM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:
> Hi Greg,
> Forgive my ignorance on this part if it is already discussed in the c=
ommunity. Could you please let me know if CephFS is supporting Erasure =
coded pool in the backend or not ?
> If not, is there any plan of supporting this kind of configuration in=
 near future ?

You can set replicated cache pools, positioned as tiers over an EC
pool, as data pools for CephFS. You cannot use EC pools directly for
CephFS. We have no plans to add support for EC pools in the
foreseeable future =E2=80=94 since they have limited RADOS functionalit=
y we'd
need to implement a whole log-structured file storage system or
something. :(
-Greg

>
> Thanks & Regards
> Somnath
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
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
