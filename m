From: Greg Farnum <greg@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 14:11:31 -0700
Message-ID: <65E9589544C4489F93761035433ADC01@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag>
 <B141A2FBE87F4859AF931D71A339468E@inktank.com>
 <4FBBEBC8.1000205@profihost.ag>
 <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com>
 <4FBBF74C.9020608@profihost.ag>
 <45F1742481D84E7A90951816DB23609F@inktank.com>
 <4FBBFE7B.4060406@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48898 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab2EVVLf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 17:11:35 -0400
Received: by dady13 with SMTP id y13so8770342dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 14:11:35 -0700 (PDT)
In-Reply-To: <4FBBFE7B.4060406@profihost.ag>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Tuesday, May 22, 2012 at 2:00 PM, Stefan Priebe wrote:
> Am 22.05.2012 22:49, schrieb Greg Farnum:
> > Anyway, it looks like you're just paying a synchronous write penalt=
y
> =20
> =20
> What does that exactly mean? Shouldn't one threaded write to four =20
> 260MB/s devices gives at least 100Mb/s?

Well, with dd you've got a single thread issuing synchronous IO request=
s to the kernel. We could have it set up so that those synchronous requ=
ests get split up, but they aren't, and between the kernel and KVM it l=
ooks like when it needs to make a write out to disk it sends one reques=
t at a time to the Ceph backend. So you aren't writing to four 260MB/s =
devices; you are writing to one 260MB/s device without any pipelining =E2=
=80=94 meaning you send off a 4MB write, then wait until it's done, the=
n send off a second 4MB write, then wait until it's done, etc.
=46rankly I'm surprised you aren't getting a bit more throughput than y=
ou're seeing (I remember other people getting much more out of less bee=
fy boxes), but it doesn't much matter because what you really want to d=
o is enable the client-side writeback cache in RBD, which will dispatch=
 multiple requests at once and not force writes to be committed before =
reporting back to the kernel. Then you should indeed be writing to four=
 260MB/s devices at once. :)

> =20
> > since with 1 write at a time you're getting 30-40MB/s out of rados =
bench, but with 16 you're getting>100MB/s.
> > (If you bump up past 16 or increase the size of each with -b you ma=
y =20
> =20
> find yourself getting even more.)
> yep noticed that.
> =20
> > So try enabling RBD writeback caching =E2=80=94 see http://marc.inf=
o/?l=3Dceph-devel&m=3D133758599712768&w=3D2
> will test tomorrow. Thanks.
> =20
> Stefan =20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
