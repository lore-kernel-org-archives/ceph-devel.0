From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: defaults paths #2
Date: Fri, 6 Apr 2012 11:00:04 -0700
Message-ID: <CAORUGqD0mpEuNhiRmf5npw3GCR8Za8y+kNtqm2GMm5gNhff2kA@mail.gmail.com>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
 <Pine.LNX.4.64.1204052204290.21401@cobra.newdream.net> <CAORUGqBq93+nWutxEAb=uWmEqCpCPCjcRKrzkTY4rRPMhfX1Vw@mail.gmail.com>
 <Pine.LNX.4.64.1204061038430.3020@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38063 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab2DFSAZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 14:00:25 -0400
Received: by vcqp1 with SMTP id p1so850955vcq.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Apr 2012 11:00:24 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204061038430.3020@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 6, 2012 at 10:55, Sage Weil <sage@newdream.net> wrote:
> Hopefully we can keep things as general as possible, so that brave so=
uls
> can go out of bounds without getting bitten. =C2=A0For example, never=
 parse the
> directory name if the same information can be had from the directory
> contents.

I think one good rule is that we dictate what /var/lib/ceph/osd/*
means and how it behaves, and if you want to do custom things, use
e.g. /srv/example.com/osd/*, disable/usurp the automation where it
doesn't suit you, and use ceph.conf to adjust for the new paths.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
