From: Sage Weil <sage@newdream.net>
Subject: Re: Failed on starting osd-daemon after upgrade giant-0.87.1
 tohammer-0.94.3
Date: Fri, 11 Sep 2015 08:10:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509110806420.7527@cobra.newdream.net>
References: <tencent_42C775740D2FE9D03D12EA84@qq.com> <alpine.DEB.2.00.1509090954410.12362@cobra.newdream.net> <tencent_7EDD2DF72EF83A9470528405@qq.com> <alpine.DEB.2.00.1509110554520.7527@cobra.newdream.net> <CACJqLyYMw60oWcX-GQKTQ6d4Rz8f5gNsXeANOrHCcsWJnzEpkQ@mail.gmail.com>
 <alpine.DEB.2.00.1509110700200.7527@cobra.newdream.net> <CACJqLyY9wGuiqL+m75E6c42EdfwiRLjdgn7=0vb-9oZLQdrHNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59469 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbbIKPKb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 11:10:31 -0400
In-Reply-To: <CACJqLyY9wGuiqL+m75E6c42EdfwiRLjdgn7=0vb-9oZLQdrHNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: =?GB2312?B?zfXI8Q==?= <wangrui@tvmining.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 11 Sep 2015, Haomai Wang wrote:
> On Fri, Sep 11, 2015 at 10:09 PM, Sage Weil <sage@newdream.net> wrote:
> > On Fri, 11 Sep 2015, Haomai Wang wrote:
> >> On Fri, Sep 11, 2015 at 8:56 PM, Sage Weil <sage@newdream.net> wrote:
> >>       On Fri, 11 Sep 2015, ?? wrote:
> >>       > Thank Sage Weil:
> >>       >
> >>       > 1. I delete some testing pools in the past, but is was a long
> >>       time ago (may be 2 months ago), in recently upgrade, do not
> >>       delete pools.
> >>       > 2.  ceph osd dump please see the (attachment file
> >>       ceph.osd.dump.log)
> >>       > 3. debug osd = 20' and 'debug filestore = 20  (attachment file
> >>       ceph.osd.5.log.tar.gz)
> >>
> >>       This one is failing on pool 54, which has been deleted.  In this
> >>       case you
> >>       can work around it by renaming current/54.* out of the way.
> >>
> >>       > 4. i install the ceph-test, but output error
> >>       > ceph-kvstore-tool /ceph/data5/current/db list
> >>       > Invalid argument: /ceph/data5/current/db: does not exist
> >>       (create_if_missing is false)
> >>
> >>       Sorry, I should have said current/omap, not current/db.  I'm
> >>       still curious
> >>       to see the key dump.  I'm not sure why the leveldb key for these
> >>       pgs is
> >>       missing...
> >>
> >>
> >> Yesterday I have a chat with wangrui and the reason is "infos"(legacy oid)
> >> is missing. I'm not sure why it's missing.
> >
> > Probably
> >
> > https://github.com/ceph/ceph/blob/hammer/src/osd/OSD.cc#L2908
> >
> > Oh, I think I see what happened:
> >
> >  - the pg removal was aborted pre-hammer.  On pre-hammer, thsi means that
> > load_pgs skips it here:
> >
> >  https://github.com/ceph/ceph/blob/firefly/src/osd/OSD.cc#L2121
> >
> >  - we upgrade to hammer.  we skip this pg (same reason), don't upgrade it,
> > but delete teh legacy infos object
> >
> >  https://github.com/ceph/ceph/blob/hammer/src/osd/OSD.cc#L2908
> >
> >  - now we see this crash...
> >
> > I think the fix is, in hammer, to bail out of peek_map_epoch if the infos
> > object isn't present, here
> >
> >  https://github.com/ceph/ceph/blob/hammer/src/osd/PG.cc#L2867
> >
> > Probably we should restructure so we can return a 'fail' value
> > instead of a magic epoch_t meaning the same...
> >
> > This is similar to the bug I'm fixing on master (and I think I just
> > realized what I was doing wrong there).
> 
> Hmm, I got it. So we could skip this assert or just like load_pgs to
> check pool whether exists?
> 
> I think it's urgent bug because I remember several people show me the
> alike crash.

Yeah.. take a look at https://github.com/ceph/ceph/pull/5892

Does that look right to you?  Packages are building now...

sage
