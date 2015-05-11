From: Gregory Farnum <greg@gregs42.com>
Subject: Re: rados bench single instance vs. multiple instances
Date: Mon, 11 May 2015 10:27:02 -0700
Message-ID: <CAC6JEv-K_WXKj7LG41CNrNOnY77CWRWs-sb_gZ3Abh8gFvy3nw@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com>
	<alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
	<BC97738F8E7C8742BABED7F06FB9DF9166440A10@SATLEXDAG01.amd.com>
	<CAC6JEv-M+JdR3CdqCaZchWtkrg7ou_k4gDXdPnR9jmJfe9DfzA@mail.gmail.com>
	<BC97738F8E7C8742BABED7F06FB9DF9166440A3B@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35764 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbEKR1D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 13:27:03 -0400
Received: by ieczm2 with SMTP id zm2so113805504iec.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 10:27:03 -0700 (PDT)
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com. [209.85.213.181])
        by mx.google.com with ESMTPSA id o9sm10113364ioe.35.2015.05.11.10.27.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 10:27:02 -0700 (PDT)
Received: by iget9 with SMTP id t9so76852987ige.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 10:27:02 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166440A3B@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, May 11, 2015 at 10:25 AM, Deneau, Tom <tom.deneau@amd.com> wrot=
e:
>
>
>> -----Original Message-----
>> From: Gregory Farnum [mailto:greg@gregs42.com]
>> Sent: Monday, May 11, 2015 12:18 PM
>> To: Deneau, Tom
>> Cc: Sage Weil; ceph-devel
>> Subject: Re: rados bench single instance vs. multiple instances
>>
>> On Mon, May 11, 2015 at 10:15 AM, Deneau, Tom <tom.deneau@amd.com> w=
rote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: Sage Weil [mailto:sage@newdream.net]
>> >> Sent: Monday, May 11, 2015 12:04 PM
>> >> To: Deneau, Tom
>> >> Cc: ceph-devel
>> >> Subject: Re: rados bench single instance vs. multiple instances
>> >>
>> >> On Mon, 11 May 2015, Deneau, Tom wrote:
>> >> > I have noticed the following while running rados bench seq read
>> >> > tests with a 40M object size
>> >> >
>> >> >     single rados bench, 4 concurrent ops,                     b=
andwidth
>> =3D
>> >> 190 MB/s
>> >> >     4 copies of rados bench, 1 concurrent op each,  aggregate
>> >> > bandwidth =3D 310 MB/s
>> >> >
>> >> > and in fact the single rados bench seems limited to 190, no mat=
ter
>> >> > how many
>> >> concurrent ops.
>> >> >
>> >> > I don't see this kind of behavior with a 4M object size.
>> >> >
>> >> > (The above are with caches dropped on the osd targets)
>> >> >
>> >> > It doesn't seem to be related to the total number of bytes bein=
g
>> >> > processed by the single because if I don't drop the caches, bot=
h
>> >> > the single rados bench and the 4-copy rados bench get much high=
er
>> >> > numbers
>> >> > (600 vs. 900) but still the single rados bench appears limited,=
 no
>> >> > matter
>> >> how many concurrent ops are used.
>> >> >
>> >> > Is there kind of throttling going on by design here?
>> >>
>> >> It might be the librados throttles:
>> >>
>> >> OPTION(objecter_inflight_op_bytes, OPT_U64, 1024*1024*100) // max
>> >> in-flight data (both directions)
>> >> OPTION(objecter_inflight_ops, OPT_U64, 1024)               // max=
 in-
>> flight
>> >> ios
>> >>
>> >> IIRC these only affect librados.. which would include 'rados benc=
h'.
>> >>
>> >> sage
>> >>
>> >
>> > I noticed those, and tried setting them higher but it didn't seem =
to have
>> an effect.
>> > But maybe I didn't change it correctly.
>> >
>> > What I did:
>> >    * stop all osds
>> >    * add the following lines to ceph.conf
>> >      [osd]
>> >         objecter_inflight_op_bytes =3D 1048576000
>>
>> This is a client-side configuration, so putting it in the OSD sectio=
n won't
>> have any effect.
>>
>> Do note that even without this, having 1x4 requests outstanding is n=
ot quite
>> the same as having 4x1 requests outstanding =E2=80=94 a single clien=
t only gets one
>> thread to communicate with each OSD, so the cluster has a bit less
>> parallelism when outstanding requests map to the same OSD.
>> But I don't think that should be too obvious at this point.
>> -Greg
>>
>
> OK, on the client side, I just put it in the [global] section.
> That seemed to do the trick.
>
> (I assume nothing else needs to be done for the client side).
>
> What was the reason for this limit?
> Should I expect any undesirable side effects from changing this value=
?

The limit is there to prevent undue memory usage by the Ceph clients;
it's just a feedback throttle for anybody putting in data. If you've
got the memory to allow increased usage, there's no downside.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
