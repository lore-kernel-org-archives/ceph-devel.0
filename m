From: Kevin Decherf <kevin@kdecherf.com>
Subject: Re: Crash and strange things on MDS
Date: Sat, 16 Feb 2013 02:02:18 +0100
Message-ID: <20130216010217.GA26823@kdecherf.com>
References: <20130204180154.GO3286@kdecherf.com>
 <20130211130518.GN6997@kdecherf.com>
 <CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
 <20130211185424.GA27669@kdecherf.com>
 <CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
 <20130213114750.GC7399@kdecherf.com>
 <CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41576 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab3BPBCc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Feb 2013 20:02:32 -0500
Received: by mail-wg0-f42.google.com with SMTP id 12so1348009wgh.3
        for <ceph-devel@vger.kernel.org>; Fri, 15 Feb 2013 17:02:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Wed, Feb 13, 2013 at 10:19:36AM -0800, Gregory Farnum wrote:
> On Wed, Feb 13, 2013 at 3:47 AM, Kevin Decherf <kevin@kdecherf.com> w=
rote:
> > On Mon, Feb 11, 2013 at 12:25:59PM -0800, Gregory Farnum wrote:
> >> On Mon, Feb 11, 2013 at 10:54 AM, Kevin Decherf <kevin@kdecherf.co=
m> wrote:
> >> > Furthermore, I observe another strange thing more or less relate=
d to the
> >> > storms.
> >> >
> >> > During a rsync command to write ~20G of data on Ceph and during =
(and
> >> > after) the storm, one OSD sends a lot of data to the active MDS
> >> > (400Mbps peak each 6 seconds). After a quick check, I found that=
 when I
> >> > stop osd.23, osd.14 stops its peaks.
> >>
> >> This is consistent with Sam's suggestion that MDS is thrashing its
> >> cache, and is grabbing a directory object off of the OSDs. How lar=
ge
> >> are the directories you're using? If they're a significant fractio=
n of
> >> your cache size, it might be worth enabling the (sadly less stable=
)
> >> directory fragmentation options, which will split them up into sma=
ller
> >> fragments that can be independently read and written to disk.
> >
> > I set mds cache size to 400000 but now I observe ~900Mbps peaks fro=
m
> > osd.14 to the active mds, osd.18 and osd.2.
> >
> > osd.14 shares some pg with osd.18 and osd.2:
> > http://pastebin.com/raw.php?i=3DuBAcTcu4
>=20
> The high bandwidth from OSD to MDS really isn't a concern =E2=80=94 t=
hat's the
> MDS asking for data and getting it back quickly! We're concerned abou=
t
> client responsiveness; has that gotten better?

It seems better now, I didn't see any storm so far.

But we observe high latency on some of our clients (with no load). Does
it exist any documentation on how to read the perfcounters_dump output?
I would like to know if the MDS still has any problem with its cache or
if the latency comes from elsewhere.

--=20
Kevin Decherf - @Kdecherf
GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
http://kdecherf.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
