From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: code coverage and teuthology
Date: Mon, 14 Jan 2013 09:26:03 -0800
Message-ID: <50F43FAB.2050609@inktank.com>
References: <50EF49C4.1020909@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35728 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737Ab3ANR0M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 12:26:12 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so2333624pad.11
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 09:26:11 -0800 (PST)
In-Reply-To: <50EF49C4.1020909@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 01/10/2013 03:07 PM, Loic Dachary wrote:
> Hi,
>
> I successfully run teuthology with the proposed 3node_rgw.yaml [1] and changing the flavor from basic to gcov [2]. I hoped to use cov-init.sh ( https://github.com/ceph/teuthology/blob/master/coverage/cov-init.sh ) and then coverage.sh but I can't figure out how to make it work.
>
> Hints would be most appreciated ;-)

Looking at how it's run automatically might help:

https://github.com/ceph/teuthology/blob/master/teuthology/coverage.py#L88

> [1] 3node_rgw.yaml
>
> check-locks: false
> interactive-on-error: true
> overrides:
>    ceph:
>      branch: master
>      fs: xfs

You should also add 'coverage: true' for the ceph task overrides.
This way daemons are killed with SIGTERM, and the atexit function
that outputs coverage information will run.

Then you don't need your patch changing the flavor either.
For each task X, the docstring for teuthology.task.X.task documents
example usage and extra options like this.

Josh

> roles:
> - - mon.a
>    - mon.c
>    - osd.0
> - - mon.b
>    - mds.a
>    - osd.1
> - - client.0
> tasks:
> - ceph: null
> - rgw:
>    - client.0
> - interactive:
>
> targets:
> (snip)
>
> [2] http://gitbuilder.ceph.com/ceph-tarball-precise-x86_64-gcov/
>
> diff --git a/teuthology/task/ceph.py b/teuthology/task/ceph.py
> index b62bc1d..99d4f18 100644
> --- a/teuthology/task/ceph.py
> +++ b/teuthology/task/ceph.py
> @@ -1027,7 +1027,7 @@ def task(ctx, config):
>       dist = 'precise'
>       format = 'tarball'
>       arch = 'x86_64'
> -    flavor = 'basic'
> +    flavor = 'gcov'
>
>       # First element: controlled by user (or not there, by default):
>       # used to choose the right distribution, e.g. "oneiric".
> diff --git a/teuthology/task/kernel.py b/teuthology/task/kernel.py
> index 5c34433..54eaebb 100644
> --- a/teuthology/task/kernel.py
> +++ b/teuthology/task/kernel.py
> @@ -183,7 +183,7 @@ def download_deb(ctx, config):
>                   package='kernel',
>                   sha1=src,
>                   format='deb',
> -                flavor='basic',
> +                flavor='gcov',
>                   arch='x86_64',
>                   dist='precise',
>                   )
> @@ -408,7 +408,7 @@ def task(ctx, config):
>                   branch=role_config.get('branch'),
>                   tag=role_config.get('tag'),
>                   sha1=role_config.get('sha1'),
> -                flavor='basic',
> +                flavor='gcov',
>                   format='deb',
>                   dist='precise',
>                   arch='x86_64',
>

