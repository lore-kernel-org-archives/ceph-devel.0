From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: ceph/hadoop benchmarking
Date: Wed, 26 Oct 2011 15:08:23 -0700 (PDT)
Message-ID: <764591372.5356.1319666903551.JavaMail.root@mail-01.cse.ucsc.edu>
References: <CAF3hT9DtAUCfJknGXO+tejPju6RY8mnAQkLotarQa66HMV0cwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:42304 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab1JZWIX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2011 18:08:23 -0400
In-Reply-To: <CAF3hT9DtAUCfJknGXO+tejPju6RY8mnAQkLotarQa66HMV0cwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

----- Original Message -----
> From: "Gregory Farnum" <gregory.farnum@dreamhost.com>
>
> So I'd agree that #3 should be our eventual goal, but if we want
> proper Java libceph/librados bindings (and to use these in Hadoop)
> there's a lot of work that needs to be done before we try and push the
> Java code upstream. The current library is *not* generic and contains
> a lot of Hadoop-specific application logic that will need to be pushed
> back out to Java.

To make sure I understand the generic/Hadoop-specific code issue, the
current JNI wrappers contain a ceph_isdirectory routine, but libcephfs
only contains lstat, upon which ceph_isdirectory is built. So, these
need to be futher pulled apart.

Thanks for the feedback guys. This plan seems real good.

-Noah
