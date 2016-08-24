From: Casey Bodley <cbodley@redhat.com>
Subject: Re: assert
Date: Wed, 24 Aug 2016 12:17:49 -0400
Message-ID: <e27ed37d-be2c-47d1-587f-91735e42ab15@redhat.com>
References: <alpine.DEB.2.11.1606271610170.2844@piezo.us.to>
 <CALe9h7f+fCv73Si_1RoF7bQsSz24cWU0f7V2_rGE-nbzMWVjLA@mail.gmail.com>
 <alpine.DEB.2.11.1606271642550.2844@piezo.us.to>
 <120706851.74131386.1472049260388.JavaMail.zimbra@redhat.com>
 <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35122 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754872AbcHXQRv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 12:17:51 -0400
Received: by mail-yw0-f170.google.com with SMTP id j12so12959952ywb.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 09:17:51 -0700 (PDT)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id z193sm5731254ywa.34.2016.08.24.09.17.49
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 09:17:49 -0700 (PDT)
In-Reply-To: <20160824154557.GA22386@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


On 08/24/2016 11:45 AM, Adam C. Emerson wrote:
> On 24/08/2016, Matt Benjamin wrote:
>> Mark Nelson called attention to this topic again yesterday in #ceph-devel.
>>
>> We favor retaining the ability to re-declare specific asserts such that they are, as with assert in general historically, compiled out.  I think it's reasonable if this is a marked case.
>>
>> That seems to imply that if ceph_assert is the unmarked case, it won't be compiled out, so is essentially ceph_assert_always, as below (or else that form should be used...it's a little long).
> If we want to go for brevity, we could have ceph_assert() be the
> unmarked case that functions just like assert macro.
>
> Then we could use something like ceph_demand() (ceph_ultimatum?
> ceph_blackmail?) to indicate the case that isn't compiled out.
>
> Personally, I would just like to get rid of Ceph's assert.h and its
> unending war with every other header file in the world. At one point
> killed off the header and linked in an object that overrode
> __assert_fail. This worked very well, though it would require handling
> every C library implementation we're compiled against.
>

I dug up an old commit as an example of overriding libc's 
__assert_fail() function, which would allow us to use the system's 
assert.h as is: 
https://github.com/cohortfsllc/cohortfs-ceph/commit/40956ad3661192462246ed7e5435522c5708ffbc
