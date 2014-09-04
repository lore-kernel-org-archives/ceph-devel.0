From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] daemons: write pid file even when told not to daemonize
Date: Thu, 04 Sep 2014 16:48:04 -0300
Message-ID: <ortx4n416z.fsf@free.home>
References: <or4mxyuvo4.fsf@free.home> <53D9C379.9070904@dachary.org>
	<alpine.DEB.2.00.1407302129530.18917@cobra.newdream.net>
	<or7g1tawy9.fsf@free.home> <53FEE3B8.4070902@dachary.org>
	<oriolbajch.fsf@free.home> <54003C8B.8090000@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:60611 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbaIDTuf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Sep 2014 15:50:35 -0400
In-Reply-To: <54003C8B.8090000@dachary.org> (Loic Dachary's message of "Fri,
	29 Aug 2014 10:40:43 +0200")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

On Aug 29, 2014, Loic Dachary <loic@dachary.org> wrote:

> After a quick glance at the systemd man page http://www.freedesktop.o=
rg/software/systemd/man/systemd.service.html#Options it seems possible =
to do something like

>     https://github.com/dachary/ceph/compare/wip-systemd?expand=3D1

Yeah, it sure is possible in systemd to start and track daemons that
don't have a =E2=80=9Crun in foreground=E2=80=9D option, but it's not a=
s efficient.

> Alternatively, shouldn't systemctl kill ceph-osd@10.service be the ca=
nonical way of killing a process spawned by systemd ?

If you know what number to use after @, I guess it would.  I don't thin=
k
we're talking about the same version of ceph, when it comes to systemd
config files.  Your patch doesn't modify any file present on my system
(still running 0.80.5)

> If both are impractical or frowned upon for some reason, it looks lik=
e
> your patch is the only way to go, indeed.

It's certainly not the only way to go, but silently dropping a command
line option sounds like a bug to me.  Of course the patch I proposed
isn't the only way to go about that...

--=20
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
=46ree Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
