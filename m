From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Compiling for FreeBSD, missing rbd
Date: Thu, 3 Dec 2015 14:34:19 +0200
Message-ID: <20151203123416.GA16372@gmail.com>
References: <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <565D7FA8.3010301@digiware.nl>
 <alpine.DEB.2.00.1512010529280.19170@cobra.newdream.net>
 <565DA3B5.1070608@digiware.nl>
 <alpine.DEB.2.00.1512010634510.19170@cobra.newdream.net>
 <565DC9D4.7060701@digiware.nl>
 <565DEC36.10102@digiware.nl>
 <565F5E28.8020706@digiware.nl>
 <565F74E8.1070109@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36402 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbLCMeX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 07:34:23 -0500
Received: by lfs39 with SMTP id 39so85827520lfs.3
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 04:34:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <565F74E8.1070109@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Dec 02, 2015 at 11:47:04PM +0100, Willem Jan Withagen wrote:
> 
> Running gmake check is starting to work.
> 	reporting still thinks there are no successful tests
> 	but tests themselves report OKE
> 
> But where I really can not get it to work is with testing rbd.
> 
> Is starts with the simple:
> 	 /bin/sh: rbd: not found
> 
> And whatever I'm trying in configure, no way am I able to get either an
> executable or a script that will do rbd....
> 
> So how do I get a rbd that can be used in the tests.

On the master rbd is built on Linux only, see src/tools/Makefile-client.am.

I have a patch in my branch that makes rbd build on all platforms
(excluding kernel bits):

https://github.com/trociny/ceph/commit/cd427e3ef2a5a307d6649e5b1dcfefdf67d60b29

But large rbd refactoring has happened in master since that time, and
my patch requires some work to apply on the current master.

-- 
Mykola Golub
