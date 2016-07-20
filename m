From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: LDAP/KRB5 authentication mode
Date: Tue, 19 Jul 2016 17:54:09 -0700
Message-ID: <CAJ4mKGaT-cq4PLw_3Y1dxhFrq_6nodPV0SrEoZ3mTiPxxVcHnw@mail.gmail.com>
References: <1468529466.6657.27.camel@suse.com> <1468949911.6841.7.camel@suse.com>
 <1582725052.22664551.1468957627218.JavaMail.zimbra@redhat.com>
 <CAJ4mKGatunAOk4oBanXUMcAgZTYU7L8S5e2Uzc8nsNmiOajS8g@mail.gmail.com>
 <CAF-wwdHAZPzL0ghvbYO330LWFq973P7we-gWOrLfvXhmWEM-_Q@mail.gmail.com>
 <CAJ4mKGZqEeaYn-9uWJUH3qEV0mhcnuryFeX5nV4=kV4j=qLbjQ@mail.gmail.com> <20160720005109.GA16113@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35517 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcGTAyL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2016 20:54:11 -0400
Received: by mail-vk0-f45.google.com with SMTP id w127so48315852vkh.2
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2016 17:54:10 -0700 (PDT)
In-Reply-To: <20160720005109.GA16113@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Daniel Oliveira <doliveira@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Tue, Jul 19, 2016 at 5:51 PM, Brad Hubbard <bhubbard@redhat.com> wro=
te:
> On Tue, Jul 19, 2016 at 05:41:20PM -0700, Gregory Farnum wrote:
>> On Tue, Jul 19, 2016 at 5:28 PM, Brad Hubbard <bhubbard@redhat.com> =
wrote:
>> > On Wed, Jul 20, 2016 at 6:34 AM, Gregory Farnum <gfarnum@redhat.co=
m> wrote:
>> >> On Tue, Jul 19, 2016 at 12:47 PM, Matt Benjamin <mbenjamin@redhat=
=2Ecom> wrote:
>> >>> Hi Daniel,
>> >>>
>> >>> Sorry you haven't gotten a response.  There is work ongoing in t=
he RGW standup related to using LDAP and krb5 (via STS) authentication =
systems in -RGW-.  Please consider coming to an RGW standup to sync up =
and discuss (though some details like design writeups of course come to=
 this list).
>> >>>
>> >>> If your interest is in general ceph and ceph messaging, I defer =
to others and other discussion--e.g., Msgr2.
>> >>
>> >> Yeah, I don't think any work has been done on integrating Kerbero=
s
>> >> into the monitor for log-in and getting ceph tickets etc yet. :(
>> >> -Greg
>> >
>> > I believe Daniel is referring to Msgr2 here.
>> >
>> > Who's the best contact for auth integration work in regards to Msg=
r2?
>>
>> There are msgr2 features designed to support this, but it's mostly t=
he
>> same thing. Or at least, you certainly aren't going to be checking
>> external-server kerberos tickets every time a client connects to an
>> OSD =E2=80=94 if you're running a kerberos server, that client will
>> authenticate on the monitor via kerberos, and then the monitor will
>> give it a ceph-specific thing for connecting to other servers. :)
>>
>> Anyway, even if they weren't, I don't think any real work's been don=
e
>> beyond speccing out the protocol.
>
> Perhaps a little background is in order heere.
>
> Recently Daniel approached Kefu and myself on IRC having just complet=
ed a
> project and looking for his next task. Since he had history working i=
n the
> Identity Management space we suggested that leveraging his existing t=
alents in
> that area may be a good idea and suggested he send an email to the li=
st
> sounding out the best people to talk to in regard to that area.
>
> If we have no projects currently that relate to IDM with work under w=
ay then I
> guess Daniel will need to look in another area?

Unless he wants to drive the monitor integration? It's not really my
charge, but obviously we have discussed it several times so there's
some guidance available. (Sage and Matt, probably.)

Otherwise, yeah, better find a project that has actual development and
not just design work going on so far. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
