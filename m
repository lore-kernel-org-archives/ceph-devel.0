From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: getting more updates in rocksdb
Date: Wed, 20 Jul 2016 06:32:02 -0700
Message-ID: <CAJ4mKGYEmECcn_9wMBTovk0tUCnLtTH2Cmy=K18WzK02Fjah4A@mail.gmail.com>
References: <a8d5d498-cbc7-f252-64a3-791995bfc5bc@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35361 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbcGTNcD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2016 09:32:03 -0400
Received: by mail-vk0-f48.google.com with SMTP id w127so68914609vkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jul 2016 06:32:03 -0700 (PDT)
In-Reply-To: <a8d5d498-cbc7-f252-64a3-791995bfc5bc@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jul 20, 2016 at 3:38 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>
> Hi,
>
> I submitted a small patch to rocksdb for FreeBSD
> https://github.com/facebook/rocksdb/commit/b726bf59619d43651838e03cce9f876b3560cbda
>
> And was hopping that it would be tracked by my Ceph stuff as well.
> But refetching things, it does not seem to be in the tree ceph cmake
> fetches.
>
> And I'm not fluent enough in git to actually check if my current
> checkout with hash: 5647fa427c4eab87c0caf8bcbb91f5846a4623f9
> should contain the above commit.

Use "git log" on both trees and search for the hashes? :)

Anyway, the Ceph submodule does not auto-update (git submodules don't
support that AFAIK). You can go into the rocksdb folder and try
checking out the latest upstream master, then committing the new hash
as a commit in the Ceph git repo (at least, once your commit is
merged; not sure if it is yet).
-Greg
