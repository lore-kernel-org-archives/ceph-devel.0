From: Gregory Farnum <greg@gregs42.com>
Subject: Re: rados bench single instance vs. multiple instances
Date: Mon, 11 May 2015 10:18:16 -0700
Message-ID: <CAC6JEv-M+JdR3CdqCaZchWtkrg7ou_k4gDXdPnR9jmJfe9DfzA@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF916643E836@SATLEXDAG01.amd.com>
	<alpine.DEB.2.00.1505111003060.28239@cobra.newdream.net>
	<BC97738F8E7C8742BABED7F06FB9DF9166440A10@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37264 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbbEKRSR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 13:18:17 -0400
Received: by igbsb11 with SMTP id sb11so76919516igb.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 10:18:17 -0700 (PDT)
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com. [209.85.223.169])
        by mx.google.com with ESMTPSA id s85sm10101985ioe.28.2015.05.11.10.18.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2015 10:18:16 -0700 (PDT)
Received: by iedfl3 with SMTP id fl3so127576304ied.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 10:18:16 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9166440A10@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, May 11, 2015 at 10:15 AM, Deneau, Tom <tom.deneau@amd.com> wrot=
e:
>
>
>> -----Original Message-----
>> From: Sage Weil [mailto:sage@newdream.net]
>> Sent: Monday, May 11, 2015 12:04 PM
>> To: Deneau, Tom
>> Cc: ceph-devel
>> Subject: Re: rados bench single instance vs. multiple instances
>>
>> On Mon, 11 May 2015, Deneau, Tom wrote:
>> > I have noticed the following while running rados bench seq read te=
sts
>> > with a 40M object size
>> >
>> >     single rados bench, 4 concurrent ops,                     band=
width =3D
>> 190 MB/s
>> >     4 copies of rados bench, 1 concurrent op each,  aggregate
>> > bandwidth =3D 310 MB/s
>> >
>> > and in fact the single rados bench seems limited to 190, no matter=
 how many
>> concurrent ops.
>> >
>> > I don't see this kind of behavior with a 4M object size.
>> >
>> > (The above are with caches dropped on the osd targets)
>> >
>> > It doesn't seem to be related to the total number of bytes being
>> > processed by the single because if I don't drop the caches, both t=
he
>> > single rados bench and the 4-copy rados bench get much higher numb=
ers
>> > (600 vs. 900) but still the single rados bench appears limited, no=
 matter
>> how many concurrent ops are used.
>> >
>> > Is there kind of throttling going on by design here?
>>
>> It might be the librados throttles:
>>
>> OPTION(objecter_inflight_op_bytes, OPT_U64, 1024*1024*100) // max in=
-flight
>> data (both directions)
>> OPTION(objecter_inflight_ops, OPT_U64, 1024)               // max in=
-flight
>> ios
>>
>> IIRC these only affect librados.. which would include 'rados bench'.
>>
>> sage
>>
>
> I noticed those, and tried setting them higher but it didn't seem to =
have an effect.
> But maybe I didn't change it correctly.
>
> What I did:
>    * stop all osds
>    * add the following lines to ceph.conf
>      [osd]
>         objecter_inflight_op_bytes =3D 1048576000

This is a client-side configuration, so putting it in the OSD section
won't have any effect.

Do note that even without this, having 1x4 requests outstanding is not
quite the same as having 4x1 requests outstanding =E2=80=94 a single cl=
ient
only gets one thread to communicate with each OSD, so the cluster has
a bit less parallelism when outstanding requests map to the same OSD.
But I don't think that should be too obvious at this point.
-Greg

>    * restart all osds
>    * admin-daemon osd config show shows the new value
>    * made sure /etc/ceph/ceph.conf on the client also had those lines=
 added
>       (although I was not sure if that was needed?)
>
> -- Tom
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
