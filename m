From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: LDAP/KRB5 authentication mode
Date: Wed, 20 Jul 2016 10:51:09 +1000
Message-ID: <20160720005109.GA16113@rskikr.localdomain>
References: <1468529466.6657.27.camel@suse.com>
 <1468949911.6841.7.camel@suse.com>
 <1582725052.22664551.1468957627218.JavaMail.zimbra@redhat.com>
 <CAJ4mKGatunAOk4oBanXUMcAgZTYU7L8S5e2Uzc8nsNmiOajS8g@mail.gmail.com>
 <CAF-wwdHAZPzL0ghvbYO330LWFq973P7we-gWOrLfvXhmWEM-_Q@mail.gmail.com>
 <CAJ4mKGZqEeaYn-9uWJUH3qEV0mhcnuryFeX5nV4=kV4j=qLbjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34083 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbcGTAvU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2016 20:51:20 -0400
Received: by mail-pf0-f169.google.com with SMTP id p64so12726822pfb.1
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2016 17:51:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGZqEeaYn-9uWJUH3qEV0mhcnuryFeX5nV4=kV4j=qLbjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Daniel Oliveira <doliveira@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Tue, Jul 19, 2016 at 05:41:20PM -0700, Gregory Farnum wrote:
> On Tue, Jul 19, 2016 at 5:28 PM, Brad Hubbard <bhubbard@redhat.com> w=
rote:
> > On Wed, Jul 20, 2016 at 6:34 AM, Gregory Farnum <gfarnum@redhat.com=
> wrote:
> >> On Tue, Jul 19, 2016 at 12:47 PM, Matt Benjamin <mbenjamin@redhat.=
com> wrote:
> >>> Hi Daniel,
> >>>
> >>> Sorry you haven't gotten a response.  There is work ongoing in th=
e RGW standup related to using LDAP and krb5 (via STS) authentication s=
ystems in -RGW-.  Please consider coming to an RGW standup to sync up a=
nd discuss (though some details like design writeups of course come to =
this list).
> >>>
> >>> If your interest is in general ceph and ceph messaging, I defer t=
o others and other discussion--e.g., Msgr2.
> >>
> >> Yeah, I don't think any work has been done on integrating Kerberos
> >> into the monitor for log-in and getting ceph tickets etc yet. :(
> >> -Greg
> >
> > I believe Daniel is referring to Msgr2 here.
> >
> > Who's the best contact for auth integration work in regards to Msgr=
2?
>=20
> There are msgr2 features designed to support this, but it's mostly th=
e
> same thing. Or at least, you certainly aren't going to be checking
> external-server kerberos tickets every time a client connects to an
> OSD =E2=80=94 if you're running a kerberos server, that client will
> authenticate on the monitor via kerberos, and then the monitor will
> give it a ceph-specific thing for connecting to other servers. :)
>=20
> Anyway, even if they weren't, I don't think any real work's been done
> beyond speccing out the protocol.

Perhaps a little background is in order heere.

Recently Daniel approached Kefu and myself on IRC having just completed=
 a
project and looking for his next task. Since he had history working in =
the
Identity Management space we suggested that leveraging his existing tal=
ents in
that area may be a good idea and suggested he send an email to the list
sounding out the best people to talk to in regard to that area.

If we have no projects currently that relate to IDM with work under way=
 then I
guess Daniel will need to look in another area?


> -Greg

--=20
Cheers,
Brad
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
