From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] mds: update backtrace when old format inode is touched
Date: Mon, 21 Oct 2013 09:14:23 +0800
Message-ID: <CAAM7YAn+Bui8EYo8tYcWFmq9ODbCjd1T8cRkBYqrsav7Coy0oA@mail.gmail.com>
References: <1377222150-4238-1-git-send-email-zheng.z.yan@intel.com>
	<CAPYLRzjwN-qT0KZnPE4rYp9N-A9Zg+eaxMXzS_9ct2GSX9PQCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:42213 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab3JUBOZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Oct 2013 21:14:25 -0400
Received: by mail-la0-f42.google.com with SMTP id ea20so979161lab.1
        for <ceph-devel@vger.kernel.org>; Sun, 20 Oct 2013 18:14:23 -0700 (PDT)
In-Reply-To: <CAPYLRzjwN-qT0KZnPE4rYp9N-A9Zg+eaxMXzS_9ct2GSX9PQCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Oct 17, 2013 at 7:35 AM, Gregory Farnum <greg@inktank.com> wrote:
> I came across this patch while going through my email backlog and it
> looks like we haven't pulled in this patch or anything like it. Did
> you do something about this problem in a different way?
> (The patch doesn't apply cleanly so I'll need to update it if this is
> still what we've got.)

I didn't do anything else about the issue. I updated the patch and
sent a pull request
github.com/ceph/ceph/pull/750

Regards
Yan, Zheng



> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
> On Thu, Aug 22, 2013 at 6:42 PM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> We updated inode format version to 7 when introducing inode backtrace.
>> If we found a inode's format version < 7 when fetching the inode, set
>> the inode's backtrace_version to 0, to indicate the inode's backtrace
>> is out of data. When touching a inode with backtrace_version == 0, we
>> also update its backtrace.
>>
>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> ---
>>  src/mds/Locker.cc   | 4 ++++
>>  src/mds/Server.cc   | 5 +++++
>>  src/mds/mdstypes.cc | 2 ++
>>  3 files changed, 11 insertions(+)
>>
>> diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
>> index 99bd761..e274204 100644
>> --- a/src/mds/Locker.cc
>> +++ b/src/mds/Locker.cc
>> @@ -2898,6 +2898,10 @@ bool Locker::_do_cap_update(CInode *in, Capability *cap,
>>
>>      wrlock_force(&in->xattrlock, mut);
>>    }
>> +
>> +  // update backtrace for old format inode. (see inode_t::decode)
>> +  if (pi->backtrace_version == 0)
>> +    pi->update_backtrace();
>>
>>    mut->auth_pin(in);
>>    mdcache->predirty_journal_parents(mut, &le->metablob, in, 0, PREDIRTY_PRIMARY, 0, follows);
>> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
>> index 466d481..b50169e 100644
>> --- a/src/mds/Server.cc
>> +++ b/src/mds/Server.cc
>> @@ -3207,6 +3207,11 @@ void Server::handle_client_setattr(MDRequest *mdr)
>>
>>    // log + wait
>>    le->metablob.add_client_req(req->get_reqid(), req->get_oldest_client_tid());
>> +
>> +  // update backtrace for old format inode. (see inode_t::decode)
>> +  if (pi->backtrace_version == 0)
>> +    pi->update_backtrace();
>> +
>>    mdcache->predirty_journal_parents(mdr, &le->metablob, cur, 0, PREDIRTY_PRIMARY, false);
>>    mdcache->journal_dirty_inode(mdr, &le->metablob, cur);
>>
>> diff --git a/src/mds/mdstypes.cc b/src/mds/mdstypes.cc
>> index 6886786..f8ec549 100644
>> --- a/src/mds/mdstypes.cc
>> +++ b/src/mds/mdstypes.cc
>> @@ -294,6 +294,8 @@ void inode_t::decode(bufferlist::iterator &p)
>>      ::decode(backtrace_version, p);
>>    if (struct_v >= 7)
>>      ::decode(old_pools, p);
>> +  else
>> +    backtrace_version = 0; // note inode which has no backtrace
>>
>>    DECODE_FINISH(p);
>>  }
>> --
>> 1.8.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
