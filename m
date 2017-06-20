From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: almost all of the Ceph cluster OSD are assert when create pg for luminous(12.0.3)
Date: Tue, 20 Jun 2017 10:38:21 -0700
Message-ID: <CAJ4mKGZQXLgAnbu5A_wPqs5_VEKD05BitAy3-6Y_H7aHz9RETg@mail.gmail.com>
References: <F0858C043E80304FBFA0A767AC8DE5E7A33637C4@H3CMLB14-EX.srv.huawei-3com.com>
 <F0858C043E80304FBFA0A767AC8DE5E7A33657F9@H3CMLB14-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35658 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbdFTRiW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 13:38:22 -0400
Received: by mail-io0-f174.google.com with SMTP id k93so89189807ioi.2
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 10:38:22 -0700 (PDT)
In-Reply-To: <F0858C043E80304FBFA0A767AC8DE5E7A33657F9@H3CMLB14-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wangwenfeng <wang.wenfeng@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 20, 2017 at 2:17 AM, Wangwenfeng <wang.wenfeng@h3c.com> wrote:
> Hi, all
> I test the luminous(12.0.3), almost all of the Ceph cluster OSD are assert when create pg. The assert is
>
> 2017-06-19 19:52:43.030110 7f4d0a589700 10 osd.1 622 build_initial_pg_history 3.1f3 created 377
> 2017-06-19 19:52:43.063891 7f4d0a589700 -1 /root/mnt/ceph_tmp/release/Ubuntu/WORKDIR/ceph-12.0.3/src/osd/OSDMap.h: In function 'const epoch_t& OSDMap::get_up_from(int) const' thread 7f4d0a589700 time 2017-06-19 19:52:43.060805
> /root/mnt/ceph_tmp/release/Ubuntu/WORKDIR/ceph-12.0.3/src/osd/OSDMap.h: 556: FAILED assert(exists(osd))
>
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x10e) [0x55f0c9293d3e]
>  2: (()+0x3c9cb0) [0x55f0c8c99cb0]
>  3: (PastIntervals::check_new_interval(int, int, std::vector<int, std::allocator<int> > const&, std::vector<int, std::allocator<int> > const&, int, int, std::vector<int, std::allocator<int> > const&, std::vector<int, std::allocator<int> > const&, unsigned int, unsigned int, std::shared_ptr<OSDMap const>, std::shared_ptr<OSDMap const>, pg_t, IsPGRecoverablePredicate*, PastIntervals*, std::ostream*)+0x5cd) [0x55f0c8f8826d]
>  4: (OSD::build_initial_pg_history(spg_t, unsigned int, utime_t, pg_history_t*, PastIntervals*)+0x594) [0x55f0c8d84ce4]
>  5: (OSD::handle_pg_create(boost::intrusive_ptr<OpRequest>)+0x97c) [0x55f0c8d8f5cc]
>  6: (OSD::dispatch_op(boost::intrusive_ptr<OpRequest>)+0x1b1) [0x55f0c8d91641]
>  7: (OSD::do_waiters()+0x9d) [0x55f0c8d917cd]
>  8: (OSD::ms_dispatch(Message*)+0x69) [0x55f0c8d923f9]
>  9: (DispatchQueue::entry()+0x79b) [0x55f0c945faeb]
>  10: (DispatchQueue::DispatchThread::entry()+0xd) [0x55f0c930cafd]
>  11: (()+0x8182) [0x7f4d16bb0182]
>  12: (clone()+0x6d) [0x7f4d15ca047d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
> Does anyone have this problem? Has the probem been solved?

Nobody else has reported this and it doesn't seem to have turned up in
our nightlies. Can you describe a little more about what happens? If
you got a core dump, can you find the value of old_acting_primary?
-Greg
