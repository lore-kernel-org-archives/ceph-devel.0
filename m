From: Kevin Decherf <kevin@kdecherf.com>
Subject: Re: Crash and strange things on MDS
Date: Tue, 12 Feb 2013 00:33:05 +0100
Message-ID: <20130211233305.GB553@kdecherf.com>
References: <20130204180154.GO3286@kdecherf.com>
 <20130211130518.GN6997@kdecherf.com>
 <CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
 <20130211185424.GA27669@kdecherf.com>
 <CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
 <20130211222449.GA553@kdecherf.com>
 <CAPYLRzjYwD5nHdcE-p_jjzQWuPLXVfxOzW9O1d6mHKw3ig-jzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:61357 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760215Ab3BKXdJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 18:33:09 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm14so3759726wib.16
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 15:33:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPYLRzjYwD5nHdcE-p_jjzQWuPLXVfxOzW9O1d6mHKw3ig-jzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Mon, Feb 11, 2013 at 02:47:13PM -0800, Gregory Farnum wrote:
> On Mon, Feb 11, 2013 at 2:24 PM, Kevin Decherf <kevin@kdecherf.com> w=
rote:
> > On Mon, Feb 11, 2013 at 12:25:59PM -0800, Gregory Farnum wrote:
> > Yes, there is a dump of 100,000 events for this backtrace in the li=
nked
> > archive (I need 7 hours to upload it).
>=20
> Can you just pastebin the last couple hundred lines? I'm mostly
> interested if there's anything from the function which actually cause=
d
> the assert/segfault. Also, the log should compress well and get much
> smaller!

Sent in pm.

And yes, I have a good compression rate but...

   % ls -lh                            =20
   total 38G
   -rw-r--r-- 1 kdecherf kdecherf 3.3G Feb 11 18:36 cc-ceph-log.tar.gz
   -rw------- 1 kdecherf kdecherf  66M Feb  4 17:57 ceph.log
   -rw-r--r-- 1 kdecherf kdecherf 3.5G Feb  4 14:44 ceph-mds.b.log
   -rw-r--r-- 1 kdecherf kdecherf  31G Feb  5 15:55 ceph-mds.c.log
   -rw-r--r-- 1 kdecherf kdecherf  27M Feb 11 19:46 ceph-osd.14.log

;-)

> > The distribution is heterogeneous: we have a folder of ~17G for 300=
k
> > objects, another of ~2G for 150k objects and a lof of smaller direc=
tories.
>=20
> Sorry, you mean 300,000 files in the single folder?
> If so, that's definitely why it's behaving so badly =E2=80=94 your fo=
lder is
> larger than your maximum cache size settings, and so if you run an
> "ls" or anything the MDS will read the whole thing off disk, then
> instantly drop most of the folder from its cache. Then re-read again
> for the next request to list contents, etc etc.

The biggest top-level folder contains 300k files but splitted into
several subfolders (a subfolder does not contain more than 10,000 files
at its level).

> > Are you talking about the mds bal frag and mds bal split * settings=
?
> > Do you have any advice about the value to use?
> If you set "mds bal frag =3D true" in your config, it will split up
> those very large directories into smaller fragments and behave a lot
> better. This isn't quite as stable (thus the default to "off"), so if
> you have the memory to just really up your cache size I'd start with
> that and see if it makes your problems better. But if it doesn't,
> directory fragmentation does work reasonably well and it's something
> we'd be interested in bug reports for. :)

I will try it, thanks!

--=20
Kevin Decherf - @Kdecherf
GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
http://kdecherf.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
