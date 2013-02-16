From: Kevin Decherf <kevin@kdecherf.com>
Subject: Re: Crash and strange things on MDS
Date: Sat, 16 Feb 2013 19:24:03 +0100
Message-ID: <20130216182403.GB5313@kdecherf.com>
References: <20130204180154.GO3286@kdecherf.com>
 <20130211130518.GN6997@kdecherf.com>
 <CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
 <20130211185424.GA27669@kdecherf.com>
 <CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
 <20130213114750.GC7399@kdecherf.com>
 <CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
 <20130216010217.GA26823@kdecherf.com>
 <CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:62144 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab3BPSYM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 13:24:12 -0500
Received: by mail-wg0-f51.google.com with SMTP id 8so3525331wgl.18
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 10:24:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Sat, Feb 16, 2013 at 11:36:09AM -0600, Sam Lang wrote:
> On Fri, Feb 15, 2013 at 7:02 PM, Kevin Decherf <kevin@kdecherf.com> wrote:
> > It seems better now, I didn't see any storm so far.
> >
> > But we observe high latency on some of our clients (with no load). Does
> > it exist any documentation on how to read the perfcounters_dump output?
> > I would like to know if the MDS still has any problem with its cache or
> > if the latency comes from elsewhere.
> 
> You can use perfcounters_schema to get the output format in json,
> using something like json_pp to make it somewhat readable for a human.
>  You can post the dump output as well and we can try to help you
> parse/understand what its telling you.

Ok, thanks.

Here you will find the output of perfcounters_dump on the active MDS:
http://pastebin.com/raw.php?i=BNerQ2fL

-- 
Kevin Decherf - @Kdecherf
GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
http://kdecherf.com
