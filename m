From: Gregory Farnum <greg@inktank.com>
Subject: Re: How Might a Full-Text Searching Capability be Integrated with Ceph?
Date: Thu, 29 Aug 2013 19:57:17 -0700
Message-ID: <CAPYLRzjbAUj72ovanNJdCwOmwOhVX9cAUk8UTg0PjsHZ_DC9QA@mail.gmail.com>
References: <018901cea474$23119700$6934c500$@internode.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:40812 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab3H3C5S convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 22:57:18 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so1090126lab.32
        for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 19:57:17 -0700 (PDT)
In-Reply-To: <018901cea474$23119700$6934c500$@internode.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Frey <kevin.frey@internode.net.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 28, 2013 at 9:56 PM, Kevin Frey <kevin.frey@internode.net.a=
u> wrote:
> Hello All,
>
> This is my first post to the list, and my question is very general to
> encourage discussion (perhaps derision).
>
> I am the team-leader involved with the development of an application =
of
> which one common capability is a =93document management=94 like facil=
ity that
> permits a user to =93attach=94 (in a logical sense) files to given da=
ta records
> in the database. The kinds of files being attached would be Microsoft=
 Word
> documents, spreadsheets, PDF files, and so on. For various reasons we=
 don=92t
> store these files in the SQL database but instead in an associated fi=
le
> store.
>
> This file store is not very large at present (a few hundred Gb perhap=
s) and
> the storage methodology is fairly na=EFve in the sense it stores onto=
 a single
> volume using RAID as the =93durability=94 component.
>
> Our file store effectively does two things for us however: act as a b=
asic
> store for the files; provides the feed for a full-text indexing syste=
m so
> that the files can be searched on.
>
> Ceph is a product I=92ve been following for a while now and I have no=
 question
> it can handle the storage aspect, but my question relates to how I wo=
uld
> achieve my second requirement?
>
> From what I=92ve read, CephFS is not =93production ready=94 but one o=
bvious
> strategy to achieve a searchable database would be to just expose the=
 whole
> directory namespace (or a single pool?) via CephFS and point a standa=
rd file
> indexing product at it. Would this work? Would it be a good or a bad =
idea
> (ignoring the status of CephFS itself).
>
> Or would you suggest something that is perhaps more tightly integrate=
d with
> the RADOS object store? I need to be wary of not putting myself in th=
e
> position of having to write an entire file indexing suite also in ter=
ms of
> weighing up design possibilities.

Hmm. This is a difficult question since you're basically asking how to
stick an index on top of an object store. :) Ignoring its readiness,
CephFS is a pretty normal filesystem so it should work fine under your
indexing product. Depending on your pipeline it might also be
appropriate to write from your app directly into the RADOS object
store via librados, and when you do that send a copy of the object to
some indexer in order to not have to do scans (or just queue up the
object for indexing, or whatever).
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
