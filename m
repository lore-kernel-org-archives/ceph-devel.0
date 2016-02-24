From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph / rocksdb
Date: Wed, 24 Feb 2016 13:06:48 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602241305060.7555@cpach.fuggernut.com>
References: <20160224060546.GC6585@degu.b.linuxbox.com> <CALqRxCwrsTv=Lbrc98f7WLqwZxeySiAdq08E0h8a2eNyDU6SPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55388 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758502AbcBXSHR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Feb 2016 13:07:17 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id CB9677F092
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 18:07:17 +0000 (UTC)
In-Reply-To: <CALqRxCwrsTv=Lbrc98f7WLqwZxeySiAdq08E0h8a2eNyDU6SPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Marcus Watts <mwatts@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 24 Feb 2016, Ken Dreyer wrote:
> I'm really interested in getting our various bundled libraries into
> separate packages.
> 
> Does ceph's rocksdb have a lot of changes from rocksdb upstream? If
> so, I'm leaning towards packaging this as "ceph-rocksdb" until those
> changes are present in an upstream rocksdb release.

There are a few that aren't upstream yet, but they'll merge eventually. 
That said, I fully expect that we'll make other changes in the future that 
we'll want to build/test/ship before they go upstream... so a special 
package name probably makes sense.

sage


> 
> - Ken
> 
> On Tue, Feb 23, 2016 at 11:05 PM, Marcus Watts <mwatts@redhat.com> wrote:
> > So, about that rocksdb thing.
> >
> > Rocksdb ships with 2 build systems:
> >         cmake           - windows only
> >         make based      - everything else
> >
> > The makefile is very "retro".  Um.  Let's just leave it there.
> >
> > The cmake part was more interesting; the main problem it had
> > was it was *way* too windows specific.  Which is actually kinda
> > hard to do, since that's just what cmake wasn't supposed to be.
> >
> > Building rocksdb (-g) takes about 1g of build tree space,
> > and running "make check" on it takes about half an hour.
> > I really don't want to slow down my ceph builds this way,
> > so rather than make rocksdb with the rest of ceph, I would
> > much rather it be packaged / installed separately.
> >
> > So I put together:
> > a set of changes to build rocksdb with cmake on linux
> > an rpm .spec file to build it for fedora.
> >
> > Rpms (source & amd64) can be found here:
> >         http://people.redhat.com/mwatts/rocksdb/
> > and a git repo with the cmake changes here,
> >         https://github.com/mdw-at-linuxbox/rocksdb
> >
> > The cmake parts could certainly still use more work; I haven't
> > tested this and it will probably need changes on anything other
> > than x86_64, such as certainly any non-gcc/non-linux platform.
> >
> >                                         -Marcus Watts
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
