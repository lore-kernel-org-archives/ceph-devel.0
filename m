From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] mon IO usage
Date: Tue, 21 May 2013 08:56:47 -0700
Message-ID: <CAPYLRzjJHZireZOA8G2Msq3dzHYDM=3TUfeKnZ1hxTgRGNYONQ@mail.gmail.com>
References: <CAF6-1L4oWCwNxywALb=cUNP_pbD=ND631MJqvCWyvAfvNdWauQ@mail.gmail.com>
	<519B6F28.9000400@scholarstack.com>
	<519B75B2.4070405@scholarstack.com>
	<CAF6-1L4NHhtaaGGB4vBwWWqEa0pVR4T44-Xx_eTmkUEEXHsfgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:48590 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3EUP4t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 11:56:49 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so980403lbi.37
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 08:56:48 -0700 (PDT)
In-Reply-To: <CAF6-1L4NHhtaaGGB4vBwWWqEa0pVR4T44-Xx_eTmkUEEXHsfgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Mike Dawson <mike.dawson@scholarstack.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 21, 2013 at 8:52 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> So, AFAICT, the bulk of the write would be writing out the pgmap to
> disk every second or so.
>
> Is it really needed to write it in full ? It doesn't change all that
> much AFAICT, so writing incremental changes with only periodic flush
> might be a better option ?

Yeah; this is definitely in our heads as work we'd like to get done.
LevelDB is costing us more throughput than we were expecting so people
are running into trouble much earlier than we expected.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
