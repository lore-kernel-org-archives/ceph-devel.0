From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD, Bluestore requires AIO
Date: Mon, 18 Jan 2016 11:05:28 +0100
Message-ID: <569CB8E8.5080908@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com>
 <alpine.DEB.2.00.1511300518210.19170@cobra.newdream.net>
 <5698CF58.7020206@digiware.nl>
 <alpine.DEB.2.11.1601151229030.17315@cpach.fuggernut.com>
 <56993BB5.7070302@digiware.nl> <20160118095454.GA30351@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:34159 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048AbcARKFk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Jan 2016 05:05:40 -0500
In-Reply-To: <20160118095454.GA30351@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Sage Weil <sage@newdream.net>, "Yan, Zheng" <ukernel@gmail.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 18-1-2016 10:54, Mykola Golub wrote:
> On Fri, Jan 15, 2016 at 07:34:29PM +0100, Willem Jan Withagen wrote:
> 
>> ATM I've excluded the building of Bluestore, not really knowing how hard
>> that is going to bite me in run the tests.
> 
> It looks like you have figured out how to exclude building Bluestore,
> but just in case, I have the following PR open, that do the same:
> 
> https://github.com/ceph/ceph/pull/7169
> 

I'd say: lgtm.... :)

The one thing to debate is to not make it depend on HAVE_LIBAIO, but
make it depend on a new configflag: WITH_BLUESTORE.

That even allows to include LIBAIO for the old stuff, and still run
without BlueStore.

And I patched configure.ac for that:
194,201d193
< # bluestore?
< AC_ARG_WITH([bluestore],
<       [AS_HELP_STRING([--with-bluestore], [build bluestore files])],
<       [],
<       [with_bluestore=yes])
< AM_CONDITIONAL(WITH_BLUESTORE, test "$with_bluestore" = "yes")
< #AS_IF([test "$with_bluestore" = "yes"],[AC_DEFINE([WITH_BLUESTORE])])
<


--WjW

