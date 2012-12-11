From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Debian packaging question
Date: Mon, 10 Dec 2012 22:32:22 -0800
Message-ID: <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <50C6C5E5.6010107@widodh.nl>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56710 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab2LKGc2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 01:32:28 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2635959pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 22:32:27 -0800 (PST)
In-Reply-To: <50C6C5E5.6010107@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, James Page <james.page@ubuntu.com>


On Dec 10, 2012, at 9:34 PM, Wido den Hollander wrote:

> Hi,
> 
> On 12/11/2012 01:19 PM, Gary Lowell wrote:
>> Hi -
>> 
>> I'm looking for advice on debian multiple architecture repositories.  To date we have been building ceph debian packages on two different machines for the i386 and amd64 platforms, rsyncing the results to a common directory on the build host, then putting the results together using the reprepro command to push out to ceph.com.  As all the packages are architecture=linux-any, the arch is embedded in the file names and we don't have any collisions.
>> 
>> The new libcephfs-java, which is architecture=all, ends up being built twice with the same resulting file name, but different checksums depending on where it was built. Not unexpectedly, reprepro complains about this.
>> 
>> I know just enough about debian packaging to be a danger to myself and others. I can see how to fix up the checksums after the fact, but what is the right way to fix the problem ?
>> 
> 
> I assume you are building with "dpkg-buildpackage" ?
> 
> The manpage shows:
> 
> "-B     Specifies a binary-only build, limited to architecture dependent packages.  Passed to dpkg-genchanges."
> 
> "-A     Specifies a binary-only build, limited to architecture independent packages. Passed to dpkg-genchanges."
> 
> So on the i386 and amd64 machines you'd run with -B and sync them to ceph.com
> 
> On one of the machines you'd also run with -A which should produce the architecture independent packages like libcephfs-java.
> 
> That's the theory, I haven't tested it :)
> 
> Wido

Thanks Wido.  We're using pbuilder, but it looks like it has similar options, or can pass an option string to dpkg_buildpackage.   I'll do some testing.

Cheers,
Gary