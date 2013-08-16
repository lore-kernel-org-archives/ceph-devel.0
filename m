From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Show outdated diffs on github
Date: Fri, 16 Aug 2013 00:01:20 -0700
Message-ID: <520DCE40.90505@inktank.com>
References: <520DCA85.1020208@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:46609 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3HPHBY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 03:01:24 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so1736057obb.15
        for <ceph-devel@vger.kernel.org>; Fri, 16 Aug 2013 00:01:24 -0700 (PDT)
In-Reply-To: <520DCA85.1020208@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 08/15/2013 11:45 PM, Loic Dachary wrote:
> Hi Josh,
>
>  From https://github.com/ceph/ceph/pull/504 I see that your comments persisted despite a rebase and show as
>
>   jdurgin discussed an outdated diff 8 hours ago
>
> I would like to do the same but when I comment inline, it shows differently and gets trashed by a rebase. I'm curious to learn how you do it :-)

The interface isn't ideal - if you comment on the pull request diff
(i.e. https://github.com/ceph/ceph/pull/504/files) instead of the
individual commits, then your comments will stay associated with the
pull request (and still appear on new versions of the branch if the
line they're on didn't change).

Josh
