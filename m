From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH 5/5] qemu/rbd: improve rbd device specification
Date: Fri, 16 Sep 2011 10:11:51 -0700
Message-ID: <CAORUGqBCbSNnpWK67b90-9ppnL5GbKmaF5fwYtAu9hARHnkTLg@mail.gmail.com>
References: <1316119944-25201-1-git-send-email-sage@newdream.net>
 <1316119944-25201-6-git-send-email-sage@newdream.net> <CAORUGqB9aAPTiRHKsuz5Rn-qcSy6JwT_5foMTu4q4GmA8FMW4A@mail.gmail.com>
 <Pine.LNX.4.64.1109161000260.11043@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f180.google.com ([74.125.82.180]:56907 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423Ab1IPRMM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2011 13:12:12 -0400
Received: by wyj26 with SMTP id 26so4998110wyj.11
        for <ceph-devel@vger.kernel.org>; Fri, 16 Sep 2011 10:12:11 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1109161000260.11043@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Fri, Sep 16, 2011 at 10:01, Sage Weil <sage@newdream.net> wrote:
>> If I'm reading this right, that puts the ceph secret on the kvm
>> command line. That's not good, that makes it visible to anyone on the
>> host.
> Yeah, we definitely want something better, but I wanted to make sure the
> overall approach is fine before doing something too annoying with
> temporary unlinked files or environment variables or something.

That sounds good. Except for the environment variables part; while
some effort is put into guarding the environment, there have been
several ways of reading other processes' environment, historically. I
wouldn't rely on environment to stay secret, ever.
