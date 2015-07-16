From: Andrew Woodward <xarses@gmail.com>
Subject: Re: CephX key/secret generation
Date: Thu, 16 Jul 2015 10:56:44 -0700
Message-ID: <CACEfbZhZC9A4E746w6tH6kVDY6Fdj5_CQtGLhPSLuTv1GDuW3A@mail.gmail.com>
References: <CACEfbZhXSNp0_WxyX2mwSeg2rdEdYSfVbGDZsrHKqPvAGa7oBQ@mail.gmail.com>
	<alpine.DEB.2.00.1507160745010.8878@cobra.newdream.net>
	<3500AC92-FA9E-4E99-B09F-F052FFA2833A@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35571 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbbGPR4p convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jul 2015 13:56:45 -0400
Received: by igcqs7 with SMTP id qs7so19830650igc.0
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2015 10:56:45 -0700 (PDT)
In-Reply-To: <3500AC92-FA9E-4E99-B09F-F052FFA2833A@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <seb@redhat.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,

Thanks this is exactly what I was looking for.

On Thu, Jul 16, 2015 at 8:32 AM, Sebastien Han <seb@redhat.com> wrote:
> Awesome I=E2=80=99ve been looking for something similar for ceph-ansi=
ble too :)
>
>> On 16 Jul 2015, at 16:46, Sage Weil <sage@newdream.net> wrote:
>>
>> Hi Andrew,
>>
>> On Wed, 15 Jul 2015, Andrew Woodward wrote:
>>> Hi, I'm looking for help understanding how the cephx auth keys are
>>> generated. I want to pre-create the keys for the cluster within my
>>> deployment engine. It appears that we can use `ceph-athtool
>>> --gen-print-key` in order to generate the keys and use them, howeve=
r
>>> the application runs inside a container and it seems silly to 150mb=
 of
>>> deps to get access to ceph-authtool.
>>>
>>> Looking through the code at a basic level, I see that it's calling
>>> some AES functions, however it quickly goes over my ability to read=
 C.
>>>
>>> Can some one go over the key construction requirements? Can we use =
any
>>> string encoded with base64? Is the AES encoding needed? What is the
>>> correct formula for the AES generation? It looks like the have the
>>> same seed but I'm having problems reading it out of the code.
>>
>> Here's a bit of python to do it:
>>
>>       https://github.com/ceph/ceph-deploy/blob/master/ceph_deploy/ne=
w.py#L21
>>
>> Hope that helps!
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Cheers.
> =E2=80=93=E2=80=93=E2=80=93=E2=80=93
> S=C3=A9bastien Han
> Senior Cloud Architect
>
> "Always give 100%. Unless you're giving blood."
>
> Mail: seb@redhat.com
> Address: 11 bis, rue Roqu=C3=A9pine - 75008 Paris
>



--=20
Andrew
Mirantis
=46uel community ambassador
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
