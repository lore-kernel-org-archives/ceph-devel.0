From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph version 0.56.1, data loss on power failure
Date: Thu, 10 Jan 2013 14:12:06 -0800
Message-ID: <CAPYLRzje19sAjtyRq8PX2zV0=GHpnzWdqOMk04UVUaRn2T7TOg@mail.gmail.com>
References: <CA+-7kDCRhRnijbEt2NxX2BgAqfF5fLaXoMOB7VUTCpeTgn9X9Q@mail.gmail.com>
	<CAF6-1L7otPweDqmq-MzEnO+TU5aHSZ3JKW+SaqG740Hw5q9ULA@mail.gmail.com>
	<CA+-7kDAxr7pa2MsVxsdxH5BLghDwDMs+SrKZhpAcJSjXwG=RuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:52793 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab3AJWMH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 17:12:07 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so1014044qad.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 14:12:06 -0800 (PST)
In-Reply-To: <CA+-7kDAxr7pa2MsVxsdxH5BLghDwDMs+SrKZhpAcJSjXwG=RuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcin Szukala <szukala.marcin@gmail.com>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 10, 2013 at 8:56 AM, Marcin Szukala
<szukala.marcin@gmail.com> wrote:
> Hi,
>
> Scenario is correct but the last line. I can mount the image, but the
> data that was written to the image before power failure is lost.
>
> Currently the ceph cluster is not healthy, but i dont think its
> related because I had this issue before the cluster itsef had issues
> (about that I will write in different post not to mix topics).

This sounds like one of two possibilities:
1) You aren't actually committing data to RADOS very often and so when
the power fails you lose several minutes of writes. How much data are
you losing, how's it generated, and is whatever you're doing running
any kind of fsync or sync? And what filesystem are you using?
2) Your cluster is actually not accepting writes and so RBD never
manages to do a write but you aren't doing much and so you don't
notice. What's the output of ceph -s?
-Greg
