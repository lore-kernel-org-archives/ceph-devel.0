From: Junwang Zhao <zhjwpku@gmail.com>
Subject: Re: Has http://ceph.com/docs problems?
Date: Mon, 2 Jan 2017 18:30:05 +0800
Message-ID: <CAEG8a3LSyzvMRj_1-b5Pnqvn_mkOgG2M65Q8Ztg+VFeONOzE-g@mail.gmail.com>
References: <CACKY0b96L31_L=KugUYQwdfU2CSkD167fgU5N495rpye1Toj3A@mail.gmail.com>
 <CACKY0b-Fr3X8jmbCD_J=Kat0+jfqi0SnuhD5t+Lx6V5Jq69QvQ@mail.gmail.com>
 <9D8A2486E35F0941A60430473E29F15BCED3E76B@MXDB2.ad.garvan.unsw.edu.au> <CACKY0b_y2uFb0JHLPPhMd1kLx+9G0yXdXqw2QPsAi+LLZ8uVqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:35465 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932074AbdABKaG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jan 2017 05:30:06 -0500
Received: by mail-ua0-f182.google.com with SMTP id v2so123358744uac.2
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jan 2017 02:30:06 -0800 (PST)
In-Reply-To: <CACKY0b_y2uFb0JHLPPhMd1kLx+9G0yXdXqw2QPsAi+LLZ8uVqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: Manuel Sopena Ballesteros <manuel.sb@garvan.org.au>, ceph-devel <ceph-devel@vger.kernel.org>

If you in hurry, you can build it on your machine and start a server
by yourself, AFAIK, all the documents are in the git repo.

run:
admin/build_doc
admin/serve_doc

after this, you may access the document on <ip>:8080

Your should run this on ubuntu, if you use Centos, you may got some
problem(no ditaa package available and maybe libxml2-devel?).

On Mon, Jan 2, 2017 at 2:10 PM, liuchang0812 <liuchang0812@gmail.com> wrote=
:
> still down.
>
>
>
> 2017-01-01 14:25 GMT+08:00 Manuel Sopena Ballesteros <manuel.sb@garvan.or=
g.au>:
>> Yes has been down for a few hours now
>>
>> Manuel
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ker=
nel.org] On Behalf Of liuchang0812
>> Sent: Sunday, January 1, 2017 5:24 PM
>> To: ceph-devel
>> Subject: Re: Has http://ceph.com/docs problems?
>>
>> I have tried with both my PC and a DigitalOcean VPS. Doc website down de=
finitely.
>>
>> *   Trying 208.113.135.117...
>> * connect to 208.113.135.117 port 80 failed: Connection timed out
>> * Failed to connect to docs.ceph.com port 80: Connection timed out
>> * Closing connection 0
>> curl: (7) Failed to connect to docs.ceph.com port 80: Connection timed o=
ut
>>
>> 2017-01-01 14:11 GMT+08:00 liuchang0812 <liuchang0812@gmail.com>:
>>> I can't open http://ceph.com/docs, i seems that website is down.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in=
 the body of a message to majordomo@vger.kernel.org More majordomo info at =
 http://vger.kernel.org/majordomo-info.html
>> NOTICE
>> Please consider the environment before printing this email. This message=
 and any attachments are intended for the addressee named and may contain l=
egally privileged/confidential/copyright information. If you are not the in=
tended recipient, you should not read, use, disclose, copy or distribute th=
is communication. If you have received this message in error please notify =
us at once by return email and then delete both messages. We accept no liab=
ility for the distribution of viruses or similar in electronic communicatio=
ns. This notice should not be removed.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
