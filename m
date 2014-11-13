From: GuangYang <yguang11@outlook.com>
Subject: PG down
Date: Thu, 13 Nov 2014 12:15:00 +0000
Message-ID: <BLU175-W3A509068439286AE88D0EDF8F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s5.hotmail.com ([65.55.111.144]:51686 "EHLO
	BLU004-OMC4S5.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329AbaKMMPB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 07:15:01 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sam.just@inktank.com" <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sam,
Yesterday there was one PG down in our cluster and I am confused by the=
 PG state, I am not sure if it is a bug (or an issue has been fixed as =
I see a couple of related fixes in giant), it would be nice you can hel=
p to take a look.

Here is what happened:

We are using EC pool with 8 data chunks and 3 code chunks, saying the P=
G has up/acting set as [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], there was o=
ne OSD in the set down and up, so that it triggered PG recovering. Howe=
ver, when doing recover, the primary OSD crash as due to a corrupted fi=
le chunk, then another OSD become primary, start recover and crashed, a=
nd so on so forth until there are 4 OSDs down in the set and the PG is =
marked down.

After that, we left the OSD having corrupted data down and started all =
other crashed OSDs, we expected the PG could become active, however, th=
e PG is still down with the following query information:

{ "state": "down+remapped+inconsistent+peering",
=A0 "epoch": 4469,
=A0 "up": [
=A0 =A0 =A0 =A0 377,
=A0 =A0 =A0 =A0 107,
=A0 =A0 =A0 =A0 328,
=A0 =A0 =A0 =A0 263,
=A0 =A0 =A0 =A0 395,
=A0 =A0 =A0 =A0 467,
=A0 =A0 =A0 =A0 352,
=A0 =A0 =A0 =A0 475,
=A0 =A0 =A0 =A0 333,
=A0 =A0 =A0 =A0 37,
=A0 =A0 =A0 =A0 380],
=A0 "acting": [
=A0 =A0 =A0 =A0 2147483647,
=A0 =A0 =A0 =A0 107,
=A0 =A0 =A0 =A0 328,
=A0 =A0 =A0 =A0 263,
=A0 =A0 =A0 =A0 395,
=A0 =A0 =A0 =A0 2147483647,
=A0 =A0 =A0 =A0 352,
=A0 =A0 =A0 =A0 475,
=A0 =A0 =A0 =A0 333,
=A0 =A0 =A0 =A0 37,
=A0 =A0 =A0 =A0 380],
=2E..
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 377]}],
=A0 =A0 =A0 =A0 =A0 "probing_osds": [
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "37(9)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "107(1)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "263(3)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "328(2)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "333(8)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "352(6)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "377(0)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "380(10)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "395(4)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "467(5)",
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "475(7)"],
=A0 =A0 =A0 =A0 =A0 "blocked": "peering is blocked due to down osds",
=A0 =A0 =A0 =A0 =A0 "down_osds_we_would_probe": [
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8],
=A0 =A0 =A0 =A0 =A0 "peering_blocked_by": [
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "osd": 8,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "current_lost_at": 0,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "comment": "starting or marking thi=
s osd lost may let us proceed"}]},
=A0 =A0 =A0 =A0 { "name": "Started",
=A0 =A0 =A0 =A0 =A0=A0"enter_time": "2014-11-12 10:12:23.067369"}],
}

Here osd.8 is the one having corrupted data.

The way we worked around this issue is to set norecover and start osd.8=
, get that PG active and then removed the object (via rados), unset nor=
ecover and things become clean again. But the most confusing part is th=
at even we only left osd.8 down, the PG couldn't become active.

We are using firefly v0.80.4.

Thanks,
Guang 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
