From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Mon backing store
Date: Thu, 5 Jun 2014 11:19:37 -0700
Message-ID: <CABBk=J9dfAXHcYPYzcu0ipAnzretOMWE3wHhtXVa1oYSzvF1zA@mail.gmail.com>
References: <CA+4uBUZaFHhyn9Brx=dM08qFgPFQiAohufpVk+GH5zCR9Hzb0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:42106 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbaFESTi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 14:19:38 -0400
Received: by mail-vc0-f177.google.com with SMTP id hy4so1597562vcb.8
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jun 2014 11:19:37 -0700 (PDT)
In-Reply-To: <CA+4uBUZaFHhyn9Brx=dM08qFgPFQiAohufpVk+GH5zCR9Hzb0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 5, 2014 at 10:42 AM, Samuel Just <sam.just@inktank.com> wrote:
> I am starting to wonder whether using leveldb for the mon is actually
> introducing an excessive amount unnecessary complexity and
> non-determinism.  Given that the monitor workload is read mostly,
> except for failure conditions when it becomes write latency sensitive,
> might we do better with a strict b-tree style backing db such as
> berkely db even at the cost of some performance?  It seems like
> something like that might provide more reliable latency properties.
>
> Thoughts?

Whichever route we're taking it'd be nice if it would have been
abstracted more cleanly, and make it pluggable.

Yehuda
