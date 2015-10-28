From: Samuel Just <sjust@redhat.com>
Subject: Re: PG: all requests stuck when acting set < min_size
Date: Wed, 28 Oct 2015 10:13:53 -0700
Message-ID: <CAN=+7FUZqBo_v-9fJD4JuMJy1nFAuk2Ln7hcezJZjAu=fPWvxQ@mail.gmail.com>
References: <BLU175-W31BC44F9AFEBFB5588D05CDF220@phx.gbl>
	<CAJ4mKGYFiLaEkqTpVnc75pSE6L9YtO1=35HOr6xxMHAYaEEYwQ@mail.gmail.com>
	<CAN=+7FWZ_fm=UjkfmabMsmULLMTSFUqoQvnDCtp5UhYuW1YYDA@mail.gmail.com>
	<629790552.47803809.1445991565199.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33269 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbbJ1RNy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 13:13:54 -0400
Received: by iodd200 with SMTP id d200so17827068iod.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Oct 2015 10:13:53 -0700 (PDT)
In-Reply-To: <629790552.47803809.1445991565199.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, GuangYang <yguang11@outlook.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's actually worse for an ec pool.  EC pools need to be able to roll
back divergent entries in order to keep the durability requirements
implied by min_size.  If you have 10 data blocks and 4 parity blocks
with min_size set to 12, then one would expect that as long as one can
recover any 12 shards, you can always recover the pg regardless of
intermediate pg degradation states.  However, if we accept a read with
only 10 replicas, the most recent log entries cannot ever be
considered divergent and we might become unable to recover without
exactly those 10 osds if the other 4 happened to not have committed
those updates.
-Sam

On Tue, Oct 27, 2015 at 5:19 PM, Brad Hubbard <bhubbard@redhat.com> wro=
te:
> ----- Original Message -----
>> From: "Samuel Just" <sjust@redhat.com>
>> To: "Gregory Farnum" <gfarnum@redhat.com>
>> Cc: "GuangYang" <yguang11@outlook.com>, ceph-devel@vger.kernel.org
>> Sent: Wednesday, 28 October, 2015 7:05:42 AM
>> Subject: Re: PG: all requests stuck when acting set < min_size
>>
>> Actually, we really can't accept reads below min_size and still keep
>> the properties we want it to have.  Suppose we have 3 osds (a, b, an=
d
>> c) which see writes 0...1000.  min_size is 2.  If a and b are then
>> powered off only having committed up to 900 (therefore the client
>> could only have seen up to 900 commit), then c would be able to serv=
e
>> reads based on updates up to 1000 with a and b stopped (no way to kn=
ow
>> a and b only committed to 900).  If c then stops and a and b are
>> restarted, they would begin serving reads and writes only based on
>> commits up to 900 even though we would have exposed the writes up to
>> 1000 to the client.
>
> If a and/or b then accept a write you have a recipe for split-brain a=
nd no one
> wants to see that in Ceph.
>
> Cheers,
> Brad
>
>> -Sam
>>
>> On Tue, Oct 27, 2015 at 12:47 PM, Gregory Farnum <gfarnum@redhat.com=
> wrote:
>> > On Tue, Oct 27, 2015 at 11:47 AM, GuangYang <yguang11@outlook.com>=
 wrote:
>> >> Hi there,
>> >> Is there any reason we stuck read only requests as well for a PG =
when the
>> >> acting set size is less than min_size?
>> >
>> > A few.
>> > The most important reason: PGs don't have any concept of a read-on=
ly
>> > mode in the code. They are "active" or not, and an active PG handl=
es
>> > writes. (The full flags and other things which block writes but al=
low
>> > reads are at the OSD level, not the PG level, and are handled when=
 ops
>> > come in before they reach the PG.) Allowing read requests against =
a PG
>> > to complete even when we aren't taking writes on a per-PG level wo=
uld
>> > take some doing.
>> > Also: it would be weird from several different levels. We'd need t=
o
>> > keep track of client streams because we wouldn't want to let throu=
gh a
>> > read that is ordered after a write. How would we handle the memory
>> > pressure implied by that? While I can imagine it being useful for =
some
>> > stuff like RGW reads, in general making data available for read bu=
t
>> > not write is a pretty complicated thing to explain to users =E2=80=
=94 how do
>> > we expose that in a useful way?
>> > -Greg
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
