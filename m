From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: LDAP/KRB5 authentication mode
Date: Tue, 19 Jul 2016 17:41:20 -0700
Message-ID: <CAJ4mKGZqEeaYn-9uWJUH3qEV0mhcnuryFeX5nV4=kV4j=qLbjQ@mail.gmail.com>
References: <1468529466.6657.27.camel@suse.com> <1468949911.6841.7.camel@suse.com>
 <1582725052.22664551.1468957627218.JavaMail.zimbra@redhat.com>
 <CAJ4mKGatunAOk4oBanXUMcAgZTYU7L8S5e2Uzc8nsNmiOajS8g@mail.gmail.com> <CAF-wwdHAZPzL0ghvbYO330LWFq973P7we-gWOrLfvXhmWEM-_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35379 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbcGTAlV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2016 20:41:21 -0400
Received: by mail-vk0-f52.google.com with SMTP id w127so48030239vkh.2
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2016 17:41:21 -0700 (PDT)
In-Reply-To: <CAF-wwdHAZPzL0ghvbYO330LWFq973P7we-gWOrLfvXhmWEM-_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Daniel Oliveira <doliveira@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Tue, Jul 19, 2016 at 5:28 PM, Brad Hubbard <bhubbard@redhat.com> wro=
te:
> On Wed, Jul 20, 2016 at 6:34 AM, Gregory Farnum <gfarnum@redhat.com> =
wrote:
>> On Tue, Jul 19, 2016 at 12:47 PM, Matt Benjamin <mbenjamin@redhat.co=
m> wrote:
>>> Hi Daniel,
>>>
>>> Sorry you haven't gotten a response.  There is work ongoing in the =
RGW standup related to using LDAP and krb5 (via STS) authentication sys=
tems in -RGW-.  Please consider coming to an RGW standup to sync up and=
 discuss (though some details like design writeups of course come to th=
is list).
>>>
>>> If your interest is in general ceph and ceph messaging, I defer to =
others and other discussion--e.g., Msgr2.
>>
>> Yeah, I don't think any work has been done on integrating Kerberos
>> into the monitor for log-in and getting ceph tickets etc yet. :(
>> -Greg
>
> I believe Daniel is referring to Msgr2 here.
>
> Who's the best contact for auth integration work in regards to Msgr2?

There are msgr2 features designed to support this, but it's mostly the
same thing. Or at least, you certainly aren't going to be checking
external-server kerberos tickets every time a client connects to an
OSD =E2=80=94 if you're running a kerberos server, that client will
authenticate on the monitor via kerberos, and then the monitor will
give it a ceph-specific thing for connecting to other servers. :)

Anyway, even if they weren't, I don't think any real work's been done
beyond speccing out the protocol.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
