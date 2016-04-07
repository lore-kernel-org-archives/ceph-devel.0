From: Sebastien Han <shan@redhat.com>
Subject: Re: ceph-disk improvements
Date: Thu, 7 Apr 2016 12:31:21 +0200
Message-ID: <CA+HUO7+7v5NjiP-3+h-OMkez3L8MSRoo27+=HCdEc20ntW9=gw@mail.gmail.com>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
 <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
 <20160407092627.GE26235@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38013 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbcDGKbm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 06:31:42 -0400
Received: by mail-wm0-f47.google.com with SMTP id u206so80944866wme.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2016 03:31:41 -0700 (PDT)
In-Reply-To: <20160407092627.GE26235@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: ceph-devel@vger.kernel.org

One thing I'd like to see and I know we discussed that with Lo=C3=AFc a
while ago is ceph-disk being idempotent when it comes to the device
preparation.
Running "ceph-disk prepare" against a device should result in an exit
0 if the disk already has an OSD prepared on it (unless we do
something like --force, which will then zap the disk).
I had to implement this logic in ceph-ansible (and the guys from
chef/puppet probably did the same), so now it's done but i'll be happy
to leave ceph-disk doing it :).

Thoughts?

On Thu, Apr 7, 2016 at 11:26 AM, Lars Marowsky-Bree <lmb@suse.com> wrot=
e:
> On 2016-04-02T07:54:05, Wido den Hollander <wido@42on.com> wrote:
>
>>
>> > Op 1 april 2016 om 17:36 schreef Sage Weil <sweil@redhat.com>:
>> >
>> >
>> > Hi all,
>> >
>> > There are a couple of looming features for ceph-disk:
>> >
>> > 1- Support for additional devices when using BlueStore.  There can=
 be up
>> > to three: the main device, a WAL/journal device (small, ~128MB, id=
eally
>> > NVRAM), and a fast metadata device (as big as you have available; =
will be
>> > used for internal metadata).
>> >
>> > 2- Support for setting up dm-cache, bcache, and/or FlashCache unde=
rneath
>> > filestore or bluestore.
>> >
>>
>> Keep in mind that you can't create a partition on a bcache device. S=
o when using
>> bcache, the journal has to be filebased and not a partition.
>
> Is there a point to running the journal on bcache? I see a point for
> bcache for the (potentially on HDD) actual data store - but the
> WAL/journal, would that not be directly on NVMe/PM/SSD (at the very
> least)? Without an intervening cache?
>
>
> Regards,
>     Lars
>
> --
> Architect SDS, Distinguished Engineer
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham No=
rton, HRB 21284 (AG N=C3=BCrnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar W=
ilde
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Cheers

=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Senior Cloud Architect

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com
Address: 11 bis, rue Roqu=C3=A9pine - 75008 Paris
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
