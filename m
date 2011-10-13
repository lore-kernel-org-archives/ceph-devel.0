From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [patch] build ceph without using btrfs
Date: Thu, 13 Oct 2011 10:07:18 -0700
Message-ID: <CAORUGqDUxfQGX+yHy2GcxK8cwOuYMap7vJkh7RnwkQYPTZAGbA@mail.gmail.com>
References: <CABAwU-afkv_2HXNpoUKii9yCSZ9eqAYWVzpddPKwJfKHuSi6HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab1JMROj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2011 13:14:39 -0400
Received: by wyg34 with SMTP id 34so2097946wyg.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2011 10:14:38 -0700 (PDT)
In-Reply-To: <CABAwU-afkv_2HXNpoUKii9yCSZ9eqAYWVzpddPKwJfKHuSi6HA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 13, 2011 at 05:52, huang jun <hjwsm1989@gmail.com> wrote:
> If we build the ceph cluster without using btrfs, it returns error if
> the osd_data and mon_data directory doesn't exist.
[patch adding mkdir if "osd data" or "mon data" dir does not exist]

The requirement for the osd data dir to exist beforehand is
intentional, and is intended to avoid some operator errors; with the
mkdir in your patch, it's all too easy to accidentally use a
subdirectory of a relatively small root partition, instead of the big
extra disk you thought you were using.

If you don't want to use btrfs, don't use it. ext4 or xfs with
extended attributes will work just fine. Just mount any filesystem in
the "osd data" dir, or pre-create the directory.
