From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: RGW: Implement S3 storage class feature
Date: Wed, 21 Jun 2017 10:46:55 -0400
Message-ID: <b2db655b-eec8-aeb3-3428-1f12d1c28796@redhat.com>
References: <CAF8OO3Mo3xFbxioTedym+rByF1Eu3kNhHayn9mx1V6N5h-LWbQ@mail.gmail.com>
 <2035535832.26037779.1498053843582.JavaMail.zimbra@redhat.com>
Reply-To: dang@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35081 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbdFUOq6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jun 2017 10:46:58 -0400
Received: by mail-qk0-f174.google.com with SMTP id a199so84191457qkb.2
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jun 2017 07:46:57 -0700 (PDT)
In-Reply-To: <2035535832.26037779.1498053843582.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>, Jiaying Ren <mikulely@gmail.com>
Cc: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 06/21/2017 10:04 AM, Matt Benjamin wrote:
> Hi,
>
> Looks very coherent.
>
> My main question is about...
>
> ----- Original Message -----
>> From: "Jiaying Ren" <mikulely@gmail.com>
>> To: "Yehuda Sadeh-Weinraub" <ysadehwe@redhat.com>
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Sent: Wednesday, June 21, 2017 7:39:24 AM
>> Subject: RGW: Implement S3 storage class feature
>>
>
>>
>> * Todo List
>>
>> + the head of rgw-object should only contains the metadata of
>>   rgw-object,the first chunk of rgw-object data should be stored in
>>   the same pool as the tail of rgw-object
>
> Is this always desirable?
>

Well, unless the head pool happens to have the correct storage class, 
it's necessary.  And I'd guess that verification of this is complicated, 
although maybe not.

Maybe we can use the head pool if it has >= the correct storage class?

Daniel

