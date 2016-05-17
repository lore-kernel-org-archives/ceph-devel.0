From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] v0.94.7 Hammer released
Date: Tue, 17 May 2016 07:56:13 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605170754590.30956@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605131020340.20416@cpach.fuggernut.com> <CABZ+qq=PUoA8rObv+TwT_NO9nRJnQA4xXOrKKdCp=5Q42Y9pNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1255029369-1463486176=:30956"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbcEQLz7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 May 2016 07:55:59 -0400
In-Reply-To: <CABZ+qq=PUoA8rObv+TwT_NO9nRJnQA4xXOrKKdCp=5Q42Y9pNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1255029369-1463486176=:30956
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 17 May 2016, Dan van der Ster wrote:
> Hi Sage et al,
> 
> I'm updating our pre-prod cluster from 0.94.6 to 0.94.7 and after
> upgrading the ceph-mon's I'm getting loads of warnings like:
> 
> 2016-05-17 10:01:29.314785 osd.76 [WRN] failed to encode map e103116
> with expected crc
> 
> I've seen that error is whitelisted in the qa-suite:
> https://github.com/ceph/ceph-qa-suite/pull/602/files
> 
> Is it really harmless? (This is the first time I've seen such a warning).

Are you sure you were upgrading from v0.94.6?  I don't see anything that 
would trigger these warnings going from .6 to .7, which is strange.

That said, the errors are generally harmless--it just means the monitors 
are running a different version of the code and the OSDs are pulling maps 
directly from a mon to ensure they are all in sync.  It's normal during 
many upgrades, but not expected for this particular jump...

sage




> Thanks in advance!
> 
> Dan
> 
> 
> 
> 
> On Fri, May 13, 2016 at 4:21 PM, Sage Weil <sage@redhat.com> wrote:
> > This Hammer point release fixes several minor bugs. It also includes a
> > backport of an improved ‘ceph osd reweight-by-utilization’ command for
> > handling OSDs with higher-than-average utilizations.
> >
> > We recommend that all hammer v0.94.x users upgrade.
> >
> > For more detailed information, see the release announcement at
> >
> >         http://ceph.com/releases/v0-94-7-hammer-released/
> >
> > or the complete changelog at
> >
> >         http://docs.ceph.com/docs/master/_downloads/v0.94.6.txt
> >
> > Getting Ceph
> > ------------
> >
> > * Git at git://github.com/ceph/ceph.git
> > * Tarball at http://download.ceph.com/tarballs/ceph-0.94.7.tar.gz
> > * For packages, see http://ceph.com/docs/master/install/get-packages
> > * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> 
> 
--8323329-1255029369-1463486176=:30956--
