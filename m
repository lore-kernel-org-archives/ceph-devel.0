From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: FW: Ceph dmClock
Date: Wed, 7 Dec 2016 11:48:31 -0700
Message-ID: <CAANLjFpyperAkB62s5G7bYMm2J8Z-SOu1S8imT2-QHq+AiVKaQ@mail.gmail.com>
References: <116d5b63f1dc428998675dbe6e8c56eb@skt-tnetpmx1.SKT.AD>
 <38265764-574c-368c-6427-23330ac5dc66@redhat.com> <df8d1c8d93754dbcb30a01e4e6b00129@skt-tnetpmx1.SKT.AD>
 <0e9bcc68-cf57-ca5c-a0b9-26c635b78a59@redhat.com> <3f6258a2100e4218a15023b82b9a156a@skt-tnetpmx1.SKT.AD>
 <e3321edabb3d42f2881c3e1ca30ad5b2@skt-tnetpmx1.SKT.AD> <CAKk8r1BnqHJt-EtP+9xBUE=oA8taO9ak+CdJk6BrjdhzHT3Ukw@mail.gmail.com>
 <d3e52b41-47b9-c660-1c96-6383609719ca@redhat.com> <CAKk8r1BadDo7KCVL0eA09TBxYLTXmtHLqzH=Tc6m8zZAVebFfw@mail.gmail.com>
 <CAKk8r1Dw1MACKhOUfyhzv5dQX5Ae+9S1B9T99qXUOGmQ4HyzWA@mail.gmail.com> <e2b99c22-ad7c-d0ae-6f9d-63c8d0322f20@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36436 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932520AbcLGSsd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2016 13:48:33 -0500
Received: by mail-oi0-f50.google.com with SMTP id v84so426363893oie.3
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2016 10:48:32 -0800 (PST)
In-Reply-To: <e2b99c22-ad7c-d0ae-6f9d-63c8d0322f20@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>
Cc: Byung Su Park <pbs1108@gmail.com>, =?UTF-8?B?67CV67OR7IiY?= <bspark8@sk.com>, =?UTF-8?B?6rmA7YOc7JuFL1NEUyBUZWNoLiBMYWI=?= <taewoong.kim@sk.com>, =?UTF-8?B?7JeE7KO86rSAL1NEUyBUZWNoLiBMYWI=?= <jugwan.eom@sk.com>, =?UTF-8?B?6rmA7Iq566+8L1NEUyBUZWNoLiBMYWI=?= <seungminkim@sk.com>, Sage Weil <sweil@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 29, 2016 at 11:59 AM, J. Eric Ivancich <ivancich@redhat.com> wr=
ote:
> On 11/27/2016 04:50 AM, Byung Su Park wrote:
>> P4
>> : To see current QoS quality between clients in the Ceph cluster with
>> the pool (LibRADOS) unit based mclock operation queue, we did some tests=
.
>> Although each the client=E2=80=99s moment IO variation was present, unde=
r some
>> test conditions, a satisfactory QoS result came out in terms of the
>> average value.
>> (Note that, currently the some IO variation also appears at the default
>> WPQ operation queue).
>> (Also, additional experimentation and analysis is required with various
>> test conditions and issues).
>> The specific test environment and result are attached in additional pdf
>> file.
>
> The results look very impressive. I've seen the IO variation in my tests
> as well, and it seems unlikely to be due to operation queuing.

If you have not also set "osd_op_queue_cut_off =3D low" in addition to
"osd_op_queue =3D wpq", then you should see much better variation in op
latency between clients. There seems to be an issue with snapshots and
cut_off low at the moment, so use caution with snapshots. [1] I can't
pull up the tracker at the moment to know that status.

[1] http://tracker.ceph.com/issues/15774

----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
