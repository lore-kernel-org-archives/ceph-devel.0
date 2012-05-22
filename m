From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 23:00:43 +0200
Message-ID: <4FBBFE7B.4060406@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com> <4FBBF74C.9020608@profihost.ag> <45F1742481D84E7A90951816DB23609F@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:48772 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab2EVVAp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 17:00:45 -0400
In-Reply-To: <45F1742481D84E7A90951816DB23609F@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 22.05.2012 22:49, schrieb Greg Farnum:
> Anyway, it looks like you're just paying a synchronous write penalty
What does that exactly mean? Shouldn't one threaded write to four=20
260MB/s devices gives at least 100Mb/s?

> since with 1 write at a time you're getting 30-40MB/s out of rados be=
nch, but with 16 you're getting>100MB/s.
 >(If you bump up past 16 or increase the size of each with -b you may=20
find yourself getting even more.)
yep noticed that.

> So try enabling RBD writeback caching =E2=80=94 see http://marc.info/=
?l=3Dceph-devel&m=3D133758599712768&w=3D2
will test tomorrow. Thanks.

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
