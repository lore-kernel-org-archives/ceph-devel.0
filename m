From: Gregory Farnum <greg@inktank.com>
Subject: Re: CephFS mount delay
Date: Thu, 30 Aug 2012 15:17:58 -0700
Message-ID: <CAPYLRzh6G+H1bA_G4GoSKxrZPt4wPxcDtih1W1xt2thCXTvuvg@mail.gmail.com>
References: <CAPrxi5_g2Nfa4AHAUkCx4LRybtDfKqwQuAH7ziVizmgq5oTJwg@mail.gmail.com>
	<alpine.DEB.2.00.1208301233260.8588@cobra.newdream.net>
	<CAPrxi59tZRzv4KG=_U375Vqg7tb5h3nLe6za0L0_B17V5mGw=w@mail.gmail.com>
	<CAPYLRzhh4390wjuZkEuEqs0=3SBX729kEou5NkqmVbBaJWG_rQ@mail.gmail.com>
	<CAPrxi5_G1cQ9XK9dnOP0Sgda_PYNQmj9TyqdO7D+Y7TXoYvuOQ@mail.gmail.com>
	<alpine.DEB.2.00.1208301314370.8588@cobra.newdream.net>
	<CAPrxi58oZZ25BmcftEz+TgnHy70dPsHhivuFtXd6KkkF7NG8LQ@mail.gmail.com>
	<alpine.DEB.2.00.1208301339120.11149@cobra.newdream.net>
	<CAPrxi58zJQx4ersx2sQ=e0N9U1hxk5cKZmqBW1f9fONd-W-ToQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61593 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab2H3WR6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 18:17:58 -0400
Received: by mail-iy0-f174.google.com with SMTP id k25so261630iah.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 15:17:58 -0700 (PDT)
In-Reply-To: <CAPrxi58zJQx4ersx2sQ=e0N9U1hxk5cKZmqBW1f9fONd-W-ToQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 30, 2012 at 3:10 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wro=
te:
> Ok, this patch sorta solves the problem. After a fresh restart of the
> daemons, the client hangs indefinitely (log urls attached for this
> case). If I kill the client and restart, I get a behavior similar to
> the original problem. Another client restart and everything is very
> fast. This easily reproducible.

I'm not quite sure what scenario you're describing here =97 let's see i=
f
I understand correctly:
1) Working cluster.
2) Restart server daemons.
3) Client just hangs. :(
4) Restart client and it goes slow through the mount (once?).
5) Restart client again and everything goes fast from then on.

Is that right? If it is, 3 might be caused by a client bug, but then 4
(and also maybe 3) is probably just caused by the MDS server going
through reconnect and timing out its client connection.


> https://dl.dropbox.com/u/7899675/client.log
> https://dl.dropbox.com/u/7899675/mds.a.log
> https://dl.dropbox.com/u/7899675/mds.b.log
> https://dl.dropbox.com/u/7899675/mds.c.log
>
> - Noah
>
> On Thu, Aug 30, 2012 at 1:39 PM, Sage Weil <sage@inktank.com> wrote:
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
>>> Here ya go:
>>>
>>> https://dl.dropbox.com/u/7899675/client.log
>>> https://dl.dropbox.com/u/7899675/mds.a.log
>>> https://dl.dropbox.com/u/7899675/mds.b.log
>>> https://dl.dropbox.com/u/7899675/mds.c.log
>>>
>>> - Noah
>>>
>>> On Thu, Aug 30, 2012 at 1:15 PM, Sage Weil <sage@inktank.com> wrote=
:
>>> > I see that Server::handle_client_session is calling mdlog->flush(=
), so
>>> > it's a bit odd.  Can you generate a log with 'debug ms =3D 1' on =
the client
>>> > (and maybe mds) side?
>>> >
>>> > s
>>> >
>>> > On Thu, 30 Aug 2012, Noah Watkins wrote:
>>> >
>>> >> On Thu, Aug 30, 2012 at 1:06 PM, Gregory Farnum <greg@inktank.co=
m> wrote:
>>> >> > On Thu, Aug 30, 2012 at 12:55 PM, Noah Watkins <jayhawk@cs.ucs=
c.edu> wrote:
>>> >> >> Using a tick interval of 1 drops the cost down to 3 seconds, =
but still
>>> >> >> a long time for running many unit tests that use fresh mounts=
=2E
>>> >> >
>>> >> > Are you using ceph-fuse or the kernel client? And how many of =
each daemon type?
>>> >>
>>> >> I'm using the C api, and there are 3 mon, 3 mds, 1 osd.
>>> >>
>>> >> > That said; I'm seeing broadly similar numbers ? with one of ea=
ch
>>> >> > daemon (but otherwise the vstart defaults) "time sudo ceph-fus=
e mnt"
>>> >> > reports 3.1 seconds.
>>> >>
>>> >>
>>>
>>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
