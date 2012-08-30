From: Gregory Farnum <greg@inktank.com>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 13:54:51 -0700
Message-ID: <CAPYLRzhWpA93_Tvo7kP63wHbNJkWuZNX1CytrrbQzHEG3+yO9w@mail.gmail.com>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
	<alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net>
	<CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com>
	<CAPYLRzhh4390wjuZkEuEqs0=3SBX729kEou5NkqmVbBaJWG_rQ@mail.gmail.com>
	<CAPrxi5_G1cQ9XK9dnOP0Sgda_PYNQmj9TyqdO7D+Y7TXoYvuOQ@mail.gmail.com>
	<alpine.DEB.2.00.1208301314370.8588@cobra.newdream.net>
	<CAPrxi58oZZ25BmcftEz+TgnHy70dPsHhivuFtXd6KkkF7NG8LQ@mail.gmail.com>
	<alpine.DEB.2.00.1208301339120.11149@cobra.newdream.net>
	<20120830204619.GB11711@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46309 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2H3Uyw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 16:54:52 -0400
Received: by ieje11 with SMTP id e11so1118441iej.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 13:54:52 -0700 (PDT)
In-Reply-To: <20120830204619.GB11711@splice>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Ryan <mike.ryan@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

No, Sage's one-liner should definitely handle it. We were just waiting
for the monclient to tick before requesting updated subs.

My question is how that changed =97 have mounts always taken ~3 seconds
to go through and we just didn't notice, or did we change how the
monclient handles subscription requests and didn't consider the
implications?
-Greg

On Thu, Aug 30, 2012 at 1:46 PM, Mike Ryan <mike.ryan@inktank.com> wrot=
e:
> This smells like it might be a DNS misconfiguration. Make sure you've
> got entries in your hosts files for whatever machines are involved.
>
> On Thu, Aug 30, 2012 at 01:39:36PM -0700, Sage Weil wrote:
>> What about this:
>>
>> diff --git a/src/client/Client.cc b/src/client/Client.cc
>> index 3333966..003e3f8 100644
>> --- a/src/client/Client.cc
>> +++ b/src/client/Client.cc
>> @@ -294,6 +294,7 @@ int Client::init()
>>    monclient->set_want_keys(CEPH_ENTITY_TYPE_MDS | CEPH_ENTITY_TYPE_=
OSD);
>>    monclient->sub_want("mdsmap", 0, 0);
>>    monclient->sub_want("osdmap", 0, CEPH_SUBSCRIBE_ONETIME);
>> +  monclient->renew_subs();
>>
>>    // logger
>>    PerfCountersBuilder plb(cct, "client", l_c_first, l_c_last);
>>
>>
>> If that doesn't do it, can you reproduce with 'debug client =3D 20' =
and
>> 'debug monc =3D 20'?
>>
>> Thanks!
>> sage
>>
>>
>>
>> On Thu, 30 Aug 2012, Noah Watkins wrote:
>>
>> > Here ya go:
>> >
>> > https://dl.dropbox.com/u/7899675/client.log
>> > https://dl.dropbox.com/u/7899675/mds.a.log
>> > https://dl.dropbox.com/u/7899675/mds.b.log
>> > https://dl.dropbox.com/u/7899675/mds.c.log
>> >
>> > - Noah
>> >
>> > On Thu, Aug 30, 2012 at 1:15 PM, Sage Weil <sage@inktank.com> wrot=
e:
>> > > I see that Server::handle_client_session is calling mdlog->flush=
(), so
>> > > it's a bit odd.  Can you generate a log with 'debug ms =3D 1' on=
 the client
>> > > (and maybe mds) side?
>> > >
>> > > s
>> > >
>> > > On Thu, 30 Aug 2012, Noah Watkins wrote:
>> > >
>> > >> On Thu, Aug 30, 2012 at 1:06 PM, Gregory Farnum <greg@inktank.c=
om> wrote:
>> > >> > On Thu, Aug 30, 2012 at 12:55 PM, Noah Watkins <jayhawk@cs.uc=
sc.edu> wrote:
>> > >> >> Using a tick interval of 1 drops the cost down to 3 seconds,=
 but still
>> > >> >> a long time for running many unit tests that use fresh mount=
s.
>> > >> >
>> > >> > Are you using ceph-fuse or the kernel client? And how many of=
 each daemon type?
>> > >>
>> > >> I'm using the C api, and there are 3 mon, 3 mds, 1 osd.
>> > >>
>> > >> > That said; I'm seeing broadly similar numbers ? with one of e=
ach
>> > >> > daemon (but otherwise the vstart defaults) "time sudo ceph-fu=
se mnt"
>> > >> > reports 3.1 seconds.
>> > >>
>> > >>
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
