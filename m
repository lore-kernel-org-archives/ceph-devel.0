From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Debian packaging question
Date: Mon, 10 Dec 2012 22:38:40 -0800
Message-ID: <DA10AE5C-66D2-459A-B22F-6444AF107EA9@inktank.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <alpine.DEB.2.00.1212102133040.17288@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:46514 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab2LKGio convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 01:38:44 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1566416dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 22:38:44 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212102133040.17288@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, James Page <james.page@ubuntu.com>


On Dec 10, 2012, at 9:34 PM, Sage Weil wrote:

> On Mon, 10 Dec 2012, Gary Lowell wrote:
>> Hi -
>> 
>> I'm looking for advice on debian multiple architecture repositories.  
>> To date we have been building ceph debian packages on two different 
>> machines for the i386 and amd64 platforms, rsyncing the results to a 
>> common directory on the build host, then putting the results together 
>> using the reprepro command to push out to ceph.com.  As all the packages 
>> are architecture=linux-any, the arch is embedded in the file names and 
>> we don't have any collisions.
>> 
>> The new libcephfs-java, which is architecture=all, ends up being built 
>> twice with the same resulting file name, but different checksums 
>> depending on where it was built. Not unexpectedly, reprepro complains 
>> about this.
> 
> Can we just ignore the second attempt that fails?  Or only try to add the 
> arch=all .dsc once?

For 0.55 that's pretty much what I did and it still required fixing up the changelog checksums before reprepro would run without error.  I was hoping for a cleaner solution.    Wido's suggestion looks like it will allow me to build just one version libcephfs-java, which will help, and shouldn't require much change to the build scripts.

Cheers,
Gary