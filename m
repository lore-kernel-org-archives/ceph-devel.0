From: Chris Pacejo <cpacejo@clearskydata.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Fri, 30 Jan 2015 09:46:06 -0500
Message-ID: <CAC8iE5iqp-noAXucpwsKBQEtQC28_8kGouXpDdKJZ4VttqCRXQ@mail.gmail.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:45092 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759417AbbA3OqH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 09:46:07 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so3273882igb.2
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 06:46:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, haomaiwang@gmail.com

Hi Sage, thanks for the quick reply.

On Thu, Jan 29, 2015 at 5:51 PM, Sage Weil <sage@newdream.net> wrote:
> There is a level (or two) of indirection in KeyValueStore's
> GenericObjectMap that is there to allow object cloning.  I wonder if we
> will want to facilitate a backend that doesn't implement clone and can
> only be used for pools that disallow clone and snap operations.

That would be perfect for us.  We need neither cloning nor snapshots.


> There is also some key consolidation in the OSD layer we talked about in
> the wednesday performance call that will cut this down some!

Awesome.  Each fewer key-value pair will be a huge performance boost for us!
