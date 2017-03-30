From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Why can't I delete a pool
Date: Thu, 30 Mar 2017 16:00:03 +0200
Message-ID: <408dfb42-55cc-866a-f4a5-697b771925ee@digiware.nl>
References: <022a7617-95fd-2a92-c7c9-274479b03778@digiware.nl>
 <9a7e5b5a-8b3d-0547-027c-890dcf0bcf4d@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:30186 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933474AbdC3OAJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 10:00:09 -0400
In-Reply-To: <9a7e5b5a-8b3d-0547-027c-890dcf0bcf4d@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>

On 30-3-2017 15:31, Joao Eduardo Luis wrote:
> On 30/03/17 14:59, Willem Jan Withagen wrote:
>> [~] wjw@cephtest> ceph osd pool delete cephfsdata cephfsdata
>> --yes-i-really-really-mean-it
>> Error EPERM: pool deletion is disabled; you must first set the
>> mon_allow_pool_delete config option to true before you can destroy a pool
>> Exit 1
>> [~] wjw@cephtest> ceph -n mon.a --show-config | grep allow
>> ...
>> mon_allow_pool_delete = true
>> ...
> 
> Looking at master, this would only happen if the daemon handling the
> request actually had mon_allow_pool_delete = false.
> 
> I'm guessing you made sure mon.a is your leader, but if not, maybe check
> the leader's conf?
> 
> Other than that, please open a ticket so we can figure out what's wrong.

Right... 100%

It is a testing pool, and I thought I had all mon's restarted.
But clearly not.

Thanx,
--WjW


