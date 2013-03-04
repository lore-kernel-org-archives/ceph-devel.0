From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 1/3] libceph: drop mutex while allocating a message
Date: Mon, 4 Mar 2013 11:07:28 -0800
Message-ID: <CAPYLRzhQeqbEK6wp+V8OWaAeyML1Uqh60vc0omanTyvCsXtTXQ@mail.gmail.com>
References: <5134E25E.4030701@inktank.com>
	<5134E3AD.4080906@inktank.com>
	<5134E3F1.70008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:39689 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab3CDTH3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 14:07:29 -0500
Received: by mail-qa0-f53.google.com with SMTP id z4so1385056qan.5
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 11:07:28 -0800 (PST)
In-Reply-To: <5134E3F1.70008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 4, 2013 at 10:12 AM, Alex Elder <elder@inktank.com> wrote:
> In ceph_con_in_msg_alloc(), if no alloc_msg method is defined for a
> connection a new message is allocated with ceph_msg_new().
>
> Drop the mutex before making this call, and make sure we're still
> connected when we get it back again.

Why do we need to drop the mutex at all? The mds_alloc_msg() that
you're about to define doesn't seem to need it.
-Greg
