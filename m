From: zengran zhang <z13121369189@gmail.com>
Subject: Re: ec performance in small random io testing
Date: Sat, 22 Jul 2017 09:14:54 +0800
Message-ID: <CALi+v1_b_YgekDC-QiUGJ9jXuWS=92ZBMeeOVHrPEDrrwcVU-Q@mail.gmail.com>
References: <CALi+v18oLKMLcJWBG2BD2K7UzxTpZnYgf255BXUYv3Xr-RO-Hw@mail.gmail.com>
 <0fa30405-8944-3711-49ca-581adee08f98@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:37851 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdGVBOz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jul 2017 21:14:55 -0400
Received: by mail-io0-f174.google.com with SMTP id c74so27858708iod.4
        for <ceph-devel@vger.kernel.org>; Fri, 21 Jul 2017 18:14:55 -0700 (PDT)
In-Reply-To: <0fa30405-8944-3711-49ca-581adee08f98@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Mark:

We are using bluestore. I want to explain, consider the 4M range of an
object never be written,if the firsr write is 4K and it fall on the 3M
offset, EC will append it to offset 0.so 4K amplify to 3M+4K.if second
4K write fall on the 2M,  it will need rmw and clone=EF=BC=8Cthis should al=
so
be an overhead...

2017=E5=B9=B47=E6=9C=8822=E6=97=A5=E6=98=9F=E6=9C=9F=E5=85=AD=EF=BC=8CMark =
Nelson <mnelson@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> Out of curiosity where you using filestore or bluestore?
>
> Mark
>
> On 07/21/2017 04:26 AM, zengran zhang wrote:
>>
>> Hi :
>>
>>    we found that the ec pool's iops is low in 4K randwrite test, I
>> think its because the append op will amplify most random small io, and
>> next small write on pending area will cause rmw and clone range...
>>
>>     could we change the `append` to `write`, and change the `truncate`
>> to `unmap` when rollback?
>>
>>     now the write io fall on one object will splite into one append
>> plus one overwrite at most, if we change to write+overwrite, write may
>> splite into many writes and overwrites that depending on how much
>> holes on the write range..
>>
>>     now the UNMAP is not yet implemented=EF=BC=8Cwant to know wether it =
is hard to do?
>>
>>     thanks and regards!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
