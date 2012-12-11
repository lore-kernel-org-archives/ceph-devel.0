From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Debian packaging question
Date: Tue, 11 Dec 2012 13:34:29 +0800
Message-ID: <50C6C5E5.6010107@widodh.nl>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:38877 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab2LKFej (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 00:34:39 -0500
In-Reply-To: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, James Page <james.page@ubuntu.com>

Hi,

On 12/11/2012 01:19 PM, Gary Lowell wrote:
> Hi -
>
> I'm looking for advice on debian multiple architecture repositories.  To date we have been building ceph debian packages on two different machines for the i386 and amd64 platforms, rsyncing the results to a common directory on the build host, then putting the results together using the reprepro command to push out to ceph.com.  As all the packages are architecture=linux-any, the arch is embedded in the file names and we don't have any collisions.
>
> The new libcephfs-java, which is architecture=all, ends up being built twice with the same resulting file name, but different checksums depending on where it was built. Not unexpectedly, reprepro complains about this.
>
> I know just enough about debian packaging to be a danger to myself and others. I can see how to fix up the checksums after the fact, but what is the right way to fix the problem ?
>

I assume you are building with "dpkg-buildpackage" ?

The manpage shows:

"-B     Specifies a binary-only build, limited to architecture dependent 
packages.  Passed to dpkg-genchanges."

"-A     Specifies a binary-only build, limited to architecture 
independent packages. Passed to dpkg-genchanges."

So on the i386 and amd64 machines you'd run with -B and sync them to 
ceph.com

On one of the machines you'd also run with -A which should produce the 
architecture independent packages like libcephfs-java.

That's the theory, I haven't tested it :)

Wido

> Thanks,
> Gary
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
