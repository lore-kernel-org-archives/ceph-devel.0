From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Extra daemons/servers reporting to mgr
Date: Mon, 12 Jun 2017 16:24:42 -0400
Message-ID: <6ee9f6a1-eed5-75b8-2bb5-e1dcaaf3a678@redhat.com>
References: <CALe9h7eT+7KUt7VZPaYfR49FEPP3mJbe2+ARK82BaZUMmStchw@mail.gmail.com>
 <73f90019-71aa-2cf1-92e8-0ba7087d62a4@redhat.com>
 <1396097469.22206951.1497297793862.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33768 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdFLUYp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jun 2017 16:24:45 -0400
Received: by mail-yw0-f176.google.com with SMTP id 63so41069799ywr.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 13:24:45 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id r28sm7328442qki.53.2017.06.12.13.24.43
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2017 13:24:43 -0700 (PDT)
In-Reply-To: <1396097469.22206951.1497297793862.JavaMail.zimbra@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Just that it could obviate the need to expose and support it as a public 
librados api.


On 06/12/2017 04:03 PM, Matt Benjamin wrote:
> I agree, though I'm unsure how much this matters either way?
>
> Matt
>
> ----- Original Message -----
>
>> Hi John,
>>
>> Is there a reason that radosgw can't instantiate its own MgrClient
>> instance and report status through that, instead of having to go through
>> librados? If we have to report an entity instance, we could choose from
>> one of our Rados clients.
>>
>> Casey
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

