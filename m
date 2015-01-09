From: Samuel Just <sam.just@inktank.com>
Subject: Re: ERROR: assert(last_e.version.version < e.version.version)
Date: Fri, 9 Jan 2015 10:22:28 -0800
Message-ID: <CA+4uBUaUzQ7Pi8ezT7CYq3hJVnKHUAvTXRjqvhzTtx0wPwm9rQ@mail.gmail.com>
References: <CALZt5jzin9NUsojJ5W4eCmop=bAkjaHriPWFcg2_L9DeFF8AkQ@mail.gmail.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:37302 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbbAISWa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 13:22:30 -0500
Received: by mail-la0-f53.google.com with SMTP id gm9so16259901lab.12
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jan 2015 10:22:29 -0800 (PST)
In-Reply-To: <CALZt5jzin9NUsojJ5W4eCmop=bAkjaHriPWFcg2_L9DeFF8AkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nicheal <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This should be handled by divergent log entry trimming.  It looks more
like the filestore became inconsistent after the "flip" and failed to
record some transactions.  You'll want to make sure your
filestore/filesystem/disk configuration isn't causing inconsistencies.
-Sam

On Tue, Jan 6, 2015 at 7:54 PM, Nicheal <zay11022@gmail.com> wrote:
> Hi all,
>
> I cannot restart some osds when after a flipping of all 54 osds. The
> log is show below:
>
>     -9> 2015-01-06 10:53:07.976997 7f35695177a0 20 read_log
> 31150'2273018 (31150'2273012) modify
> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
> client.16829289.1:720306459 2015-01-05 21:57:54.650768
>     -8> 2015-01-06 10:53:07.977002 7f35695177a0 20 read_log
> 31150'2273019 (31150'2273018) modify
> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
> client.16829289.1:720306460 2015-01-05 21:57:54.666768
>     -7> 2015-01-06 10:53:07.977008 7f35695177a0 20 read_log
> 31150'2273020 (31150'2272817) modify
> 78c59174/rb.0.3e4a1.6b8b4567.000000000f3e/head//2 by
> client.16830941.1:737726835 2015-01-05 21:57:59.407053
>     -6> 2015-01-06 10:53:07.977014 7f35695177a0 20 read_log
> 31150'2273021 (31150'2273019) modify
> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
> client.16829289.1:720306701 2015-01-05 21:57:59.724767
>     -5> 2015-01-06 10:53:07.977019 7f35695177a0 20 read_log
> 31150'2273022 (31150'2273021) modify
> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
> client.16829289.1:720306702 2015-01-05 21:57:59.733767
>     -4> 2015-01-06 10:53:07.977026 7f35695177a0 20 read_log
> 31150'2273023 (31150'2273022) modify
> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
> client.16829289.1:720307058 2015-01-05 21:58:04.883767
>     -3> 2015-01-06 10:53:07.977031 7f35695177a0 20 read_log
> 31150'2273024 (31150'2273023) modify
> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
> client.16829289.1:720307059 2015-01-05 21:58:04.890767
>     -2> 2015-01-06 10:53:07.977036 7f35695177a0 20 read_log
> 31150'2273025 (31150'2273020) modify
> 78c59174/rb.0.3e4a1.6b8b4567.000000000f3e/head//2 by
> client.16830941.1:737727535 2015-01-05 21:58:09.465053
>     -1> 2015-01-06 10:53:07.977047 7f35695177a0 20 read_log
> 31181'2273025 (31150'2273024) modify
> 4a8b7974/rb.0.bc58e8.6b8b4567.000000003e37/head//2 by
> client.16829289.1:720307830 2015-01-05 21:58:15.795767
>      0> 2015-01-06 10:53:08.003297 7f35695177a0 -1 osd/PGLog.cc: In
> function 'static bool PGLog::read_log(ObjectStore*, coll_t, hobject_t,
> const pg_info_t&, std::map<eversion_t, hobject_t,
> std::less<eversion_t>, std::allocator<std::pair<const eversion_t,
> hobject_t> > >&, PGLog::IndexedLog&, pg_missing_t&,
> std::ostringstream&, std::set<std::basic_string<char,
> std::char_traits<char>, std::allocator<char> >,
> std::less<std::basic_string<char, std::char_traits<char>,
> std::allocator<char> > >, std::allocator<std::basic_string<char,
> std::char_traits<char>, std::allocator<char> > > >*)' thread
> 7f35695177a0 time 2015-01-06 10:53:07.977052
> osd/PGLog.cc: 672: FAILED assert(last_e.version.version < e.version.version)
>
> it asserts in read_log. Generally, version should be monotonically
> increasing. However,  it seems not true when osd state is flipping.
>
> The reason is that pg_log has the same version with different epoch.
>
> Assume that:
> 1. A (primary) receive a write request, and prepare transaction
> increasing version from 1 -> 2 at epoch = 1 and sending the request to
> B and C (replica)
> 2. But B and C may be down this time but Mon and A does not know this.
> Therefore, A write the transaction into journal and wait for B, C
> reply.
> 3. How this time A is down and B,C then is coming up. So B may become
> the primary and handle all write for this pg. Client may resend this
> unsuccessful request to B, so B also want to increasing version from 1
> -> 2, and epoch may equal 5 since osdmap changes this time.
> 4. Then A is comming up again so that it should replay journal to dump
> the transaction pg_log version = 2, epoch = 1 to omap. After this, it
> will peer with B and C, and find B is the auth pg_log, so query pg_log
> on B and merge them with itself. This time A may have pg_log: version
> = 2 and epoch = 1.  version = 2, epoch = 5.
> 5. After successfully recovering, pg_log: verison = 2, epoch = 5 is
> stored in omap
> 6. Then this time A is down again and want to restart the process.
> However, when it loadpgs and read pg_log, it find that 2 pieces are
> version = 2 with different epoch, so it assert.
>
> So it the assumption is true, it may be assert(last_e.version <
> e.version), which can compare the epoch first. I don't quite sure my
> assumption is right, so can anyone  give some guides, SAM and Sage?
>
> Is there neccessary to post pull request to github to discuss together?
>
> Yao Ning
> Regards!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
