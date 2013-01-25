From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw
Date: Fri, 25 Jan 2013 09:51:42 -0800
Message-ID: <CAC-hyiFdMqboL-bPV-s_ZRLcL=wwiNUM5V_eewxjE3Wg=EOAVg@mail.gmail.com>
References: <CAJH6TXg+7Sp=3_B047OG+KGQK00X5ZtKXAT+UB2KROBDaqVruA@mail.gmail.com>
	<CAC-hyiHsL3j9MviM1B0_hhEkt8GeLjeqbWn-ApE82+M+EQYmUA@mail.gmail.com>
	<CAJH6TXgocN-yWD930i+o80ATLLj5sXo+CcDvE4-JuWses7yPmQ@mail.gmail.com>
	<CAC-hyiFfeZY9ELrwRCkH5roMTjYys=SEN2SRsyLyNvx0zUD5Pw@mail.gmail.com>
	<CAJH6TXgbEfJTAHBZE0GfDbzPH8ys8sFAQLn2+zxfxtLkppvQUA@mail.gmail.com>
	<CAJH6TXh68YA2=Dc86==21LjOtAfiZHSzXRgxMPtepw2TBV_tyQ@mail.gmail.com>
	<CAC-hyiE2i_p3AWA11o8rLRJEXUNyoYmhSri861Sk-M=TeuZXcg@mail.gmail.com>
	<CAJH6TXgYCA4oZXOocTcTC_oZEm=nsV-YB4K9vSW9pN6-32ORdg@mail.gmail.com>
	<CAJVE5RVi_fODAj1Ja2V8iObB4W1Nd=HhwFat23c8fyeo5f1Yyw@mail.gmail.com>
	<CAJH6TXj-4RWMnJKOm5pxjYZkVLaNh9KRR4dOyYu8sJsZOz7jFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:52153 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161Ab3AYRvn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 12:51:43 -0500
Received: by mail-ie0-f180.google.com with SMTP id k11so118650iea.25
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jan 2013 09:51:43 -0800 (PST)
In-Reply-To: <CAJH6TXj-4RWMnJKOm5pxjYZkVLaNh9KRR4dOyYu8sJsZOz7jFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Cesar Mello <cmello@gmail.com>, ceph-devel@vger.kernel.org

On Fri, Jan 25, 2013 at 12:18 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2013/1/25 Cesar Mello <cmello@gmail.com>:
>> Just as a curiosity, I lost some time because I didn't read this:
>>
>> .. important:: Check the key output. Sometimes ``radosgw-admin``
>>    generates a key with an escape (``\``) character, and some clients
>>    do not know how to handle escape characters. Remedies include
>>    removing the escape character (``\``), encapsulating the string
>>    in quotes, or simply regenerating the key and ensuring that it
>>    does not have an escape character.
>
> Is not my case bacause my key is accepted propery (i'm able to list
> and create buckets)
> my issue seems to be related to the header 100-Continue.
> Without
>
> rgw print continue = false
>
> i'm receiving error 500
>
> with
>
> rgw print continue = false
>
> i recieve duplicate header status (and then error 500)

What does your radosgw log show for that request?

Yehuda
