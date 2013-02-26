From: Kevin Decherf <kevin@kdecherf.com>
Subject: Re: Crash and strange things on MDS
Date: Tue, 26 Feb 2013 18:57:42 +0100
Message-ID: <20130226175742.GE16091@kdecherf.com>
References: <20130211185424.GA27669@kdecherf.com>
 <CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
 <20130213114750.GC7399@kdecherf.com>
 <CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
 <20130216010217.GA26823@kdecherf.com>
 <CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
 <20130216182403.GB5313@kdecherf.com>
 <CAPYLRzibP6m3iEBMLs-B2u8t-cjv5-BE8_58dh55h7V2kzXSfQ@mail.gmail.com>
 <20130220010052.GO7121@kdecherf.com>
 <CAPYLRzgkR61eFuGU_NdL88bJvOD2em+TMO7g1g+X3RTFAZvY5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55252 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab3BZR6F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 12:58:05 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so3666557wgb.35
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 09:58:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPYLRzgkR61eFuGU_NdL88bJvOD2em+TMO7g1g+X3RTFAZvY5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Tue, Feb 19, 2013 at 05:09:30PM -0800, Gregory Farnum wrote:
> On Tue, Feb 19, 2013 at 5:00 PM, Kevin Decherf <kevin@kdecherf.com> wrote:
> > On Tue, Feb 19, 2013 at 10:15:48AM -0800, Gregory Farnum wrote:
> >> Looks like you've got ~424k dentries pinned, and it's trying to keep
> >> 400k inodes in cache. So you're still a bit oversubscribed, yes. This
> >> might just be the issue where your clients are keeping a bunch of
> >> inodes cached for the VFS (http://tracker.ceph.com/issues/3289).
> >
> > Thanks for the analyze. We use only one ceph-fuse client at this time
> > which makes all "high-load" commands like rsync, tar and cp on a huge
> > amount of files. Well, I will replace it by the kernel client.
> 
> Oh, that bug is just an explanation of what's happening; I believe it
> exists in the kernel client as well.

After setting the mds cache size to 900k, storms are gone.
However we continue to observe high latency on some clients (always the
same clients): each IO takes between 40 and 90ms (for example with
Wordpress, it takes ~20 seconds to load all needed files...).
With a non-laggy client, IO requests take less than 1ms.

-- 
Kevin Decherf - @Kdecherf
GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
http://kdecherf.com
