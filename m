From: Sage Weil <sage@newdream.net>
Subject: Re: Memory Pooling and Containers
Date: Wed, 28 Sep 2016 13:16:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609281315140.19847@piezo.us.to>
References: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com> <CAJ4mKGYQLrP_Z28iitj9Vwt3dSfVp2yQ3bnGt2jcTC9LahnvUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34344 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932474AbcI1NQP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2016 09:16:15 -0400
In-Reply-To: <CAJ4mKGYQLrP_Z28iitj9Vwt3dSfVp2yQ3bnGt2jcTC9LahnvUg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 27 Sep 2016, Gregory Farnum wrote:
> On Tue, Sep 27, 2016 at 1:30 PM, Allen Samuels
> <Allen.Samuels@sandisk.com> wrote:
> > As we discussed in the Bluestore standup this morning. This is intended to start a discussion about creating some internal memory pooling technology to try to get a better handle on the internal usage of memory by Ceph. Let's start by discussing the requirements...
> 
> I'm afraid I don't have any useful thoughts on this, but I'm curious
> if there's any chance of using these memory pools effectively outside
> of BlueStore. Many of the features you discuss would be nice in the
> MDS, which currently uses boost::pool for some of its metadata types,
> but could really use something with a little more control (at least
> than we've set up so far).

Yeah, that is definitely a goal.  This would be useful for all services!

sage
