From: wchen <wchen@tnsoft.com.cn>
Subject: Re: what's the exact meaning of cap?
Date: Thu, 2 Dec 2010 09:41:57 +0800
Message-ID: <1291254117.2397.17.camel@node1>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
	 <Pine.LNX.4.64.1011300852460.4337@cobra.newdream.net>
	 <1291175401.2397.14.camel@node1>
	 <AANLkTim=08MJ_0tcasrJZuqrrSVwB9tB5MPHLJOjx5_W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:61809 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755585Ab0LBBnX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Dec 2010 20:43:23 -0500
In-Reply-To: <AANLkTim=08MJ_0tcasrJZuqrrSVwB9tB5MPHLJOjx5_W@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, Farnum,

Thank you very much! :-)


On Thu, 2010-12-02 at 00:11 +0800, Gregory Farnum wrote:
> On Tue, Nov 30, 2010 at 7:50 PM, wchen <wchen@tnsoft.com.cn> wrote:
> > hi, Sage,
> >
> > I'm reading the source code of ceph. Recently I'm very confused wit=
h
> > struct InodeCap's issued, implemented, wanted fields. I just have a
> > preliminary understanding of them, but what's the exact difference
> > between them? there are lots of code to reflect the relation betwee=
n
> > them. Can you explain it for me? or any documents about it?
> Unfortunately we don't have a lot of documentation about the source
> code itself. Sage's thesis (which is available on the website) is the
> best resource, and does describe caps some.
>=20
> Briefly, caps are short for capabilities. They are issued by the MDS
> to clients to describe what the client is allowed to do with an inode
> and its associated file. There are capabilities to, for instance, let
> the client buffer writes, cache reads, and adjust certain kinds of
> metadata (mtime, et al).
> The wanted capabilities are caps the client wants but doesn't have.
> Issued caps are ones the client has been granted, and (IIRC)
> implemented caps are a subset of the issued caps describing which cap=
s
> the client has actually made use of. It's useful for determining
> whether the client has dirty metadata and whatnot. :)
> -Greg

--=20
best regards,
Kevin Chen (=E9=99=88=E5=B7=8D)

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
