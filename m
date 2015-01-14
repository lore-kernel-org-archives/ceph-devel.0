From: Samuel Just <sam.just@inktank.com>
Subject: Re: ERROR: assert(last_e.version.version < e.version.version)
Date: Wed, 14 Jan 2015 07:14:36 -0800
Message-ID: <CA+4uBUZFQgzF+6BwOWq7oQS5Ejr29VViACx6e88tm=vZFC0zuQ@mail.gmail.com>
References: <CALZt5jzin9NUsojJ5W4eCmop=bAkjaHriPWFcg2_L9DeFF8AkQ@mail.gmail.com>
	<CA+4uBUaUzQ7Pi8ezT7CYq3hJVnKHUAvTXRjqvhzTtx0wPwm9rQ@mail.gmail.com>
	<CALZt5jzqOP4Ct_Ytadt9zCPf8tdWPTYGef2HfKk6waS_t0Y-9Q@mail.gmail.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:37157 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbbANPOh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jan 2015 10:14:37 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so8444971lbv.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jan 2015 07:14:36 -0800 (PST)
In-Reply-To: <CALZt5jzqOP4Ct_Ytadt9zCPf8tdWPTYGef2HfKk6waS_t0Y-9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Repairing the pg_log with kv-store-tool would probably be your best bet.
-Sam

On Wed, Jan 14, 2015 at 1:02 AM, Nicheal <zay11022@gmail.com> wrote:
> Yeah, I am convinced that the filesystem inconsistencies lead to a problem.
> Since in my log:
>
> 2015-01-06 00:03:06.145093 7fc6bf0c47a0  0 log [ERR] : 2.5b log bound
> mismatch, info (31150'2118828,31150'2121829] actual
> [31150'2118824,31150'2121829]
>
> 2015-01-06 00:03:06.596293 7fc6bf0c47a0  0 log [ERR] : 2.175 log bound
> mismatch, info (31150'6831522,31150'6834523] actual
> [31150'6831515,31150'6834523]
>
> 2015-01-06 00:03:06.663522 7fc6bf0c47a0  0 log [ERR] : 2.1bf log bound
> mismatch, info (31150'2651135,31150'2654136] actual
> [31150'2651134,31150'2654136]
>
> 2015-01-06 00:03:07.995156 7fc6bf0c47a0  0 log [ERR] : 2.5c7 log bound
> mismatch, info (31150'4316874,31150'4319875] actual
> [31150'4316867,31150'4319875]
>
> 2015-01-06 00:03:08.019283 7fc6bf0c47a0  0 log [ERR] : 2.5db log bound
> mismatch, info (31150'6752581,31150'6755582] actual
> [31150'6752567,31150'6755582]
>
> But all 54 osds are started and up successfully after power outage.
> And some log contains the infomation showed above.
> I may assumption that it is no divergent pg_log when first started
> since it does not assert fail when read_log.
> But I may assume a corruption with commit_op_seq so that transactions
> in journal is fail to replay. Thus pg_info is not consistent with
> pg_log now and give the above ERR.
>
> But this time, its peers seems all right and no ERR in the log.
> And after peering pg_log, the wrong log may spread out among its
> peers, so next time, we restart it and its peers osd, all of them
> cannot successfully start and assert fail at
> assert(last_e.version.version < e.version.version).
>
> 2015-01-06 00:07:00.775175 7fc6a9c4f700  0 log [ERR] : 2.621 push
> 640f8e21/rb.0.88fc31.6b8b4567.00000000004c/head//2 v 31150'3530451
> failed because local copy is 31150'3530488
>
> 2015-01-06 00:07:08.662272 7fc6a944e700  0 log [ERR] : 2.174 push
> 4c402174/rb.0.409d1.6b8b4567.000000000024/head//2 v 31150'2272943
> failed because local copy is 31150'2273027
>
> another ERR also indicates that pg_log version is not converged with
> object attr version. so it is reasonable to assume some transactions
> are fail to replay so that the filestore lose those transactions.
>
> Now, what I want to know is how to deal with this situation?  We can
> find osd.1 containning all there error log and may assume the data on
> it is corrupt, but its peer seems all good. So what we want is to stop
> osd.1 and mark osd.1 lost, And mark all unfound object revert.
> However, we can't because this pg's all three osds cannot successfully
> start because of this fail assertion.
> So one way is to delete this assert by hand and start those osds. The
> state of the osd will be eventually correct after wrong pg_log is
> trimmed.
> I wound know that is any other method to deal with this case without
> replace the code?
> another may use kv-store-tool to delete the corruption pg_log by hand, right?
>
> 2015-01-10 2:22 GMT+08:00 Samuel Just <sam.just@inktank.com>:
>> This should be handled by divergent log entry trimming.  It looks more
>> like the filestore became inconsistent after the "flip" and failed to
>> record some transactions.  You'll want to make sure your
>> filestore/filesystem/disk configuration isn't causing inconsistencies.
>> -Sam
>>
>> On Tue, Jan 6, 2015 at 7:54 PM, Nicheal <zay11022@gmail.com> wrote:
>>> Hi all,
>>>
>>> I cannot restart some osds when after a flipping of all 54 osds. The
>>> log is show below:
>>>
>>>     -9> 2015-01-06 10:53:07.976997 7f35695177a0 20 read_log
>>> 31150'2273018 (31150'2273012) modify
>>> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
>>> client.16829289.1:720306459 2015-01-05 21:57:54.650768
>>>     -8> 2015-01-06 10:53:07.977002 7f35695177a0 20 read_log
>>> 31150'2273019 (31150'2273018) modify
>>> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
>>> client.16829289.1:720306460 2015-01-05 21:57:54.666768
>>>     -7> 2015-01-06 10:53:07.977008 7f35695177a0 20 read_log
>>> 31150'2273020 (31150'2272817) modify
>>> 78c59174/rb.0.3e4a1.6b8b4567.000000000f3e/head//2 by
>>> client.16830941.1:737726835 2015-01-05 21:57:59.407053
>>>     -6> 2015-01-06 10:53:07.977014 7f35695177a0 20 read_log
>>> 31150'2273021 (31150'2273019) modify
>>> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
>>> client.16829289.1:720306701 2015-01-05 21:57:59.724767
>>>     -5> 2015-01-06 10:53:07.977019 7f35695177a0 20 read_log
>>> 31150'2273022 (31150'2273021) modify
>>> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
>>> client.16829289.1:720306702 2015-01-05 21:57:59.733767
>>>     -4> 2015-01-06 10:53:07.977026 7f35695177a0 20 read_log
>>> 31150'2273023 (31150'2273022) modify
>>> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
>>> client.16829289.1:720307058 2015-01-05 21:58:04.883767
>>>     -3> 2015-01-06 10:53:07.977031 7f35695177a0 20 read_log
>>> 31150'2273024 (31150'2273023) modify
>>> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
>>> client.16829289.1:720307059 2015-01-05 21:58:04.890767
>>>     -2> 2015-01-06 10:53:07.977036 7f35695177a0 20 read_log
>>> 31150'2273025 (31150'2273020) modify
>>> 78c59174/rb.0.3e4a1.6b8b4567.000000000f3e/head//2 by
>>> client.16830941.1:737727535 2015-01-05 21:58:09.465053
>>>     -1> 2015-01-06 10:53:07.977047 7f35695177a0 20 read_log
>>> 31181'2273025 (31150'2273024) modify
>>> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
>>> client.16829289.1:720307830 2015-01-05 21:58:15.795767
>>>      0> 2015-01-06 10:53:08.003297 7f35695177a0 -1 osd/PGLog.cc: In
>>> function 'static bool PGLog::read_log(ObjectStore*, coll_t, hobject_t,
>>> const pg_info_t&, std::map<eversion_t, hobject_t,
>>> std::less<eversion_t>, std::allocator<std::pair<const eversion_t,
>>> hobject_t> > >&, PGLog::IndexedLog&, pg_missing_t&,
>>> std::ostringstream&, std::set<std::basic_string<char,
>>> std::char_traits<char>, std::allocator<char> >,
>>> std::less<std::basic_string<char, std::char_traits<char>,
>>> std::allocator<char> > >, std::allocator<std::basic_string<char,
>>> std::char_traits<char>, std::allocator<char> > > >*)' thread
>>> 7f35695177a0 time 2015-01-06 10:53:07.977052
>>> osd/PGLog.cc: 672: FAILED assert(last_e.version.version < e.version.version)
>>>
>>> it asserts in read_log. Generally, version should be monotonically
>>> increasing. However,  it seems not true when osd state is flipping.
>>>
>>> The reason is that pg_log has the same version with different epoch.
>>>
>>> Assume that:
>>> 1. A (primary) receive a write request, and prepare transaction
>>> increasing version from 1 -> 2 at epoch = 1 and sending the request to
>>> B and C (replica)
>>> 2. But B and C may be down this time but Mon and A does not know this.
>>> Therefore, A write the transaction into journal and wait for B, C
>>> reply.
>>> 3. How this time A is down and B,C then is coming up. So B may become
>>> the primary and handle all write for this pg. Client may resend this
>>> unsuccessful request to B, so B also want to increasing version from 1
>>> -> 2, and epoch may equal 5 since osdmap changes this time.
>>> 4. Then A is comming up again so that it should replay journal to dump
>>> the transaction pg_log version = 2, epoch = 1 to omap. After this, it
>>> will peer with B and C, and find B is the auth pg_log, so query pg_log
>>> on B and merge them with itself. This time A may have pg_log: version
>>> = 2 and epoch = 1.  version = 2, epoch = 5.
>>> 5. After successfully recovering, pg_log: verison = 2, epoch = 5 is
>>> stored in omap
>>> 6. Then this time A is down again and want to restart the process.
>>> However, when it loadpgs and read pg_log, it find that 2 pieces are
>>> version = 2 with different epoch, so it assert.
>>>
>>> So it the assumption is true, it may be assert(last_e.version <
>>> e.version), which can compare the epoch first. I don't quite sure my
>>> assumption is right, so can anyone  give some guides, SAM and Sage?
>>>
>>> Is there neccessary to post pull request to github to discuss together?
>>>
>>> Yao Ning
>>> Regards!
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
