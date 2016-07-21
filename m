From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Pool creation fails: 'failed run crushtool: fork failed: (12)
 Cannot allocate memory'
Date: Thu, 21 Jul 2016 11:01:01 -0700
Message-ID: <CAJ4mKGaCvH9uj49340wXqLr5fScBYjRqh7YosGH48vOoDxk2sQ@mail.gmail.com>
References: <976529875.1339.1469116197418@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34213 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbcGUSBD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 14:01:03 -0400
Received: by mail-vk0-f45.google.com with SMTP id s189so124221839vkh.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 11:01:03 -0700 (PDT)
In-Reply-To: <976529875.1339.1469116197418@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 21, 2016 at 8:49 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> On a CentOS 7 system with a Jewel 10.2.2 cluster I'm trying to create a pool which fails.
>
> Any pool I try to create, with or without a ruleset applied to it fails with this error:
>
> "Error ENOMEM: crushtool check failed with -12: failed run crushtool: fork failed: (12) Cannot allocate memory"
>
> At first I thought it was a package version mismatch, but it doesn't seem to be the case.
>
> There are other commands like 'radosgw-admin' I see fail with -12 error codes as well.
>
> Any ideas what might be going on here? The system has roughly 29GB of free memory, so that should be sufficient.

ulimits?
