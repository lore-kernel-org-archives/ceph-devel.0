From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph snapshot problem
Date: Tue, 4 Dec 2012 11:23:04 -0800
Message-ID: <CAPYLRzhwzcto4mJWDQV=PWHppLovY8XqnOnSdMp3+U0vBWsbMg@mail.gmail.com>
References: <20121203075355.425316003E@mail.ncic.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61551 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab2LDTXG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Dec 2012 14:23:06 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so6757449ieb.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Dec 2012 11:23:06 -0800 (PST)
In-Reply-To: <20121203075355.425316003E@mail.ncic.ac.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuyaqi@ncic.ac.cn
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Dec 2, 2012 at 11:53 PM,  <liuyaqi@ncic.ac.cn> wrote:
> Dear Sir,
>
>            I am YaqiLiu who had asked you some questions about snap i=
n ceph,
> and I have some problem with my gmail now, so I am connecting with yo=
u with
> this address . Thanks for your reply about all the questions, but I s=
till
> have some confusion. You said "A pool is a logical namespace into whi=
ch you
> place objects", what is this mean by logical namespace? A directory?C=
an you
> give me an example?

It's not really a directory since it's flat =97 there's no hierarchy
available. It's like an S3 bucket or any other object storage
grouping.

> And what's the meaning of pool snap?

There are a couple of different kinds of snapshots in RADOS: the
"self-managed snapshot" and the "pool snapshot". A pool snapshot is a
snapshot on all objects in the pool, whereas self-managed snapshots
apply to whatever objects you-the-object-writer decide they apply to.

> I think if one
> volume is failed, using one pool can not recover.

No, no. RADOS pools are a logical namespace, and are the level at
which you decide how many copies of the data there are and how they're
placed. So an object in a Ceph cluster is placed into a single RADOS
pool, and then gets 2 or 3 or n copies placed on different OSDs
according to the CRUSH rules used by the pool.


>            I really want to learn the realization of ceph snap, after=
 a few
> weeks of reading code, I still have no idea of the implementation, ca=
n you
> give me some guide on it? Thanks very much!

You're going to need to ask some more specific questions than that. If
you're looking for the low-level implementation you'll have to dig
through the OSD code.

> Can I ask you another question? Where is the content of the
> snapshot like the pointers to the old blocks live in?

That depends on the underlying filesystem in use. But if you look at
the snapshot code in the OSD (start from ReplicatedPG::make_writeable)
you'll see that it clones the object (into a new file on the local FS)
when it needs to make a new snapshot. Follow that around, and look at
the SnapSet struct.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
