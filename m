From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: CEPH IOPS Baseline Measurements with MemStore
Date: Tue, 24 Jun 2014 07:55:58 +0200 (CEST)
Message-ID: <4fb9e370-1898-4249-9bba-bd931aa1106d@mailpro>
References: <CAPYLRzjzvE+1opqoEC6XNj-C+7diQsheNKwKYoNNoTtH5w5wmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50107 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbaFXF4G convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jun 2014 01:56:06 -0400
In-Reply-To: <CAPYLRzjzvE+1opqoEC6XNj-C+7diQsheNKwKYoNNoTtH5w5wmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Milosz Tanski <milosz@adfin.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks Greg for theses informations!

I'll try to build a test cluster soon.
----- Mail original -----=20

De: "Gregory Farnum" <greg@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Milosz Tanski" <milosz@adfin.com>, "Andreas Joachim Peters" <Andre=
as.Joachim.Peters@cern.ch>, "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Lundi 23 Juin 2014 19:41:31=20
Objet: Re: CEPH IOPS Baseline Measurements with MemStore=20

On Fri, Jun 20, 2014 at 12:41 AM, Alexandre DERUMIER=20
<aderumier@odiso.com> wrote:=20
> They are also a tracker here=20
> http://tracker.ceph.com/issues/7191=20
> "Replace Mutex to RWLock with fdcache_lock in FileStore"=20
>=20
> seem to be done, but I'm not sure it's already is the master branch ?=
=20

I believe this particular patch is still not merged (reviews etc on it=20
and some related things are in progress), but some other pieces of the=20
puzzle are in master (but not being backported to Firefly). In=20
particular, we've enabled an "ms_fast_dispatch" mechanism which=20
directly queues ops from the Pipe thread into the "OpWQ" (rather than=20
going through a DispatchQueue priority queue first), and we've sharded=20
the OpWQ. In progress but coming soonish are patches that should=20
reduce the CPU cost of lfn_find and related FileStore calls, as well=20
as sharding the fdcache lock (unless that one's merged already; I=20
forget).=20
And it turns out the "xattr spillout" patches to avoid doing so many=20
LevelDB accesses were broken, and those are fixed in master (being=20
backported to Firefly shortly).=20

So there's a fair bit of work going on to address most all of those=20
noted bottlenecks; if you're interested in it you probably want to run=20
tests against master and try to track the conversations on the Tracker=20
and ceph-devel. :)=20
-Greg=20
Software Engineer #42 @ http://inktank.com | http://ceph.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
