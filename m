From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: rbd top
Date: Mon, 15 Jun 2015 10:28:05 -0600
Message-ID: <CAANLjFojBWBCgZ5Sw8psX-7EysFxVz-yMGM4y7jNKWZWu+uR6g@mail.gmail.com>
References: <CAANLjFp4+tkSj5=we88nGDFh0NtmX4jYc+sE__1N8L_4X30dfw@mail.gmail.com>
	<CAC6JEv8qB6xStrp1EL+gyDWAzVo91DvtDQKyMs9VDB2KtoVR6A@mail.gmail.com>
	<alpine.DEB.2.00.1506150647030.18741@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36111 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbbFOQ2H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jun 2015 12:28:07 -0400
Received: by wigg3 with SMTP id g3so83344908wig.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jun 2015 09:28:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1506150647030.18741@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Mon, Jun 15, 2015 at 7:52 AM, Sage Weil  wrote:
> On Mon, 15 Jun 2015, Gregory Farnum wrote:
>> On Thu, Jun 11, 2015 at 12:33 PM, Robert LeBlanc  wrote:
>> > -----BEGIN PGP SIGNED MESSAGE-----
>> > Hash: SHA256
>> >
>> > One feature we would like is an "rbd top" command that would be like
>> > top, but show usage of RBD volumes so that we can quickly identify
>> > high demand RBDs.
>> >
>> > Since I haven't done any programming for Ceph, I'm trying to think
>> > through the best way to approach this. I don't know if there are
>> > already perf counters that I can query that are at the client, RBD or
>> > the Rados layers. If these counters don't exist would it be best to
>> > implement them at the client layer and look for watchers on the RBD
>> > and query them? Is it better to handle it at the Rados layer and
>> > aggregate the I/O from all chunks? Of course this would need to scale
>> > out very large.
>> >
>> > It seems that if the client running rbd top requests the top 'X'
>> > number of objects from each OSD, then it would cut down on the data
>> > that the has to be moved around and processed. It wouldn't be an
>> > extremely accurate view, but might be enough.
>> >
>> > What are your thoughts?
>> >
>> > Also, what is the best way to get into the Ceph code? I've looked at
>> > several things and I find myself doing a lot of searching to find
>> > connecting pieces. My primary focus is not programming so picking up a
>> > new code base takes me a long time because I don't know many of the
>> > tricks that help people get to speed quickly.
>>
>> The basic problem with a tool like this is that it requires gathering
>> real-time data from either all the OSDs, or all the clients. We do
>> something similar in order to display approximate IO going through the
>> system as a whole, but that is based on PGStat messages which come in
>> periodically and is both laggy and an approximation.
>>
>> To do this, we'd need to get less-laggy data, and instead of scaling
>> with the number of OSDs/PGs it would scale with the number of RBD
>> volumes. You certainly couldn't send that through the monitor and I
>> shudder to think about the extra load it would invoke at all layers.
>>
>> How up-to-date do you need the info to be, and how accurate? Does it
>> need to be queryable in the future or only online? You could perhaps
>> hook into one of the more precise HitSet implementations we
>> have...otherwise I think you'd need to add an online querying
>> framework, perhaps through the perfcounters (which...might scale to
>> something like this?) or a monitoring service (hopefully attached to
>> Calamari) that receives continuous updates.
>
> I seem to remember having a short conversation about something like this a
> few CDS's back... although I think it was 'rados top'.  IIRC the basic
> idea we had was for each OSD to track it's top clients (using some
> approximate LRU type algorithm) and then either feed this relatively small
> amount of info (say, top 10-100 clients) back to the mon for summation,
> or dump via the admin socket for calamari to aggregate.

This was mostly the idea I had in mind. Would it be better to track
objects ore clients. I could think of reasons for either  (objects
would give an idea of stress of the OSDs, clients could give an idea
of clients misbehaving in a shared object/RBD). I was thinking of
something like the admin socket,  but something the client could query
to keep the load off the monitor. However, with multiple clients
having the monitor aggregate the data would reduce the load cluster
wide. I guess the big question would be what is the impact.

> This doesn't give you the rbd image name, but I bet we could infer that
> without too much trouble (e.g., include a recent object or two with the
> client).  Or, just assume that client id is enough (it'll include an IP
> and PID... enough info to find the /var/run/ceph admin socket or the VM
> process.

I thought it was easy to back reference the RBD from the object
because the object has a prefix from the RBD. Am I over simplifying
here or missing something?

> If we were going to do top clients, I think it'd make sense to also have a
> top objects list as well, so you can see what the hottest objects in the
> cluster are.

This makes a lot of sense, it wouldn't be much extra work.

As to Greg's question, I think providing real time days would be too
expensive. What kind of delay do you think would be a good trade off
between latency and load? Of course the closer to real time the
better.

- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFbBAEBCAAQBQJVfv0RCRDmVDuy+mK58QAApR8P+MMAgsWzJhuP2o3MC98i
3Cr6scpovs0DeHDr+cuoZ9abk6+oThiAYeXaVlVF1RcCX3lPNYRhxlN8rq1n
cS5eITVdDOQbm+CMX1XzI5TlINMl94rcm4yswclBFUxmyh4Q5H2FoOttLfUA
IfeVnIQU695wz9ZNCa5VH5h3DjX6oZ/TxA/YXGOsb0VvquMZZQHRVagm+1Pk
sB0Axqbg9mjZ7k5xXY4nYrsbXWKLOkGjDlPcjYWfsA0wdV6O9cWB+0DaRGWZ
i/RW305ESJrIYPXL8oWwFlx6Y1RxoRlgsnroj2vo16z4IkNyTGYss0krouIv
3wG8c6GQhITtpQjT3MZM/QvMbGT7WTFvNkXWU5/O97XMpou03h/44w4lJSHF
1YmP6Ju6uySnYKHBTU3dmA38QHSXCy2uBjqRCY62C2CCOpNGGlBrGyAoMmyU
cfr6G9eta/DPCm3kyPsZsCXFag9MZi64QkK+Di2sqVA9B5+05bK/DDAw26zJ
YCQxFGhhEmV+mXq2zq6uMSeQgxFsAVHs39CWi+ZCWQBKhSBcfDc66lZlNzQK
EFtwqWzxXMVJI2boc7OOx8OYeHSXRxhFbvetKzURJXjMZ2ur1In31Y8jWnUK
VnZSL/+GtSaUPtdBB51oapAngvlhk1j6EWOCVFYjftLz5+88Bkhtu4nd1Ef1
0l4=
=CKEr
-----END PGP SIGNATURE-----
