From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Proposal for adding disable FileJournal option
Date: Thu, 9 Jan 2014 19:16:07 +0100
Message-ID: <B25C7326-5CC9-4CCB-817D-A6CDBCAA4A9C@profihost.ag>
References: <08E73B64-A538-4A34-B0F6-1D7A2A00A8AF@gmail.com> <CAPYLRzgb1dEi=prb32mfVZ+=jDS72376GPU-pz7n3SPs7T-t1Q@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:52202 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbaAISWy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2014 13:22:54 -0500
In-Reply-To: <CAPYLRzgb1dEi=prb32mfVZ+=jDS72376GPU-pz7n3SPs7T-t1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I had the samt question in the past but there seems no way to change it=
 for the ceph team

Stefan

This mail was sent with my iPhone.

> Am 09.01.2014 um 18:28 schrieb Gregory Farnum <greg@inktank.com>:
>=20
> The FileJournal is also for data safety whenever we're using write
> ahead. To disable it we need a backing store that we know can provide
> us consistent checkpoints (i.e., we can use parallel journaling mode =
=E2=80=94
> so for the FileJournal, we're using btrfs, or maybe zfs someday). But
> for those systems you can already configure the system not to use a
> journal.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20
>=20
>> On Thu, Jan 9, 2014 at 12:13 AM, Haomai Wang <haomaiwang@gmail.com> =
wrote:
>> Hi all,
>>=20
>> We know FileJournal plays a important role in FileStore backend, it =
can
>> hugely reduce write latency and improve small write operations.
>>=20
>> But in practice, there exists exceptions such as we already use Flas=
hCache or cachepool(although it's not ready).
>>=20
>> If cachepool enabled, we may use use journal in cache_pool but may
>> not like to use journal in base_pool. The main reason why drop journ=
al
>> in base_pool is that journal take over a single physical device and =
waste
>> too much in base_pool.
>>=20
>> Like above, if I enable FlashCache or other cache, I'd not like to e=
nable
>> journal in OSD layer.
>>=20
>> So is it necessary to disable journal in special(not really special)=
 case?
>>=20
>> Best regards,
>> Wheats
>>=20
>>=20
>>=20
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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
