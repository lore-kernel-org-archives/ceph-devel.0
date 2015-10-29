From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: civetweb upstream/downstream divergence
Date: Thu, 29 Oct 2015 10:58:07 -0700
Message-ID: <CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com>
References: <5631E4A5.9020003@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34189 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbbJ2R6I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Oct 2015 13:58:08 -0400
Received: by vkgs66 with SMTP id s66so31998047vkg.1
        for <ceph-devel@vger.kernel.org>; Thu, 29 Oct 2015 10:58:07 -0700 (PDT)
In-Reply-To: <5631E4A5.9020003@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 29, 2015 at 2:19 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi Ceph:
>
> The civetweb code in RGW is taken from https://github.com/ceph/civetweb/
> which is a fork of https://github.com/civetweb/civetweb. The last commit
> to our fork took place on March 18.
>
> Upstream civetweb development has progressed ("This branch is 19 commits
> ahead, 972 commits behind civetweb:master.")
>
> Are there plans to rebase to a newer upstream version or should we think
> more in terms of backporting (to ceph/civetweb.git) from upstream
> (civetweb/civetweb.git) when we need to fix bugs or add features?
>
> Thanks and regards
>

We should definitely do it. We're based off civetweb 1.6, and there
was no official civetweb version for quite a while, but 1.7 was tagged
a few months ago. I made some effort and got most of our material
changes upstream, however, there are some changes that might need some
more work before we can get them merged, or might not make complete
sense at all. iirc, the biggest change that would be challenging to
get upstream is the chunked encoding handling that we have. Other than
that there are a few minor changes that we did to make rgw with
civetweb behave more like rgw over mod_fastcgi, build related changes,
and some more trivial stuff.

Yehuda
