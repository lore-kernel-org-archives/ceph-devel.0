From: Kevin Decherf <kevin@kdecherf.com>
Subject: Re: Crash and strange things on MDS
Date: Wed, 13 Feb 2013 12:47:50 +0100
Message-ID: <20130213114750.GC7399@kdecherf.com>
References: <20130204180154.GO3286@kdecherf.com>
 <20130211130518.GN6997@kdecherf.com>
 <CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
 <20130211185424.GA27669@kdecherf.com>
 <CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:40570 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab3BMLr4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 06:47:56 -0500
Received: by mail-wg0-f46.google.com with SMTP id fg15so872121wgb.13
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 03:47:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Mon, Feb 11, 2013 at 12:25:59PM -0800, Gregory Farnum wrote:
> On Mon, Feb 11, 2013 at 10:54 AM, Kevin Decherf <kevin@kdecherf.com> wrote:
> > Furthermore, I observe another strange thing more or less related to the
> > storms.
> >
> > During a rsync command to write ~20G of data on Ceph and during (and
> > after) the storm, one OSD sends a lot of data to the active MDS
> > (400Mbps peak each 6 seconds). After a quick check, I found that when I
> > stop osd.23, osd.14 stops its peaks.
> 
> This is consistent with Sam's suggestion that MDS is thrashing its
> cache, and is grabbing a directory object off of the OSDs. How large
> are the directories you're using? If they're a significant fraction of
> your cache size, it might be worth enabling the (sadly less stable)
> directory fragmentation options, which will split them up into smaller
> fragments that can be independently read and written to disk.

I set mds cache size to 400000 but now I observe ~900Mbps peaks from
osd.14 to the active mds, osd.18 and osd.2.

osd.14 shares some pg with osd.18 and osd.2:
http://pastebin.com/raw.php?i=uBAcTcu4


-- 
Kevin Decherf - @Kdecherf
GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
http://kdecherf.com
