From: Sage Weil <sage@newdream.net>
Subject: Re: need help about _ASSERT_H in dout
Date: Mon, 6 Feb 2017 14:27:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702061427290.3654@piezo.novalocal>
References: <CACKY0b_diMsgocA=NLEG3+7mjno+w8ULcccGASYd62RamiE2VA@mail.gmail.com> <CAJE9aOPFTSMwvLT2zsQ4d_WsxGMOkYzbB9Q9V3dtfE2TXU4Y2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1412797961-1486391279=:3654"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43199 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdBFO2A (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 09:28:00 -0500
In-Reply-To: <CAJE9aOPFTSMwvLT2zsQ4d_WsxGMOkYzbB9Q9V3dtfE2TXU4Y2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: liuchang0812 <liuchang0812@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1412797961-1486391279=:3654
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 6 Feb 2017, kefu chai wrote:
> On Mon, Feb 6, 2017 at 7:00 PM, liuchang0812 <liuchang0812@gmail.com> wrote:
> > hi, Sage and Cephers
> >
> > I tried to use boost::algorithm in os/bluefs.cc this afternoon. I got
> > such error when i included "boost/algorithm/string.hpp".
> >
> > /home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc: In member
> > function ‘int BlueFS::add_block_device(unsigned int,
> > std::__cxx11::string)’:
> > /home/liuchang/WorkSpace/ceph/src/common/dout.h:81:12: error: base
> > operand of ‘->’ is not a pointer
> >    _ASSERT_H->_log->submit_entry(_dout_e);  \
> >
> >
> > I have found this commit[1] that includes _ASSERT_H. i can't
> > understand why replace _dout_cct with _ASSERT_H and what
> > boost::algorithm confilicts with _ASSERT_H。
> 
> because boost/algorithm/string.hpp includes "assert.h" from libc. you
> need to re-included "include/assert.h" to override the `assert()` from
> libc.

or better yet, include the boost headers early, before any ceph headers 
get included, such that ceph's assert.h is still only included once.

sage

> 
> >
> > thanks, any comments are appreciated.
> >
> >
> > [1]: https://github.com/ceph/ceph/commit/a30601a1b69c3f1ac5cfa592050877aec8b5be9d
> >
> > [2]: more log as :
> >
> > /home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc: In member
> > function ‘int BlueFS::add_block_device(unsigned int,
> > std::__cxx11::string)’:
> > /home/liuchang/WorkSpace/ceph/src/common/dout.h:81:12: error: base
> > operand of ‘->’ is not a pointer
> >    _ASSERT_H->_log->submit_entry(_dout_e);  \
> >             ^
> > /home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc:119:65: note:
> > in expansion of macro ‘dendl’
> >    dout(10) << __func__ << " bdev " << id << " path " << path << dendl;
> >                                                                  ^
> > /home/liuchang/WorkSpace/ceph/src/common/dout.h:62:18: warning: unused
> > variable ‘_dout_cct’ [-Wunused-variable]
> >      CephContext *_dout_cct = cct;     \
> >                   ^
> > /home/liuchang/WorkSpace/ceph/src/common/dout.h:66:24: note: in
> > expansion of macro ‘dout_impl’
> >  #define ldout(cct, v)  dout_impl(cct, dout_subsys, v) dout_prefix
> >                         ^
> > /home/liuchang/WorkSpace/ceph/src/common/debug.h:23:17: note: in
> > expansion of macro ‘ldout’
> >  #define dout(v) ldout((dout_context), v)
> >                  ^
> > /home/liuchang/WorkSpace/ceph/src/os/bluestore/BlueFS.cc:119:3: note:
> > in expansion of macro ‘dout’
> >    dout(10) << __func__ << " bdev " << id << " path " << path << dendl;
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1412797961-1486391279=:3654--
