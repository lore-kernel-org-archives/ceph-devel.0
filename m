From: Sage Weil <sage@newdream.net>
Subject: Re: Bluestore OSD support in ceph-disk
Date: Thu, 15 Sep 2016 18:34:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609151833290.19761@piezo.us.to>
References: <4459A44C-1336-4EC1-82F0-F491D0C83712@Teradata.com> <BL2PR02MB2115BE07E99958F8FA8E521CF4F10@BL2PR02MB2115.namprd02.prod.outlook.com> <0B017562-31CE-4C51-8ADB-997E5D59C1BF@Teradata.com> <C749C86B-A804-4566-9F63-B7B90E6E0891@Teradata.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-980904115-1473964467=:19761"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42308 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbcIOSe2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2016 14:34:28 -0400
In-Reply-To: <C749C86B-A804-4566-9F63-B7B90E6E0891@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-980904115-1473964467=:19761
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 15 Sep 2016, Kamble, Nitin A wrote:
> Can I use ceph-disk to prepare a bluestore OSD now?
> 
> I would like to know proper command line parameters for ceph-disk .
> 
> The following related issue tracker has closed, does it mean it is ready 
> to use for creation of bluestore OSDs?
> 
> From: http://tracker.ceph.com/issues/13942
> 
> >
> > Updated by Sage Weil 9 months ago
> >	• Status changed from In Progress to Verified
> >	• Assignee deleted (Loic Dachary)
> > For the 'ceph-disk prepare' part, I think we should keep it simple initially:
> >
> > ceph-disk --osd-objectstore bluestore maindev[:dbdev[:waldev]]
> > and teach ceph-disk how to do the partitioning for bluestore (no generic way to ask ceph-osd that). We can leave off the db/wal devices initially, and then make activate work, so that there is something functional. Then add dbdev and waldev support last.

You just need to pass --bluestore to ceph-disk for a single-disk setup. 
The multi-device PR is still pending, but close:

	https://github.com/ceph/ceph/pull/10135

sage
--8323329-980904115-1473964467=:19761--
