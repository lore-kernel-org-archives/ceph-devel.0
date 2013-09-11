From: Gregory Farnum <greg@inktank.com>
Subject: Re: ocfs2 for OSDs?
Date: Wed, 11 Sep 2013 13:02:14 -0700
Message-ID: <CAPYLRzixoGmcnUjGC+H92h4kwfvt40=fds8hxQgZDQ3izLiDrw@mail.gmail.com>
References: <CAE63xUNKj7JnU_Kypnh39j4z6qVPh2ZLCdiEvfis3_9fDBZ2FA@mail.gmail.com>
	<alpine.DEB.2.00.1309110916180.23522@cobra.newdream.net>
	<20130911215511.3ae4e85a@plati.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:50320 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3IKUCQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Sep 2013 16:02:16 -0400
Received: by mail-wi0-f177.google.com with SMTP id cb5so2639278wib.16
        for <ceph-devel@vger.kernel.org>; Wed, 11 Sep 2013 13:02:15 -0700 (PDT)
In-Reply-To: <20130911215511.3ae4e85a@plati.site>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Sage Weil <sage@inktank.com>, Ugis <ugis22@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

On Wed, Sep 11, 2013 at 12:55 PM, David Disseldorp <ddiss@suse.de> wrote:
> Hi Sage,
>
> On Wed, 11 Sep 2013 09:18:13 -0700 (PDT)
> Sage Weil <sage@inktank.com> wrote:
>
>> > REFLINKs (inode-based writeable snapshots)
>>
>> This is the one item on this list I see that the ceph-osds could take real
>> advantage of; it would make object clones triggered by things like RBD
>> snapshots faster.  What is missing from this list that would be similarly
>> (or more) useful is a volume/fs snapshot feature.
>
> I must be missing something here, but I don't see how this would offer
> any advantage over Btrfs, which provides the same feature via
> BTRFS_IOC_CLONE and BTRFS_IOC_CLONE_RANGE.

Yep, we do that on btrfs. Sage was just looking at things we could use
which aren't part of the standard POSIX spec. This could give ocfs2 an
advantage over xfs/ext4 if we implemented that awareness.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
