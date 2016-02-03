From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: CephFS and the next hammer release v0.94.6
Date: Wed, 3 Feb 2016 01:23:21 -0800
Message-ID: <CAJ4mKGYBc5O312mGDYzfxYR3uwyVGBu0vgQr-0ofz60vtLLOyw@mail.gmail.com>
References: <56B18773.6000304@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35238 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbcBCJXX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 04:23:23 -0500
Received: by mail-wm0-f53.google.com with SMTP id r129so155258260wmr.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 01:23:22 -0800 (PST)
In-Reply-To: <56B18773.6000304@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

On Tue, Feb 2, 2016 at 8:52 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> The next hammer release as found at https://github.com/ceph/ceph/tree/hammer passed the fs suite (http://tracker.ceph.com/issues/13356#note-25). A more recent run showed 3 failures and I'm not sure how to interpret them ( http://pulpito.ceph.com/loic-2016-01-29_03:02:05-fs-hammer---basic-multi/ ).
>
> Do you think the hammer branch is ready for QE to start their own round of testing ? Or should the above errors be investigated first ?

Well, one of them looks to be an infrastructure issue of some kind.
You appear to have figured out the fsstress one
(http://tracker.ceph.com/issues/14584#change-65185), and the fsx one
is http://tracker.ceph.com/issues/14384. I'd get that quick backport
in as well (it's just a change to the qa script to point at a working
version of the repo).
-Greg
