From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Wiping object content on removal
Date: Mon, 23 Nov 2015 09:52:05 -0600
Message-ID: <CAJ4mKGYBzWfd7DB6cj6o0dv8BTP4jkwSFRZGGfNTisdsxp2vDA@mail.gmail.com>
References: <564C8E50.4070503@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33548 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbKWPwH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 10:52:07 -0500
Received: by wmec201 with SMTP id c201so167243881wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 07:52:05 -0800 (PST)
In-Reply-To: <564C8E50.4070503@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Nov 18, 2015 at 8:42 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> Hi Cephers.
>
> Does Ceph have an ability to wipe object content during one's removal?
> Surely one can do that manually from the client but I think that's
> ineffective and not 100% secure.
>
> If no - what's about adding such feature to Ceph?
>  I can start working on that.

Wipe object content during removal of what? The OSD? Or are you
talking about secure erase of object data instead of unlinking files?

I'm not sure if any of that is really more interesting than just
enabling disk encryption...
-Greg
