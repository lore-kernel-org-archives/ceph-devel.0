From: Gregory Farnum <greg@gregs42.com>
Subject: Re: replace fiemap with seek_data/seek_hole?
Date: Tue, 6 Jan 2015 10:09:02 -0800
Message-ID: <CAC6JEv_F_NiS=vDFRu7eXeMRRz+KfNeHbgE3S8V_ikru+MpF4Q@mail.gmail.com>
References: <alpine.DEB.2.00.1501060837090.8073@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:51799 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290AbbAFSJD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 13:09:03 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so4125667ieb.7
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 10:09:03 -0800 (PST)
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com. [209.85.223.171])
        by mx.google.com with ESMTPSA id i3sm28299266iod.19.2015.01.06.10.09.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 10:09:02 -0800 (PST)
Received: by mail-ie0-f171.google.com with SMTP id ar1so4116090iec.2
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 10:09:02 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501060837090.8073@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: haomaiwang@gmail.com, jianpeng.ma@intel.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 6, 2015 at 8:44 AM, Sage Weil <sweil@redhat.com> wrote:
> Hey,
>
> In an exchange on linux-fsdevel yesterday it became clear that even when
> FIEMAP isn't buggy it's not a good interface to build a map of sparse
> files.  For example, XFS defrag or other future fs features may muck with
> fiemap results.  One wouldn't expect those things to change whether a file
> extent is allocated or not allocated, but given what we've seen so far I
> wouldn't bet on it.
>
> Instead, we should use lseek SEEK_DATA/SEEK_HOLE, which is a more natural
> interface for what we need.  This should simply be a matter of replacing
> the fiemap() method implementation in FileStore.cc, I think.
>
> See this thread:
>
>         http://marc.info/?l=linux-fsdevel&m=142050204317588&w=2
>
> The other half of this is we should confirm that xfstests.git has good
> SEEK_HOLE/SEEK_DATA stress tests (that verify correct results on both
> recently written, recently synced, and uncached files).

Is there a ticket covering this? :)
-Greg
