From: Florian Haas <florian@hastexo.com>
Subject: Re: rbd locking and handling broken clients
Date: Thu, 14 Jun 2012 12:37:28 +0200
Message-ID: <CAPUexz9e19dx4AgKm2hqhAu+TB=cF_4AKBd1tyu09s=Lmq9Fug@mail.gmail.com>
References: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
	<4FD8FA13.6070006@hastexo.com>
	<7BD677C5759B4061987311B2526E81D3@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:43360 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab2FNKh3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jun 2012 06:37:29 -0400
Received: by qabj40 with SMTP id j40so2573367qab.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jun 2012 03:37:28 -0700 (PDT)
In-Reply-To: <7BD677C5759B4061987311B2526E81D3@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, mandell@pistoncloud.com, Tommi Virtanen <tv@inktank.com>

On Thu, Jun 14, 2012 at 1:41 AM, Greg Farnum <greg@inktank.com> wrote:
> On Wednesday, June 13, 2012 at 1:37 PM, Florian Haas wrote:
>> Greg,
>>
>> My understanding of Ceph code internals is far too limited to commen=
t on
>> your specific points, but allow me to ask a naive question.
>>
>> Couldn't you be stealing a lot of ideas from SCSI-3 Persistent
>> Reservations? If you had server-side (OSD) persistence of informatio=
n of
>> the "this device is in use by X" type (where anything other than X w=
ould
>> get an I/O error when attempting to access data), and you had a manu=
al,
>> authenticated override akin to SCSI PR preemption, plus key
>> registration/exchange for that authentication, then you would at lea=
st
>> have to have the combination of a misbehaving OSD plus a malicious
>> client for data corruption. A non-malicious but just broken client
>> probably won't do.
>>
>> Clearly I may be totally misguided, as Ceph is fundamentally
>> decentralized and SCSI isn't, but if PR-ish behavior comes even clos=
e to
>> what you're looking for, grabbing those ideas would look better to m=
e
>> than designing your own wheel.
>
> Yeah, the problem here is exactly that Ceph (and RBD) are fundamental=
ly decentralized. :)

True, but as a general comment I do posit that to say "X is not
exactly like Y, thus nothing applicable to X applies to Y" is a
fallacy. :)

> I'm not familiar with the SCSI PR mechanism either, but it looks to m=
e like it deals in entirely local information =E2=80=94 the equivalent =
with RBD would require performing a locking operation on every object i=
n the RBD image before you accessed it. We could do that, but then open=
ing an image would take time linear in its size=E2=80=A6 :(

Well you would make this configurable and optional, wouldn't you? Kind
of like no-one forces people to use PRs on SCSI LUs. When this is
being used, however, taking a performance hit on open sounds like a
reasonable price to pay for not shredding data. TANSTAAFL.

Again, this is just my poorly informed two cents. :)

Cheers,
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
