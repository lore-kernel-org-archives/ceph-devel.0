From: Gregory Farnum <greg@inktank.com>
Subject: Re: Blueprint: Add LevelDB support to ceph cluster backend store
Date: Tue, 30 Jul 2013 22:56:21 -0700
Message-ID: <CAPYLRzgOQ_7_bQBgTW37UFPYxCCQDcvyKmQaf2trXCuL0fO+8Q@mail.gmail.com>
References: <C0D1D705-4B4F-4189-ACBF-4C39D80984DA@gmail.com>
	<kta8j6$51o$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58123 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3GaF4W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 01:56:22 -0400
Received: by mail-wi0-f174.google.com with SMTP id j17so4569067wiw.7
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 22:56:21 -0700 (PDT)
In-Reply-To: <kta8j6$51o$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>, haomaiwang@gmail.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 30, 2013 at 3:54 PM, Alex Elsayed <eternaleye@gmail.com> wrote:
> I posted this as a comment on the blueprint, but I figured I'd say it here:
>
> The thing I'd worry about here is that LevelDB's performance (along with
> that of various other K/V stores) falls off a cliff for large values.
>
> Symas (who make LMDB, used by OpenLDAP) did some benchmarking that shows
> drastic performance loss with 100KB values on both read and write:
> http://symas.com/mdb/microbench/#sec4
>
> It's not just disk latency, either - an SSD showed the same behavior:
> http://symas.com/mdb/microbench/#sec7
>
> I'd recommend REALLY careful benchmarking with a variety of loads (and value
> sizes).

There are various users of leveldb who have tuned it more for
workloads like this; Ryak has some stuff (not sure how much) and I
believe HyperDex has some code changes that do a bunch but include
better support for large writes.
One thing to keep in mind is that we do already have leveldb in the
OSD; it uses that for "omap" and keeping track of a lot of object
metadata and lookaside stuff. I've asked before about using leveldb as
a backing store and the big trouble with it is that it assumes it's
feasible to copy the values it stores several times; with 4MB objects
it really isn't. That doesn't mean it can't be appropriate for other
kinds of workloads, though, and there are several interface layers for
providing a backing store that could make this pluggable.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
