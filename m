From: Sage Weil <sage@newdream.net>
Subject: Re: Status of ceph ITP?
Date: Mon, 29 Nov 2010 11:24:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
References: <1290365977.9821.3.camel@clint-MacBookPro>
 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
 <1290436452.9821.5.camel@clint-MacBookPro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51159 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab0K2TUL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Nov 2010 14:20:11 -0500
In-Reply-To: <1290436452.9821.5.camel@clint-MacBookPro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Clint Byrum <clint@ubuntu.com>
Cc: asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, gcs@debian.hu, ceph-devel@vger.kernel.org

Hi Clint,

On Mon, 22 Nov 2010, Clint Byrum wrote:
> Yes we'd much rather have a single package that works in both Debian and
> Ubuntu.
> 
> If you know exactly what package is being looked at for upload into
> Debian, I can at least start with that so that the merge when it finally
> does get uploaded is much simpler.

The current latest is at

 http://ceph.newdream.net/debian/pool/ceph-stable/c/ceph/ceph_0.23.1-1.dsc

As I understand it, the current issues are:
 - whitespace in debian/rules
 - something with the .install files and installing into the source tree 
that I didn't understand.. can you clarify Laszlo?

Thanks!
sage
