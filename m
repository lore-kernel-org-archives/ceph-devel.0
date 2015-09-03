From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [ceph-deploy] Ambiguous Debug Message
Date: Thu, 3 Sep 2015 08:10:15 -0400
Message-ID: <CAC-Np1ynRiXSRNrNdpRwCiL5kAbkdZoAqFV-593XgeFJm531EQ@mail.gmail.com>
References: <1772331860.11320004.1441150585905.JavaMail.zimbra@redhat.com>
	<1765197817.11321874.1441151309841.JavaMail.zimbra@redhat.com>
	<CAC-Np1wp0R4Z26JnpEi6S8N6AWXQS-J+FNBZbCNzYUgxUDnbfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35937 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbbICMKR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 08:10:17 -0400
Received: by wibz8 with SMTP id z8so96598394wib.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Sep 2015 05:10:16 -0700 (PDT)
In-Reply-To: <CAC-Np1wp0R4Z26JnpEi6S8N6AWXQS-J+FNBZbCNzYUgxUDnbfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shinobu Kinjo <skinjo@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Sep 3, 2015 at 8:04 AM, Alfredo Deza <adeza@redhat.com> wrote:
>
>
> On Tue, Sep 1, 2015 at 7:48 PM, Shinobu Kinjo <skinjo@redhat.com> wrote:
>>
>> Hi,
>>
>> When I ran:
>>
>>     $ sudo ./ceph-deploy --username ceph install ceph01
>>
>> I ended up with:
>>
>>     [ceph_deploy][ERROR ] RuntimeError: connecting to host: ceph@ceph01
>> resulted in errors: HostNotFound ceph@ceph01
>
>
 This is a problem from the underlying library that ceph-deploy uses that
 treats the inability to connect to a host as a "HostNotFound" error
 which may not be correct.

 I opened an issue to follow up on this:
 https://bitbucket.org/hpk42/execnet/issues/48/hostnotfound-is-raised-when-ssh-reports-a

 But in the meantime, I think that ceph-deploy could report that it couldn't
 connect and suggest that the user should try to
 SSH directly to the host. Would that be an acceptable report? (given that we
 don't have access to what SSH returned as the error message)
>
>>
>>
>> That's fine. I need to do something.
>> But actual reason of failure was:
>>
>>     Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
>>
>> I think we should change such an ambiguous [ERROR ] message
>> to more reasonable one so that nobody doesn't confuse any
>> hostname configuration?
>>
>> Thought?
>>
>> -
>> $ ./ceph-deploy --version
>> 1.5.27
>>
>> Shinobu
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
