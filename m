From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 3 Mar 2011 12:55:45 -0800
Message-ID: <AANLkTikmVL8soYOR3nQyD3=FXjv-aurcydAVvJVvAOJR@mail.gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
	<75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
	<1297893011.25491.124.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
	<Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
	<1297957574.25491.152.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
	<1298483538.25491.233.camel@sale659.sandia.gov>
	<460F770CEB1C499F8B87593762171483@gmail.com>
	<1298489031.25491.250.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
	<1299079262.4750.19.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
	<1299099295.4750.41.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
	<1299103144.4750.49.camel@sale659.sandia.gov>
	<1299106628.4750.62.camel@sale659.sandia.gov>
	<AANLkTikU_F_mRaYC6xE5V9OHaDbyjWJ7fnpVCXkz=tK=@mail.gmail.com>
	<1299182603.4750.128.camel@sale659.sandia.gov>
	<1299185234.4750.137.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56659 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251Ab1CCUzr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:55:47 -0500
Received: by wyg36 with SMTP id 36so1482218wyg.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Mar 2011 12:55:46 -0800 (PST)
In-Reply-To: <1299185234.4750.137.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Colin McCabe <cmccabe@alumni.cmu.edu>, Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 3, 2011 at 12:47 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Has something maybe changed in signal handling recently?
>
> Maybe SIGPIPE used to be blocked, and sendmsg() would
> return -EPIPE, but now it's not blocked and not handled?
>
> This bit in linux-2.6.git/net/core/stream.c is what made
> me wonder, but maybe it's a red herring:
>
> int sk_stream_error(struct sock *sk, int flags, int err)
> {
> =A0 =A0 =A0 =A0if (err =3D=3D -EPIPE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D sock_error(sk) ? : -EPIPE;
> =A0 =A0 =A0 =A0if (err =3D=3D -EPIPE && !(flags & MSG_NOSIGNAL))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0send_sig(SIGPIPE, current, 0);
> =A0 =A0 =A0 =A0return err;
> }

It was actually just changed at
35c4a9ffeadfe202b247c8e23719518a874f54e6, so if you're on latest
master then it might be it. You can try reverting that commit, or can
try this:

index da22c7c..6f746d4 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -1991,7 +1991,7 @@ int SimpleMessenger::Pipe::do_sendmsg(int sd,
struct msghdr *msg, int len, bool
       assert(l =3D=3D len);
     }

-    int r =3D ::sendmsg(sd, msg, more ? MSG_MORE : 0);
+    int r =3D ::sendmsg(sd, msg, MSG_NOSIGNAL | (more ? MSG_MORE : 0))=
;
     if (r =3D=3D 0)
       dout(10) << "do_sendmsg hmm do_sendmsg got r=3D=3D0!" << dendl;
     if (r < 0) {


Yehuda
>
> -- Jim
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
