From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: periodically delays when one of mons dies
Date: Thu, 22 Mar 2012 10:34:42 -0700
Message-ID: <63F3EB16E0CC4D6E9AC1F738A38838F0@dreamhost.com>
References: <CAHULbC=doKVD1Y72qO9kpbi4YoQ6EginOLsbGC_cGrLRPcyV_Q@mail.gmail.com>
 <CAHULbCnLxNd4j9f3Nfa7-hr0DJ8A_b_sge+1haunDqbPbS1siA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60058 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab2CVReq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 13:34:46 -0400
Received: by yenl12 with SMTP id l12so1976960yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 10:34:45 -0700 (PDT)
In-Reply-To: <CAHULbCnLxNd4j9f3Nfa7-hr0DJ8A_b_sge+1haunDqbPbS1siA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday, March 21, 2012 at 8:30 AM, ruslan usifov wrote:
> Hello
> =20
> I'm new to ceph, and perhaps misunderstand some things.
> =20
> I have test configuration with 3 wmvare machines (i test RBD). My set=
up
> consist of:
> =20
> 3: mons
> 3: osd
> =20
> =20
> When i kill one mon (simulate fail), time to time (periodicaly) i got=
 little
> delays when work with RBD device, perhaps this happens when client tr=
y
> failed mon

That's probably the case =E2=80=94 the tools generally pick a random mo=
nitor from the list and time out after 15 seconds if it's not respondin=
g. If you know a monitor is down you can specify one of the others to c=
onnect to with the -m option.
 =20
> , is it possible switch off this failed mon until it fully
> restore.

You could take it out of the daemon's config file, but there's no way f=
or new daemons to avoid trying to talk to down monitors which are in th=
eir config (unless you explicitly specify the mon to connect to, as I s=
aid above) =E2=80=94 the monitor is the first part of the system they t=
alk to, so there's not a way for Ceph itself to propagate information a=
bout down mons.
 =20
> perhaps pacemaker will help in this case + failover ip + somthing
> like proxy which known about mon configuration (i try haproxy but wit=
hout
> success: 1 first of all haproxy doesn't know about live or fail mons =
sof
> delays will happens also ceph doesn't allow this scheme - ie ceph cli=
ent
> check ip address on which it connect and what send to hip mon, and in=
 schem
> with proxy this values doesn't coincide)

Not quite sure what you're saying here=E2=80=A6
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
