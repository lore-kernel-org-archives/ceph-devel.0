From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS: stable release?
Date: Wed, 20 Mar 2013 13:36:01 -0700
Message-ID: <C4E387E535D1439AB72CDA5A377DBB34@inktank.com>
References: <CAJH6TXh12ocVd00Vf5GaTxF53nxg0gxt9CUP=8YntaNznCtG-w@mail.gmail.com>
 <655D5B8BA34841288B351F2C19C68F34@inktank.com>
 <20130320212227.51db2b47@thinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:47236 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab3CTUgG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 16:36:06 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so761654pde.32
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 13:36:05 -0700 (PDT)
In-Reply-To: <20130320212227.51db2b47@thinky>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pascal <pa5ca1@gmx.de>
Cc: ceph-devel@vger.kernel.org

On Wednesday, March 20, 2013 at 1:22 PM, Pascal wrote:
> Am Sun, 24 Feb 2013 14:41:27 -0800
> schrieb Gregory Farnum <greg@inktank.com (mailto:greg@inktank.com)>:
> =20
> > On Saturday, February 23, 2013 at 2:14 AM, Gandalf Corvotempesta
> > wrote:
> > > Hi all,
> > > do you have an ETA about a stable realease (or something usable i=
n
> > > production) for CephFS?
> > =20
> > =20
> > =20
> > Short answer: no. =20
> > =20
> > However, we do have a team of people working on the FS again as of =
a
> > month or so ago. We're doing a lot of stabilization (bug fixes), co=
de
> > cleanups, and utility work in the coming months; we can estimate th=
e
> > utility and cleanup work but not the bugs that we'll find, and thos=
e
> > are our main concern right now. Depending on how the next couple
> > months of QA and bug fixing go we should be able to publicize real
> > estimates soonish. -Greg
> > =20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
> > in the body of a message to majordomo@vger.kernel.org (mailto:major=
domo@vger.kernel.org)
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> =20
> =20
> =20
> Hello Gregory,
> =20
> is your response still up-to-date? =20
> =20
> The FAQ (http://ceph.com/docs/master/faq/) says: "Ceph=E2=80=99s obje=
ct store (RADOS) is production ready."
> =20


Well put out some blog posts and emails when we have anything more to r=
eport. :) RADOS is ready, but CephFS is a whole separate layer above it=
=2E
-Greg

Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
