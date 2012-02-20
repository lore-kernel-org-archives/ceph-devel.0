From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Problem after ceph-osd crash
Date: Mon, 20 Feb 2012 18:49:19 +0100
Message-ID: <4F42879F.1040802@filoo.de>
References: <4F427C05.1000304@filoo.de> <Pine.LNX.4.64.1202200941100.30577@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:49691 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab2BTRtV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2012 12:49:21 -0500
In-Reply-To: <Pine.LNX.4.64.1202200941100.30577@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On 02/20/2012 06:41 PM, Sage Weil wrote:
> On Mon, 20 Feb 2012, Oliver Francke wrote:
>> Hi,
>>
>> we are just in trouble after some mess with trying to include a new =
OSD-node
>> into our cluster.
>>
>> We get some weird "libceph: corrupt inc osdmap epoch 880 off 102
>> (ffffc9001db8990a of ffffc9001db898a4-ffffc9001db89dae)"
>>
>> on the console.
>> The whole system is in a state ala:
>>
>> 012-02-20 17:56:27.585295    pg v942504: 2046 pgs: 1348 active+clean=
, 43
>> active+recovering+degraded+remapped+backfill, 218 active+recovering,=
 437
>> active+recovering+remapped+backfill; 1950 GB data, 3734 GB used, 260=
59 GB /
>> 29794 GB avail; 272914/1349073 degraded (20.230%)
>>
>> and sometimes the ceph-osd on node0 is crashing. At the moment of wr=
iting, the
>> degrading continues to shrink down below 20%.
> How did ceph-osd crash?  Is there a dump in the log?

'course I will provide all logs, uhm, a bit later, we are busy to start=
=20
all VM's, and handle first customer-tickets right now ;-)

To be most complete for the collection, would you be so kind to give a=20
list of all necessary kern.log osdX.log etc.?

Thnx for the fast reaction,

Oliver.

> sage
>
>> Any clues?
>>
>> Thnx in @vance,
>>
>> Oliver.
>>
>> --=20
>>
>> Oliver Francke
>>
>> filoo GmbH
>> Moltkestra=DFe 25a
>> 33330 G=FCtersloh
>> HRB4355 AG G=FCtersloh
>>
>> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
>>
>> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
