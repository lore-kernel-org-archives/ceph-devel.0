From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Thu, 28 Oct 2010 19:12:10 -0700
Message-ID: <AANLkTikBSOdfpD5dCpxpRO6imeeGSuMczi6ZRcL348Z8@mail.gmail.com>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
	<1288128642.10847.95.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
	<1288282588.10847.131.camel@sale659.sandia.gov>
	<AANLkTikT8PyiTP4_5rzn3VD_NVpJ-+z6LmyNXCVW2gui@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38844 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab0J2CMM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Oct 2010 22:12:12 -0400
Received: by wyf28 with SMTP id 28so2621585wyf.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Oct 2010 19:12:10 -0700 (PDT)
In-Reply-To: <AANLkTikT8PyiTP4_5rzn3VD_NVpJ-+z6LmyNXCVW2gui@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nat N <phenisha@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Oct 28, 2010 at 6:06 PM, Nat N <phenisha@gmail.com> wrote:
>>> Hi Jim,
>>>
>>> It turns out Henry's problem was actually cause by a bad fix on my =
part,
>>> d91f2438 in ceph-client.git. =A0(Unfortunately that made it into 2.=
6.36!)
>>> Reverting that commit fixed things for him.
>>>
>>> I pushed that revert to the ceph-client.git master branch, or you c=
an
>>> revert it yourself. =A0master also includes everything that's been =
merged
>>> for 2.6.37-rc1, so you may want to revert it yourself and keep the =
2.6.36
>>> stuff.
>>>
>
> How can i revert this if I have simply downloaded the kernel source
> from kernel.org?

This should work:

$ cd ~/linux-2.6.36
$ linux$ wget -O ceph-revert.patch
"http://ceph.newdream.net/git/?p=3Dceph-client.git;a=3Dcommitdiff_plain=
;h=3D2f56f56ad991edd51ffd0baf1182245ee1277a04"
$ patch -p1 < ceph-revert.patch


Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
