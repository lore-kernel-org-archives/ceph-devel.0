From: Ning Yao <zay11022@gmail.com>
Subject: Fwd: problem about pgmeta object?
Date: Wed, 9 Dec 2015 19:55:14 +0800
Message-ID: <CALZt5jxE=_aS_X0d=F1mch2HRitvBDJtuCSvfoAZOhShjtTTMQ@mail.gmail.com>
References: <CALZt5jx2bQKK6yE=bTu96CD=OE7uVGTagfqirHsXh5bNbS2t=w@mail.gmail.com>
	<alpine.DEB.2.00.1511180511420.7964@cobra.newdream.net>
	<CALZt5jzpGn1koOwK2PZ2w6xj-UPibc2B60HU-f1ZayFNDSy3EQ@mail.gmail.com>
	<alpine.DEB.2.00.1512080536300.19170@cobra.newdream.net>
	<CALZt5jy47HwGR7kGzmUC_cGRp-6Q0xe=aA+v+9viJW3vMYYRrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34699 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbbLILzQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 06:55:16 -0500
Received: by wmvv187 with SMTP id v187so257631444wmv.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Dec 2015 03:55:14 -0800 (PST)
In-Reply-To: <CALZt5jy47HwGR7kGzmUC_cGRp-6Q0xe=aA+v+9viJW3vMYYRrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5aea5a6B?= <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The function and transactions corresponding with pgmeta object is listed below:
touch()   and   remove()  for  pgmeta object creation and deletion
_omap_setkeys()  and  _omap_rmkeys()  to  update k/v data in omap for
pgmeta(pg_info, epoch, rollback_info, pg_log and so on)
omap_get_values() to retrieve data from omap, always call it during
osd daemon start proccess

So I think the performance will be hurt in writeOp routine as heavily
call _omap_setkeys()  and  _omap_rmkeys(). The ideal way to deal with
it,  of course, is to eventually treat pgmeta as a logical object(not
real object existed). But it needs alter much in FileStore, since we
cannot directly remove the t.touch()  and  t.remove() transaction and
upgrade store to remove the pgmeta_object based on info_struct_v. But
as we discussed before, it is FileStore issue and need keep
compatibility for other backends.

Therefore, in order to not to alter FileStore too much and keep all
its compatibility, my strategy is just to skip the meta object
existence checking on the main routine of writeOps like this:
https://github.com/ceph/ceph/pull/6870

This brings a benefit to reduce _omap_setkeys()  execution time  from
123.784us to 108.444us averagely (about 15% improvement), and reduce
the whole cpu time 0.5% ~ 1% globally.

Regards
Ning Yao

2015-12-08 21:37 GMT+08:00 Sage Weil <sage@newdream.net>:
>
> On Tue, 8 Dec 2015, Ning Yao wrote:
> > Umm, it seems that MemStore requires in memory meta object to keep the
> > attributes. So it is not a direct way to remove the pg_meta object
> > backend storage. Any suggestions?
> > I think we can just skip the pg_meta operation in FileStore api based
> > on the value of hoid.pgmeta(), not a generic strategy for all
> > backends.
>
> Yeah--a FileStore hack makes more sense, as other backends probably
> won't have the same inefficiency that FileStore does.
>
> Can you summarize the strategy, though?  We want to avoid doing anything
> to weird to FileStore at this point unless there is a big performance win.
>
> sage
