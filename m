From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk improvements
Date: Sat, 2 Apr 2016 10:52:58 +0200
Message-ID: <56FF886A.3080406@dachary.org>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
 <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58790 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbcDBIxD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Apr 2016 04:53:03 -0400
In-Reply-To: <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel@vger.kernel.org

Hi Wido,

On 02/04/2016 07:54, Wido den Hollander wrote:
>=20
>> Op 1 april 2016 om 17:36 schreef Sage Weil <sweil@redhat.com>:
>>
>>
>> Hi all,
>>
>> There are a couple of looming features for ceph-disk:
>>
>> 1- Support for additional devices when using BlueStore.  There can b=
e up=20
>> to three: the main device, a WAL/journal device (small, ~128MB, idea=
lly=20
>> NVRAM), and a fast metadata device (as big as you have available; wi=
ll be=20
>> used for internal metadata).
>>
>> 2- Support for setting up dm-cache, bcache, and/or FlashCache undern=
eath=20
>> filestore or bluestore.
>>
>=20
> Keep in mind that you can't create a partition on a bcache device. So=
 when using
> bcache, the journal has to be filebased and not a partition.

Is this true of all bcache versions ( https://bcache.evilpiepirate.org/=
 ) ? Or is it a planned feature ? Or is it never going to happen ?

Cheers

>=20
> If we add the flag --file-based-journal or --no-partitions we can cre=
ate OSDs on
> both bcache and dm-cache.
>=20
> With BlueStore this becomes a problem since it requires the small (XF=
S)
> filesystem for it's metadata.
>=20
> Wido
>=20
>> The current syntax of
>>
>>  ceph-disk prepare [--dmcrypt] [--bluestore] DATADEV [JOURNALDEV]
>>
>> isn't terribly expressive.  For example, the journal device size is =
set=20
>> via a config option, not on the command line.  For bluestore, the me=
tadata=20
>> device will probably want/need explicit user input so they can ensur=
e it's=20
>> 1/Nth of their SSD (if they have N HDDs to each SSD).
>>
>> And if we put dmcache in there, that partition will need to be sized=
 too.
>>
>> Another consideration is that right now we don't play nice with LVM =
at=20
>> all.  Should we?  dm-cache is usually used in conjunction with LVM=20
>> (although it doesn't have to be).  Does LVM provide value?  Like, th=
e=20
>> ability for users to add a second SSD to a box and migrate cache, wa=
l, or=20
>> journal partitions around?
>>
>> I'm interested in hearing feedback on requirements, approaches, and=20
>> interfaces before we go too far down the road...
>>
>> Thanks!
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
