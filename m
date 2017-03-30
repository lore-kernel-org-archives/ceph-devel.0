From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Why can't I delete a pool
Date: Thu, 30 Mar 2017 15:31:54 +0200
Message-ID: <9a7e5b5a-8b3d-0547-027c-890dcf0bcf4d@suse.de>
References: <022a7617-95fd-2a92-c7c9-274479b03778@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933217AbdC3NcB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 09:32:01 -0400
In-Reply-To: <022a7617-95fd-2a92-c7c9-274479b03778@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On 30/03/17 14:59, Willem Jan Withagen wrote:
> [~] wjw@cephtest> ceph osd pool delete cephfsdata cephfsdata
> --yes-i-really-really-mean-it
> Error EPERM: pool deletion is disabled; you must first set the
> mon_allow_pool_delete config option to true before you can destroy a pool
> Exit 1
> [~] wjw@cephtest> ceph -n mon.a --show-config | grep allow
> ...
> mon_allow_pool_delete = true
> ...

Looking at master, this would only happen if the daemon handling the
request actually had mon_allow_pool_delete = false.

I'm guessing you made sure mon.a is your leader, but if not, maybe check
the leader's conf?

Other than that, please open a ticket so we can figure out what's wrong.

Cheers!

  -Joao


