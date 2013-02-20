From: Kevin Decherf <kevin@kdecherf.com>
Subject: Re: Crash and strange things on MDS
Date: Wed, 20 Feb 2013 02:00:52 +0100
Message-ID: <20130220010052.GO7121@kdecherf.com>
References: <20130211130518.GN6997@kdecherf.com>
 <CAKMAVE_J4GOA_yUF5ue-y+_iFVhbvCqaGPvBOfgtEuO7CzRU6g@mail.gmail.com>
 <20130211185424.GA27669@kdecherf.com>
 <CAPYLRzjZgTH5PaDTXSxJz8fW6arqUpOLdnKBHrcv4vohggZLVQ@mail.gmail.com>
 <20130213114750.GC7399@kdecherf.com>
 <CAPYLRzhYWzvq6-Tp5uCJWc9tHAB2WFXFCDZ7ETyQgQwvSB1c+Q@mail.gmail.com>
 <20130216010217.GA26823@kdecherf.com>
 <CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
 <20130216182403.GB5313@kdecherf.com>
 <CAPYLRzibP6m3iEBMLs-B2u8t-cjv5-BE8_58dh55h7V2kzXSfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50705 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933751Ab3BTBBF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 20:01:05 -0500
Received: by mail-wi0-f178.google.com with SMTP id o1so5586632wic.11
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 17:01:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPYLRzibP6m3iEBMLs-B2u8t-cjv5-BE8_58dh55h7V2kzXSfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Tue, Feb 19, 2013 at 10:15:48AM -0800, Gregory Farnum wrote:
> Looks like you've got ~424k dentries pinned, and it's trying to keep
> 400k inodes in cache. So you're still a bit oversubscribed, yes. This
> might just be the issue where your clients are keeping a bunch of
> inodes cached for the VFS (http://tracker.ceph.com/issues/3289).

Thanks for the analyze. We use only one ceph-fuse client at this time
which makes all "high-load" commands like rsync, tar and cp on a huge
amount of files. Well, I will replace it by the kernel client.

After some tests we increased the mds cache size to 900k.

-- 
Kevin Decherf - @Kdecherf
GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
http://kdecherf.com
