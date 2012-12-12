From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Debian packaging question
Date: Wed, 12 Dec 2012 15:38:47 -0800
Message-ID: <95BEC6FE-ECFA-4106-BF1F-C4BD43819602@inktank.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <50C6C5E5.6010107@widodh.nl> <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com> <50C705A9.1030603@ubuntu.com> <7A33695B-249B-4638-94BF-BC3BD283216B@inktank.com> <50C864A8.1010707@ubuntu.com> <alpine.DEB.2.00.1212120742140.8754@cobra.newdream.net> <50C90293.4060407@ubuntu.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:34467 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab2LLXix convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 18:38:53 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so453491dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 15:38:53 -0800 (PST)
In-Reply-To: <50C90293.4060407@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>
Cc: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>


On Dec 12, 2012, at 2:17 PM, James Page wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> On 12/12/12 15:44, Sage Weil wrote:
>>>> Gah - this will bite when I do the next upload to Ubuntu as
>>>> well then; Can I suggest that we rework debian/rules for
>>>> debhelper >= 7 and use overrides rather than the current 'old
>>>> style' rules which define all tasks?  I was toying with doing
>>>> this anyway (and have it working locally) - it does cut out
>>>> some of the content from d/rules and makes it a bit more
>>>> *magic*
>>>> 
>>>> Thoughts?  I'm happy to raise a pull request for this.
>> Yes, please!  In the meantime, does build-indep sound like a valid
>> workaround?  (This hiccup has been delaying some simple fixes in
>> 0.55.1, but unless there is a quick fix I think we'll just release
>> it without the java bindings for now to get those fixes out to
>> people.)
> 
> Try this -
> https://github.com/javacruft/ceph/commit/eb9516b92fbf1d09376ad86bc081d927f47656c0
> 
> I've given it a quick sniff locally to check the package build process
> generates the arch:all packages when requested (and does not when a
> architecture specific build is requested).
> 

Hi James -

I took your new rules file out for a spin.  It built ok, but we still got the libcephfs-java_0.55.1-1precise_all.deb built despite the --binary-arch flag.  The command used for the build is:

sudo pbuilder build --binary-arch --debug --distribution precise --basetgz /srv/debian-base/precise.tgz --buildresult /tmp/release/0.55.1/ --debbuildopts '-j8 -b' /tmp/release/0.55.1/ceph_0.55.1-1precise.dsc

And the log shows the -B option on dpkg-buildpackage:

I: Building the package
I: Running cd tmp/buildd/*/ && env PATH="/usr/lib/ccache:/usr/sbin:/usr/bin:/sbin:/bin" dpkg-buildpackage -us -uc   -B -j8 -b -rfakeroot

I'm not sure what to look at next.

Thanks,
Gary

