From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: mds crash on snaptest-2
Date: Tue, 27 Jul 2010 12:54:57 -0700
Message-ID: <AANLkTinM5e1024M+rg9GBym-MsdQ0qmh++Ywa-pcWOZ-@mail.gmail.com>
References: <i21p5k$fma$2@dough.gmane.org>
	<AANLkTinxy56sN1K39-1z0AtcYWBI0ndPZQnlZzgaG0xx@mail.gmail.com>
	<i2m8g9$53k$2@dough.gmane.org>
	<AANLkTimrW=DquX_Pyi8M7wb_GWV1DJr6w28LTOC9RkfD@mail.gmail.com>
	<4C4F3876.3030306@chaschperli.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40112 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab0G0Ty7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jul 2010 15:54:59 -0400
Received: by fxm14 with SMTP id 14so878482fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jul 2010 12:54:58 -0700 (PDT)
In-Reply-To: <4C4F3876.3030306@chaschperli.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Tue, Jul 27, 2010 at 12:50 PM, Thomas Mueller <thomas@chaschperli.ch=
> wrote:
> i'm =A0always starting just one daemon. my test script sets these var=
s before
> calling "vstart.sh":
>
> export CEPH_NUM_MON=3D1
> export CEPH_NUM_OSD=3D1
> export CEPH_NUM_MDS=3D1
>
> last known good rev was =A0ae82dd5a5c964bb310a5512d10d1e062cbb0c1a5 o=
n July 8
> - with this rev the test was working fine.
>
> i've also tried to compile with "-O0" to run it with gdb (not that i'=
m a gdb
> expert..) - but the binaries failed to start (ok back then it was bit=
 late
> ...)
Huh. Can you double check that you have the latest code? Specifically,
it needs to include commit e2b1a4ee119a68b403582ae3bc15b54e9458b9b5.
I've run your test a number of times under cfuse and haven't gotten
any single-MDS crashes or hangs with that.

Are you running it under the kclient or cfuse?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
