From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: how to mount a specific pool in cephs
Date: Mon, 30 Apr 2012 10:40:17 -0700
Message-ID: <CAORUGqCMGZeVRO_dB7GEt8NJ=M63NZNejUMT75LEPFM3MaJVoA@mail.gmail.com>
References: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60380 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab2D3Rki convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 13:40:38 -0400
Received: by vbbff1 with SMTP id ff1so2224756vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 10:40:37 -0700 (PDT)
In-Reply-To: <81C477727102DA4E9B2605AC748C495418EE10F2E4@exch10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Apr 29, 2012 at 23:16, Paul Pettigrew
<Paul.Pettigrew@mach.com.au> wrote:
> I cannot find the right syntax to mount a specific pool created, that=
 has a customised replica level set, which is different to the default =
"data" pool (i.e. we have an additional pool called "backup"). Can some=
body please advise the right syntax??
>
> I tried the following per: http://ceph.newdream.net/docs/master/man/8=
/mount.ceph/
> =C2=A0 =C2=A0mount -t ceph 10.32.0.10:6789:/backup /mnt/ceph -vv -o n=
ame=3Dadmin,secret=3DThisIsNotTheRealSecret=3D=3D
> And it hard-hung the server, and needed a hard power restart (ouch!).
>
> The following works fine, but it is not connecting to the "backup" po=
ol (with no pool name specified, it is going to pool0 called "data"):
> =C2=A0 =C2=A0mount -t ceph 10.32.0.10:6789:/ /mnt/ceph -vv -o name=3D=
admin,secret=3DThisIsNotTheRealSecret=3D=3D

You don't mount pools directly; there's filesystem metadata (as
managed by metadata servers) that is needed too.

What you probably want is to specify that a subtree of your ceph dfs
stores the file data in a separate pool, using "cephfs
/mnt/ceph/some/subtree set_layout --pool 6". Note that a numerical
pool id is currently required.

http://ceph.newdream.net/docs/master/man/8/cephfs/

You can mount any subtree of the ceph dfs directly, using
10.32.0.10:6789:/some/subtree in your mount command.


The crash you experienced may be completely separate from this, but if
any logs survived, filing a bug would be appreciated.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
