From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Ceph Ansible Repo
Date: Mon, 3 Mar 2014 10:30:05 -0500
Message-ID: <CACkq2mqH07DAbeWWwWFN8mXah=+qqJPgYin4v4zd0xM6TMW7TA@mail.gmail.com>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com>
 <CF393D9A.26D01%ian.colle@inktank.com> <794BD69D-5ED9-4AA9-AE27-A7EBEAF1FCA2@enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:34687 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721AbaCCPaZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 10:30:25 -0500
Received: by mail-qc0-f179.google.com with SMTP id m20so3579543qcx.38
        for <ceph-devel@vger.kernel.org>; Mon, 03 Mar 2014 07:30:25 -0800 (PST)
In-Reply-To: <794BD69D-5ED9-4AA9-AE27-A7EBEAF1FCA2@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: Ian Colle <ian.colle@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>

I had been working on something similar to Seb's.  Alfredo's (which I
had looked at before) seems to be a wrapper around ceph-deploy.
Useful, but not as fully featured.  It also hasn't been updated in 7
months.

I would certainly like to see a more fully-featured set of Ansible
playbooks in Ceph's main GitHub repo.  I think Seb's work here is a
great start!  It's definitely a project I can help contribute to, as
well.

 - Travis

On Mon, Mar 3, 2014 at 3:49 AM, Sebastien Han
<sebastien.han@enovance.com> wrote:
> Ian,
>
> Yes I've seen it, however it only installs Ceph.
>
> Cheers.
> ----
> S=E9bastien Han
> Cloud Engineer
>
> "Always give 100%. Unless you're giving blood."
>
> Phone: +33 (0)1 49 70 99 72
> Mail: sebastien.han@enovance.com
> Address : 11 bis, rue Roqu=E9pine - 75008 Paris
> Web : www.enovance.com - Twitter : @enovance
>
> On 03 Mar 2014, at 03:59, Ian Colle <ian.colle@inktank.com> wrote:
>
>> Sebastien,
>>
>> Have you seen https://github.com/alfredodeza/ceph-ansible ?
>>
>> Ian R. Colle
>> Director of Engineering
>> Inktank
>> Delivering the Future of Storage
>> http://www.linkedin.com/in/ircolle
>> http://www.twitter.com/ircolle
>> Cell: +1.303.601.7713
>> Email: ian@inktank.com
>>
>>
>> On 3/2/14, 4:26 PM, "Sebastien Han" <sebastien.han@enovance.com> wro=
te:
>>
>>> Hi,
>>>
>>> As discussed during the Ceph day, I achieved the Ansible playbook f=
or
>>> Ceph.
>>> It currently lives on my github, but I=B9d like to see it on
>>> github.com/ceph.
>>>
>>> Does anyone can create the corresponding repo so I can send a pull
>>> request?
>>>
>>> Thanks!
>>>
>>>
>>> S=E9bastien Han
>>> Cloud Engineer
>>>
>>> "Always give 100%. Unless you're giving blood.=B2
>>>
>>> Phone: +33 (0)1 49 70 99 72
>>> Mail: sebastien.han@enovance.com
>>> Address : 11 bis, rue Roqu=E9pine - 75008 Paris
>>> Web : www.enovance.com - Twitter : @enovance
>>>
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
