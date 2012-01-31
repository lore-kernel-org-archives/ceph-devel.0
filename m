From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: autogen.sh error
Date: Tue, 31 Jan 2012 14:36:59 -0800
Message-ID: <CAORUGqAAXDZM9h85i326cmLdJ4yzuPN16nZfZqr0iW0OW3RUQA@mail.gmail.com>
References: <4F2867A7.4040005@cirrhus9.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64934 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab2AaWhU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 17:37:20 -0500
Received: by werb13 with SMTP id b13so468231wer.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 14:37:19 -0800 (PST)
In-Reply-To: <4F2867A7.4040005@cirrhus9.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: JJ <jjones@cirrhus9.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 31, 2012 at 14:13, JJ <jjones@cirrhus9.com> wrote:
> I keep getting errors and I am not sure how I can satisfy this?
> CentOS 5.5 x86_64 / 2.6.18-194.32.1.el5xen

Starting from a fresh tarball / git clone, what commands did you run?

gtest is bundled in the source, as recommended by upstream, so it's
not a build dependency. However, it is not "properly" integrated into
the top-level automake/autoconf, as we don't want to run its unit
tests all the time, hence we've seen error like what you describe
happen sometimes. But with this limitation, it's dependencies are not
100% correct, so some times things try to use it before it's built.

google-perftools is mostly about tcmalloc. The "isa" variables means
the instruction set architecture of the host, to force dependency on
exactly the right kind of package.
