From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: cephfs performance
Date: Thu, 2 Nov 2017 18:33:31 +0800
Message-ID: <CAAM7YAk5c66OxvM-BULXC_0FN0X7L8YnuznfR_C5cvwgDBweLA@mail.gmail.com>
References: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
 <CA+2bHPYe+krYUmrdQ58=TAJJ6UAODw36gx2_Qzv8wxnhnYn_rA@mail.gmail.com>
 <CAB7xdi=C8fPuKy=R9xd4weykpDPsgvfnXcMZkvB+YNaaX1oJ8A@mail.gmail.com>
 <CA+2bHPbbFttvv2Ci6W59g-raZqVCDaZgrQ-BPpYQvs_0XTcdNA@mail.gmail.com>
 <CAB7xdin_PNRCCqf1nO0LVb4P8fUXMJqwBqXHavrQU_VVi6SuNg@mail.gmail.com>
 <CA+2bHPbSeg0t4M41XL+rdjuT2fmz8WnU1N_G0N5a2zhNNqOSng@mail.gmail.com>
 <CAB7xdikWd6nuUJy96BQJogTohWzZBotsy+OF7jrgVip7AqEMpw@mail.gmail.com>
 <CA+2bHPZC2eQ=dS4v1ECQUEu+WWv7eRrAeCFbf4smbBD+nbmeDA@mail.gmail.com> <67B12E11-4188-4A38-B54F-1D8E47A91CED@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:45341 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbdKBKdc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Nov 2017 06:33:32 -0400
Received: by mail-ot0-f179.google.com with SMTP id q99so1085452ota.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Nov 2017 03:33:32 -0700 (PDT)
In-Reply-To: <67B12E11-4188-4A38-B54F-1D8E47A91CED@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 2, 2017 at 5:48 PM, =E9=99=B6=E5=86=AC=E5=86=AC <tdd21151186@gm=
ail.com> wrote:
> Hi Patrick,
>
> sorry to dig out this old email.
> you said two clients may write same file at same time only if no any clie=
nts got =E2=80=9Cbuffer/cache=E2=80=9D capability.
> here my question is:
> the two client would got two different =E2=80=9Cmtime=E2=80=9D of that in=
ode, since they can make =E2=80=9CFw=E2=80=9D cap dirty.
> how would mds behave when the two client flushes the dirty caps?
>

when handling caps flush for multiple client,  mds never set mtime of
inode back to an old time



> Regards,
> Dongdong
>
>
>> =E5=9C=A8 2017=E5=B9=B47=E6=9C=8822=E6=97=A5=EF=BC=8C=E4=B8=8A=E5=8D=882=
:55=EF=BC=8CPatrick Donnelly <pdonnell@redhat.com> =E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> Hi Sheng,
>>
>> Sorry I misspoke in my previous email. The clients may all have the
>> capability to read and write but none of them will be able to
>> **cache** reads/writes or **buffer** writes. They rely on synchronous
>> read/write with the OSDs for consistency/atomicity.
>>
>> On Fri, Jul 21, 2017 at 9:19 AM, sheng qiu <herbert1984106@gmail.com> wr=
ote:
>>> so when multiple write clients or a mix of read and write clients
>>> accessing same file, the previous cached data of this file on all
>>> clients will be revoked.
>>
>> Yes.
>>
>>> And the following multi-clients' write or mixed read and write
>>> accessing to that file will become synchronous.
>>
>> Writes/reads are become synchronous, yes.
>>
>>> On Tue, Jul 18, 2017 at 9:41 AM, Patrick Donnelly <pdonnell@redhat.com>=
 wrote:
>>>> On Tue, Jul 18, 2017 at 9:17 AM, sheng qiu <herbert1984106@gmail.com> =
wrote:
>>>>> Hi Patrick,
>>>>>
>>>>> thanks for your quick response.
>>>>> just one concern, if disable direct I/O, multiple clients access same
>>>>> file via different mount point on different machines, will it cause
>>>>> data inconsistency?
>>>>
>>>> No, but you'll still effectively have synchronous I/O because only one
>>>> writer will have write capabilities from the MDS.
>>>>
>>>> --
>>>> Patrick Donnelly
>>
>>
>>
>> --
>> Patrick Donnelly
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
