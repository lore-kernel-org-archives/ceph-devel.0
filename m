From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Cannot mount ceph filesystem: error 5 (Input/Output error)
Date: Tue, 6 Dec 2011 11:51:45 -0800
Message-ID: <CAF3hT9DSf5Xaw00PUFHp5OtGAabka+Wc6H4vVkK24PJGNizd4Q@mail.gmail.com>
References: <4366451.BU1d1YAr76@pc10>
	<2356347.ajsbJfnmVK@pc10>
	<CACLRD_0mb_PxqmZUqgTnjXJARKw6NV34QEF_fqCtXZ4UJ7C9GQ@mail.gmail.com>
	<3826746.5bRf3lS2YZ@tolkien>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61618 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab1LFTvq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 14:51:46 -0500
Received: by qcqz2 with SMTP id z2so2558564qcq.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2011 11:51:45 -0800 (PST)
In-Reply-To: <3826746.5bRf3lS2YZ@tolkien>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Sat, Dec 3, 2011 at 6:21 AM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> On Friday 02 December 2011 11:29:41 Samuel Just wrote:
>> Guido,
>>
>> Sorry for the confusion, you hit a bug where the default map for a
>> cluster with one osd contains no pgs. =A00.39 (which will be release=
d
>> today) will have a fix.
>
> Really? Then why does the output of ceph -s below mention 6 pgs?
There are a couple of different categories of PGs; the 6 that exist
are "local" PGs which are tied to a specific OSD. However, those
aren't actually used in a standard Ceph configuration.


> BTW, that's another aspect where the documentation is a bit lacking r=
ight now.
> I've found a page telling me how to change the number of pgs, but I c=
ouldn't
> find any explanation so far what a pg actually is, or why I should wa=
nt to
> change their number...
PG =3D "placement group". When placing data in the cluster, objects are
mapped into PGs, and those PGs are mapped onto OSDs. We use the
indirection so that we can group objects, which reduces the amount of
per-object metadata we need to keep track of and processes we need to
run (it would be prohibitively expensive to track eg the placement
history on a per-object basis).
Increasing the number of PGs can reduce the variance in per-OSD load
across your cluster, but each PG requires a bit more CPU and memory on
the OSDs that are storing it. We try and ballpark it at 100 PGs/OSD,
although it can vary widely without ill effects depending on your
cluster. You hit a bug in how we calculate the initial PG number from
a cluster description.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
