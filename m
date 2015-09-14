From: GuangYang <yguang11@outlook.com>
Subject: RE: Backfill
Date: Mon, 14 Sep 2015 11:43:44 -0700
Message-ID: <BLU175-W241EDB4AD159856222D39ADF5D0@phx.gbl>
References: <BLU175-W33B6417CFB278EA9EC4092DF500@phx.gbl>,<alpine.DEB.2.00.1509110556430.7527@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc2s8.hotmail.com ([65.55.111.83]:64012 "EHLO
	BLU004-OMC2S8.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbbINSnp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 14:43:45 -0400
In-Reply-To: <alpine.DEB.2.00.1509110556430.7527@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sjust@redhat.com" <sjust@redhat.com>

Thanks Sage. That makes sense. Just would like to confirm my understand=
ing:

Let's say the map for the PG changes from [1, 2, 3] to [1, 2, 4] and 4 =
is the backfill target (4 may or may not have the info for the PG, whic=
h should not matter as long as it is not eligible for log based recover=
y), here the PG's last_backfill and backfill_info.begin would reset to =
MIN, same for 4, and the flow would be something like:
=A0 1. 1 scan_range starting from backfill_info.begin for a configured =
number of entries
=A0 2. 1 query the digest from 4 for the range
=A0 3. Once the digest is back from 4, fill the to_push and to_remove l=
ist by comparing the local and remote entries (here we also consider th=
e PG log to capture most recent updates)
=A0 4. If either to_push or to_remove is not empty, push the objects (o=
r remove) to the backfill target.
=A0 5. Move the lack_backfill pointer and continue with step 1.

Thanks,
Guang

----------------------------------------
> Date: Fri, 11 Sep 2015 05:57:42 -0700
> From: sage@newdream.net
> To: yguang11@outlook.com
> CC: ceph-devel@vger.kernel.org; sjust@redhat.com
> Subject: Re: Backfill
>
> On Thu, 10 Sep 2015, GuangYang wrote:
>> Today I played around recovery and backfill of a Ceph cluster (by
>> manually bringing some OSDs down/out), and got one question regards =
to
>> the current flow:
>>
>> Does backfill push everything to the backfill target regardless what=
 the
>> backfill target already has? The scenario is like - acting set of th=
e PG
>> is [1, 2, 3], and 3 went down (at which point it already had some da=
ta)
>> and stayed down for a sustained period (but not marked out), during
>> which time there were sustained WRITE to the PG. At some point 3 wen=
t
>> back up, and it is not sufficient to recovery via PG log, so the PG
>> needed to be backfilled and 3 is the target. Does 1 needs to push
>> everything (last_backfill starts with MIN) to 3? It seems so to me a=
s I
>> don't see some round trip to negotiate what each OSD has and do an
>> incremental push (as recovery does), but it would be nice to get con=
firm
>> :)
>
> No. Backfill iterates over objects on the source and destination and
> only pushes objects that are missing or out of date (and deletes ones
> that shouldn't be there). This is all in ReplicatedPG::recover_backfi=
ll()
> (though it's not the easiest read).
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
