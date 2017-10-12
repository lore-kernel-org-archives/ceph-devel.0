From: Sage Weil <sage@newdream.net>
Subject: Re: do we support building on rhel/centos 7.{0,1,2} ?
Date: Thu, 12 Oct 2017 16:02:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710121601300.26711@piezo.us.to>
References: <CAJE9aOMu87QgwZ5jrRPSUa6E461mYAJnxurmGwV-DU_=CTFgvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:51640 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbdJLQC2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Oct 2017 12:02:28 -0400
In-Reply-To: <CAJE9aOMu87QgwZ5jrRPSUa6E461mYAJnxurmGwV-DU_=CTFgvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 12 Oct 2017, kefu chai wrote:
> hi all,
> 
> rocksdb's cmake script is using features[0] introduced by cmake
> 2.8.12[1]. as install()[2] on 2.8.11 does not support "INCLUDES"
> argument. hence, the build on el 7.{0,1,2} is broken now. but
> http://docs.ceph.com/docs/master/start/os-recommendations/#luminous-12-2-z
> claims that we support centos7..
> 
> the reason why we are not trouble now is that we are not
> building/testing build on them now.
> 
> so the question is, shall we support build on centos 7.{0,1,2} on
> which cmake 2.8.11? if the answer is yes, we need to maintain the
> patched rocksdb submodule in our fork.

FWIW I don't much care about whether we *build* on those older releases as 
long as we can run there.  Usually the folks that are unable to upgrade 
are the stodgey enterprises that aren't doing their own builds anyway.

sage
