From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Fixes: lines in commit messages
Date: Mon, 28 Mar 2016 09:29:04 -0700
Message-ID: <CAJ4mKGajQc-c4=EGfoH9BUQ612GqJ3PSDSnPMbwz1kmqGm-YyA@mail.gmail.com>
References: <56F95725.3040407@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35163 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098AbcC1Q3G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2016 12:29:06 -0400
Received: by mail-vk0-f52.google.com with SMTP id e6so162225996vkh.2
        for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2016 09:29:05 -0700 (PDT)
In-Reply-To: <56F95725.3040407@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Mar 28, 2016 at 9:09 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> Greetings, Ceph developers:
>
> As the number of GitHub pull requests rises (currently in the 8000s), we are
> starting have trouble with unrelated PRs getting closed automatically by the
> "Fixes: #...." lines in PR descriptions and commit messages.
>
> For example, if you open PR#9534 that fixes tracker issue#8069, including a
> line "Fixes: #8069" will cause PR#8069 to be closed - obviously, this is
> wrong but it's the way GitHub works.
>
> Sage suggested that we work around this by referring to the tracker issue by
> its full URL. I opened a PR changing SubmittingPatches to reflect this:
>
> https://github.com/ceph/ceph/pull/8312
>
> Any objections?

Sounds good to me. Truly depressing about GitHub, but sounds good.
-Greg
