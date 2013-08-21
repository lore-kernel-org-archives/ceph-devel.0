From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: subdir-objects
Date: Wed, 21 Aug 2013 22:13:12 +0200
Message-ID: <CAN04cT7DRHvuAupyGppawYbbiJJX3b2VRd0D=UvHw-4uvvURRQ@mail.gmail.com>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
	<CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:34997 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab3HUUNN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 16:13:13 -0400
Received: by mail-oa0-f45.google.com with SMTP id m6so1836815oag.18
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 13:13:12 -0700 (PDT)
In-Reply-To: <CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Wed, Aug 21, 2013 at 10:01 PM, Noah Watkins <noah.watkins@inktank.com> wrote:
> This patch will turn on the option (which should also fix your problem
> if I understand correctly?), and should probably be committed anyway
> as newer versions of autotools will complain loudly about our current
> Makefile structure.

The patch is indeed quite trivial, and I already enabled it for my own
dev branches, but I like it to be upstream or else my code could never
be pulled :-)

> I believe it is just historical, and unfortunately has just been
> repeated over and over. Ideally I think that there should be a
> restructuring to place a Makefile.am in every subdirectory. This would
> address your issue and make it significantly easier to deal with
> situations where we want to build a subset of Ceph, such as just FUSE
> and librados, for example.

I agree. Is there already a project running for this?

(I feel like I'm hitting depedency after dependency... I started out
trying to implement RGW S3 Keystone support, for that I noticed that
plugins would be really nice, and now I'm hitting automake issues
:-)... Mayby someday I'll finish something useful hehe)

Roald
