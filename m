From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: GPG signing of upstream release tags
Date: Thu, 9 Feb 2017 21:42:55 -0700
Message-ID: <CALqRxCxW3EfmGqZNBXfUoDjLLMecsEcDNKRAHOv3pa=ry8Mp=A@mail.gmail.com>
References: <20170209160345.1cf38e78@suse.de> <87inojxfzp.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:36478 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdBJEtj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2017 23:49:39 -0500
Received: by mail-ua0-f182.google.com with SMTP id 96so19885187uaq.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Feb 2017 20:49:27 -0800 (PST)
In-Reply-To: <87inojxfzp.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>
Cc: David Disseldorp <ddiss@suse.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Feb 9, 2017 at 1:32 PM, Abhishek L <abhishek@suse.com> wrote:
> Since v11.0.0/v10.0.5/v0.94.3,
>> these tags have not been GPG signed, so downstream consumers have no
>> reliable way of verifying that the source they have matches the reviewed
>> and tested upstream release source.

The old ceph.com GPG key had been copied to too many places, including
some of the Jenkins slaves, which was bad. Today there is a central
signer box behind a firewall with very restricted access.

I'll talk with Andrew and Alfredo about GPG signing Git tags and
source tarballs going forward, because I think we can script something
here to make it easier. I agree that it's important.

- Ken
