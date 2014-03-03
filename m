From: Ian Colle <ian.colle@inktank.com>
Subject: Re: Ceph Ansible Repo
Date: Mon, 03 Mar 2014 10:13:29 -0700
Message-ID: <CF3A0606.26F5F%ian.colle@inktank.com>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com>
 <CF393D9A.26D01%ian.colle@inktank.com>
 <794BD69D-5ED9-4AA9-AE27-A7EBEAF1FCA2@enovance.com>
 <CACkq2mqH07DAbeWWwWFN8mXah=+qqJPgYin4v4zd0xM6TMW7TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1254
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:43204 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbaCCRNp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 12:13:45 -0500
Received: by mail-ig0-f171.google.com with SMTP id hl1so5683805igb.4
        for <ceph-devel@vger.kernel.org>; Mon, 03 Mar 2014 09:13:44 -0800 (PST)
In-Reply-To: <CACkq2mqH07DAbeWWwWFN8mXah=+qqJPgYin4v4zd0xM6TMW7TA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>, Sebastien Han <sebastien.han@enovance.com>, Alfredo Deza <alfredo.deza@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>

Gents,

Enjoy. Ready for PR=92s.

https://github.com/ceph/ceph-ansible


Ian R. Colle
Director of Engineering
Inktank
Delivering the Future of Storage
http://www.linkedin.com/in/ircolle
http://www.twitter.com/ircolle
Cell: +1.303.601.7713
Email: ian@inktank.com


On 3/3/14, 8:30 AM, "Travis Rhoden" <trhoden@gmail.com> wrote:

>I had been working on something similar to Seb's.  Alfredo's (which I
>had looked at before) seems to be a wrapper around ceph-deploy.
>Useful, but not as fully featured.  It also hasn't been updated in 7
>months.
>
>I would certainly like to see a more fully-featured set of Ansible
>playbooks in Ceph's main GitHub repo.  I think Seb's work here is a
>great start!  It's definitely a project I can help contribute to, as
>well.
>
> - Travis
>
>On Mon, Mar 3, 2014 at 3:49 AM, Sebastien Han
><sebastien.han@enovance.com> wrote:
>> Ian,
>>
>> Yes I've seen it, however it only installs Ceph.
>>
>> Cheers.
>> ----
>> S=E9bastien Han
>> Cloud Engineer
>>
>> "Always give 100%. Unless you're giving blood."
>>
>> Phone: +33 (0)1 49 70 99 72
>> Mail: sebastien.han@enovance.com
>> Address : 11 bis, rue Roqu=E9pine - 75008 Paris
>> Web : www.enovance.com - Twitter : @enovance
>>
>> On 03 Mar 2014, at 03:59, Ian Colle <ian.colle@inktank.com> wrote:
>>
>>> Sebastien,
>>>
>>> Have you seen https://github.com/alfredodeza/ceph-ansible ?
>>>
>>> Ian R. Colle
>>> Director of Engineering
>>> Inktank
>>> Delivering the Future of Storage
>>> http://www.linkedin.com/in/ircolle
>>> http://www.twitter.com/ircolle
>>> Cell: +1.303.601.7713
>>> Email: ian@inktank.com
>>>
>>>
>>> On 3/2/14, 4:26 PM, "Sebastien Han" <sebastien.han@enovance.com> wr=
ote:
>>>
>>>> Hi,
>>>>
>>>> As discussed during the Ceph day, I achieved the Ansible playbook =
for
>>>> Ceph.
>>>> It currently lives on my github, but I=B9d like to see it on
>>>> github.com/ceph.
>>>>
>>>> Does anyone can create the corresponding repo so I can send a pull
>>>> request?
>>>>
>>>> Thanks!
>>>>
>>>>
>>>> S=E9bastien Han
>>>> Cloud Engineer
>>>>
>>>> "Always give 100%. Unless you're giving blood.=B2
>>>>
>>>> Phone: +33 (0)1 49 70 99 72
>>>> Mail: sebastien.han@enovance.com
>>>> Address : 11 bis, rue Roqu=E9pine - 75008 Paris
>>>> Web : www.enovance.com - Twitter : @enovance
>>>>
>>>
>>>
>>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
