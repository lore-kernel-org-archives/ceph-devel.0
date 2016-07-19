From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: LDAP/KRB5 authentication mode
Date: Tue, 19 Jul 2016 13:34:58 -0700
Message-ID: <CAJ4mKGatunAOk4oBanXUMcAgZTYU7L8S5e2Uzc8nsNmiOajS8g@mail.gmail.com>
References: <1468529466.6657.27.camel@suse.com> <1468949911.6841.7.camel@suse.com>
 <1582725052.22664551.1468957627218.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35963 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbcGSUe7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2016 16:34:59 -0400
Received: by mail-vk0-f47.google.com with SMTP id g1so28730362vkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2016 13:34:59 -0700 (PDT)
In-Reply-To: <1582725052.22664551.1468957627218.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Daniel Oliveira <doliveira@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Tue, Jul 19, 2016 at 12:47 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> Hi Daniel,
>
> Sorry you haven't gotten a response.  There is work ongoing in the RGW standup related to using LDAP and krb5 (via STS) authentication systems in -RGW-.  Please consider coming to an RGW standup to sync up and discuss (though some details like design writeups of course come to this list).
>
> If your interest is in general ceph and ceph messaging, I defer to others and other discussion--e.g., Msgr2.

Yeah, I don't think any work has been done on integrating Kerberos
into the monitor for log-in and getting ceph tickets etc yet. :(
-Greg

>
> Regards,
>
> Matt
>
> ----- Original Message -----
>> From: "Daniel Oliveira" <doliveira@suse.com>
>> To: ceph-devel@vger.kernel.org
>> Cc: sweil@redhat.com
>> Sent: Tuesday, July 19, 2016 1:38:31 PM
>> Subject: Re: LDAP/KRB5 authentication mode
>>
>> Hi Team,
>>
>> I haven't heard anything back on this, so just wondering if we know who
>> is working on this part of the project so we could help out?!
>>
>> Thanks,
>> -Daniel
>>
>>
>> On Thu, 2016-07-14 at 14:51 -0600, Daniel Oliveira wrote:
>> > Hi,
>> >
>> > I've talking to Kefu/Badone about the work in question and would like
>> > to help with that.
>> >
>> > Please, who should I talk to in order to understand where we are at
>> > and then start working on it?
>> >
>> > Thanks,
>> > -Daniel
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
