From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: LDAP/KRB5 authentication mode
Date: Wed, 20 Jul 2016 10:28:47 +1000
Message-ID: <CAF-wwdHAZPzL0ghvbYO330LWFq973P7we-gWOrLfvXhmWEM-_Q@mail.gmail.com>
References: <1468529466.6657.27.camel@suse.com> <1468949911.6841.7.camel@suse.com>
 <1582725052.22664551.1468957627218.JavaMail.zimbra@redhat.com> <CAJ4mKGatunAOk4oBanXUMcAgZTYU7L8S5e2Uzc8nsNmiOajS8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38477 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbcGTA2t convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2016 20:28:49 -0400
Received: by mail-wm0-f41.google.com with SMTP id o80so45863640wme.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2016 17:28:48 -0700 (PDT)
In-Reply-To: <CAJ4mKGatunAOk4oBanXUMcAgZTYU7L8S5e2Uzc8nsNmiOajS8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Daniel Oliveira <doliveira@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Wed, Jul 20, 2016 at 6:34 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Jul 19, 2016 at 12:47 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
>> Hi Daniel,
>>
>> Sorry you haven't gotten a response.  There is work ongoing in the RGW standup related to using LDAP and krb5 (via STS) authentication systems in -RGW-.  Please consider coming to an RGW standup to sync up and discuss (though some details like design writeups of course come to this list).
>>
>> If your interest is in general ceph and ceph messaging, I defer to others and other discussion--e.g., Msgr2.
>
> Yeah, I don't think any work has been done on integrating Kerberos
> into the monitor for log-in and getting ceph tickets etc yet. :(
> -Greg

I believe Daniel is referring to Msgr2 here.

Who's the best contact for auth integration work in regards to Msgr2?

>
>>
>> Regards,
>>
>> Matt
>>
>> ----- Original Message -----
>>> From: "Daniel Oliveira" <doliveira@suse.com>
>>> To: ceph-devel@vger.kernel.org
>>> Cc: sweil@redhat.com
>>> Sent: Tuesday, July 19, 2016 1:38:31 PM
>>> Subject: Re: LDAP/KRB5 authentication mode
>>>
>>> Hi Team,
>>>
>>> I haven't heard anything back on this, so just wondering if we know who
>>> is working on this part of the project so we could help out?!
>>>
>>> Thanks,
>>> -Daniel
>>>
>>>
>>> On Thu, 2016-07-14 at 14:51 -0600, Daniel Oliveira wrote:
>>> > Hi,
>>> >
>>> > I've talking to Kefu/Badone about the work in question and would like
>>> > to help with that.
>>> >
>>> > Please, who should I talk to in order to understand where we are at
>>> > and then start working on it?
>>> >
>>> > Thanks,
>>> > -Daniel
>>> >
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Matt Benjamin
>> Red Hat, Inc.
>> 315 West Huron Street, Suite 140A
>> Ann Arbor, Michigan 48103
>>
>> http://www.redhat.com/en/technologies/storage
>>
>> tel.  734-707-0660
>> fax.  734-769-8938
>> cel.  734-216-5309
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
