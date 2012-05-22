From: Greg Farnum <greg@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 13:49:12 -0700
Message-ID: <45F1742481D84E7A90951816DB23609F@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag>
 <B141A2FBE87F4859AF931D71A339468E@inktank.com>
 <4FBBEBC8.1000205@profihost.ag>
 <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com>
 <4FBBF74C.9020608@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58501 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab2EVUtS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 16:49:18 -0400
Received: by dady13 with SMTP id y13so8748404dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 13:49:17 -0700 (PDT)
In-Reply-To: <4FBBF74C.9020608@profihost.ag>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Tuesday, May 22, 2012 at 1:30 PM, Stefan Priebe wrote:
> Am 22.05.2012 21:52, schrieb Greg Farnum:
> > On Tuesday, May 22, 2012 at 12:40 PM, Stefan Priebe wrote:
> > Huh. That's less than I would expect. Especially since it ought to =
be going through the page cache.
> > What version of RBD is KVM using here?
> =20
> =20
> v0.47.1
> =20
> > Can you (from the KVM host) run
> > "rados -p data bench seq 60 -t 1"
> > "rados -p data bench seq 60 -t 16"
> > and paste the final output from both?
> =20
> =20
> OK here it is first with write then with seq read.
> =20
> # rados -p data bench 60 write -t 1
> # rados -p data bench 60 write -t 16
> # rados -p data bench 60 seq -t 1
> # rados -p data bench 60 seq -t 16
> =20
> Output is here:
> http://pastebin.com/iFy8GS7i

Heh, yep, sorry about the commands =E2=80=94 haven't run them personall=
y in a while. :)

Anyway, it looks like you're just paying a synchronous write penalty, s=
ince with 1 write at a time you're getting 30-40MB/s out of rados bench=
, but with 16 you're getting >100MB/s. (If you bump up past 16 or incre=
ase the size of each with -b you may find yourself getting even more.)
So try enabling RBD writeback caching =E2=80=94 see http://marc.info/?l=
=3Dceph-devel&m=3D133758599712768&w=3D2
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
