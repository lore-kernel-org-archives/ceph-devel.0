From: "Kevin Frey" <kevin.frey@internode.net.au>
Subject: How Might a Full-Text Searching Capability be Integrated with Ceph?
Date: Thu, 29 Aug 2013 14:56:32 +1000
Message-ID: <018901cea474$23119700$6934c500$@internode.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:34540 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753265Ab3H2E4z convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Aug 2013 00:56:55 -0400
Content-Language: en-au
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello All,

This is my first post to the list, and my question is very general to
encourage discussion (perhaps derision).

I am the team-leader involved with the development of an application of
which one common capability is a =93document management=94 like facilit=
y that
permits a user to =93attach=94 (in a logical sense) files to given data=
 records
in the database. The kinds of files being attached would be Microsoft W=
ord
documents, spreadsheets, PDF files, and so on. For various reasons we d=
on=92t
store these files in the SQL database but instead in an associated file
store.

This file store is not very large at present (a few hundred Gb perhaps)=
 and
the storage methodology is fairly na=EFve in the sense it stores onto a=
 single
volume using RAID as the =93durability=94 component.

Our file store effectively does two things for us however: act as a bas=
ic
store for the files; provides the feed for a full-text indexing system =
so
that the files can be searched on.

Ceph is a product I=92ve been following for a while now and I have no q=
uestion
it can handle the storage aspect, but my question relates to how I woul=
d
achieve my second requirement?

=46rom what I=92ve read, CephFS is not =93production ready=94 but one o=
bvious
strategy to achieve a searchable database would be to just expose the w=
hole
directory namespace (or a single pool?) via CephFS and point a standard=
 file
indexing product at it. Would this work? Would it be a good or a bad id=
ea
(ignoring the status of CephFS itself).

Or would you suggest something that is perhaps more tightly integrated =
with
the RADOS object store? I need to be wary of not putting myself in the
position of having to write an entire file indexing suite also in terms=
 of
weighing up design possibilities.


Thanks in advance

Kevin


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
