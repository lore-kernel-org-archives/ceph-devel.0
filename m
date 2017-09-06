From: Sage Weil <sweil@redhat.com>
Subject: Re: auth: assert(ckh)
Date: Wed, 6 Sep 2017 02:57:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709060255070.16664@piezo.novalocal>
References: <CALi+v1_7HkCvTaeDWQPq9tgxZDQMZwPajQyOZXsTX_Tuv14h1w@mail.gmail.com> <CAJ4mKGats1x13VEHfoHZ-hiDmkfyj64PLDaFsB36S7DieU9WyA@mail.gmail.com> <CALi+v18Y_gfSrQFMbq-NHCLrq03SM4PXAK0SaNY8eXAR5ARE4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753737AbdIFC5r (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Sep 2017 22:57:47 -0400
In-Reply-To: <CALi+v18Y_gfSrQFMbq-NHCLrq03SM4PXAK0SaNY8eXAR5ARE4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zengran zhang <z13121369189@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 6 Sep 2017, zengran zhang wrote:
> Thanks Grge, we used test on the old version, and have plan to update
> already...about the assert, i puzzled how could the session_key could
> become empty... the connection had just finish `verify_authorizer` ,
> in which we(accepter) got the session_key from peer's authorizer_bl
> and encrypt auth_reply with the session_key... then how could the
> session_key missing when we `check_message_signature` on read?

It is possible we are racing with the authentication handshake?  I 
seem to remember there is race possibility if we are just setting up 
the auth (in the monclient auth handshake) and then get an incoming 
connection.  This was previously popping up because of a messenger 
change that allowed incoming connections even when the nonce the peer 
wanted wasn't us; we revert it and crashes like this went away.  See 
bf4938567943c80345966f9c5a3bdc75a913175b and the revert of that bit in 
8e6a15d01ae5f36169b3ba9f53d81a9afcc9d355.  Could this be what you are 
seeing?

sage



> 
> 2017-09-06 1:55 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> > On Tue, Sep 5, 2017 at 7:19 AM, zengran zhang <z13121369189@gmail.com> wrote:
> >> Hi,
> >>
> >>     in our cluster, we could found some rare and odd assert log, which
> >> says that the session key was emtpy. the log happen only once dur some
> >> days, and only happen when osd just boot up...
> >> is it possible that the `CephxAuthorizeHandler::verify_authorizer`
> >> return valid but  the `session_key` was null ?  log as follow:
> >>
> >> 2017-09-05 10:11:00.954356 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG pgs=0 cs=0 l=0).process prev state
> >> is STATE_ACCEPTING_WAIT_BANNER_ADDR
> >> 2017-09-05 10:11:00.954361 7f898bc3c700 10 Event(0x55c4fff222c0
> >> nevent=5000 time_id=1).process_events wait second 30 usec 0
> >> 2017-09-05 10:11:00.954363 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG pgs=0 cs=0 l=0).read_until len is
> >> 33 state_offset is 0
> >> 2017-09-05 10:11:00.954372 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG pgs=0 cs=0 l=0).read_until
> >> read_bulk recv_end is 0 left is 33 got 207
> >> 2017-09-05 10:11:00.954466 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=0 cs=0 l=0).process prev
> >> state is STATE_ACCEPTING_WAIT_CONNECT_MSG
> >> 2017-09-05 10:11:00.954488 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=0 cs=0 l=0).read_until len
> >> is 174 state_offset is 0
> >> 2017-09-05 10:11:00.954495 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=0 cs=0 l=0).read_until got
> >> 174 in buffer  left is 0 buffer still has 0
> >> 2017-09-05 10:11:00.954502 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=0 cs=0
> >> l=0)._process_connection accept got peer connect_seq 0 global_seq 7
> >> 2017-09-05 10:11:00.954509 7f898c43d700 10 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=0 cs=0
> >> l=1)._process_connection accept of host_type 4, policy.lossy=1
> >> policy.server=1 policy.standby=0 policy.resetcheck=0
> >> 2017-09-05 10:11:00.954525 7f898c43d700 10 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=0 cs=0
> >> l=1).handle_connect_msg accept my proto 10, their proto 10
> >> 2017-09-05 10:11:00.954535 7f898c43d700 10 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=0 cs=0
> >> l=1).handle_connect_msg accept setting up session_security.
> >> 2017-09-05 10:11:00.954542 7f898c43d700 10 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=0 cs=0
> >> l=1).handle_connect_msg accept new session
> >> 2017-09-05 10:11:00.954547 7f898c43d700 10 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=7 cs=1
> >> l=1).handle_connect_msg accept success, connect_seq = 1 in_seq=0,
> >> sending READY
> >> 2017-09-05 10:11:00.954572 7f898c43d700 10 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=7 cs=1
> >> l=1).handle_connect_msg accept features 1152323339925389307
> >> 2017-09-05 10:11:00.954632 7f898c43d700 10 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH pgs=7 cs=1 l=1)._try_send sent
> >> bytes 34 remaining bytes 0
> >> 2017-09-05 10:11:00.954667 7f898c43d700  2 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_SEQ pgs=7 cs=1 l=1).handle_connect_msg accept
> >> write reply msg done
> >> 2017-09-05 10:11:00.954682 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_SEQ pgs=7 cs=1 l=1).process prev state is
> >> STATE_ACCEPTING_WAIT_CONNECT_MSG_AUTH
> >> 2017-09-05 10:11:00.954687 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_SEQ pgs=7 cs=1 l=1).read_until len is 8
> >> state_offset is 0
> >> 2017-09-05 10:11:00.954708 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_SEQ pgs=7 cs=1 l=1).read_until read_bulk
> >> recv_end is 0 left is 8 got 8
> >> 2017-09-05 10:11:00.954724 7f898c43d700  2 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_SEQ pgs=7 cs=1 l=1)._process_connection accept
> >> get newly_acked_seq 0
> >> 2017-09-05 10:11:00.954730 7f898c43d700 10 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_WAIT_SEQ pgs=7 cs=1 l=1).discard_requeued_up_to 0
> >> 2017-09-05 10:11:00.954736 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_READY pgs=7 cs=1 l=1).process prev state is
> >> STATE_ACCEPTING_WAIT_SEQ
> >> 2017-09-05 10:11:00.954741 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_ACCEPTING_READY pgs=7 cs=1 l=1)._process_connection accept
> >> done
> >> 2017-09-05 10:11:00.954746 7f898c43d700 10 Event(0x55c4fff22080
> >> nevent=5000 time_id=2).create_time_event id=1 trigger after
> >> 900000000us
> >> 2017-09-05 10:11:00.954759 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805 s=STATE_OPEN pgs=7
> >> cs=1 l=1).process prev state is STATE_ACCEPTING_READY
> >> 2017-09-05 10:11:00.954765 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805 s=STATE_OPEN pgs=7
> >> cs=1 l=1).read_until len is 1 state_offset is 0
> >> 2017-09-05 10:11:00.954772 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805 s=STATE_OPEN pgs=7
> >> cs=1 l=1).read_until read_bulk recv_end is 0 left is 1 got 0
> >> 2017-09-05 10:11:00.954777 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805 s=STATE_OPEN pgs=7
> >> cs=1 l=1).read_until need len 1 remaining 1 bytes
> >> 2017-09-05 10:11:00.954784 7f898c43d700 30 stack operator() calling
> >> event process
> >> 2017-09-05 10:11:00.954786 7f898c43d700 10 Event(0x55c4fff22080
> >> nevent=5000 time_id=2).process_events wait second 30 usec 0
> >> 2017-09-05 10:11:00.955445 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805 s=STATE_OPEN pgs=7
> >> cs=1 l=1).process prev state is STATE_OPEN
> >> 2017-09-05 10:11:00.955462 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805 s=STATE_OPEN pgs=7
> >> cs=1 l=1).read_until len is 1 state_offset is 0
> >> 2017-09-05 10:11:00.955472 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805 s=STATE_OPEN pgs=7
> >> cs=1 l=1).read_until read_bulk recv_end is 0 left is 1 got 4096
> >> 2017-09-05 10:11:00.955478 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_HEADER pgs=7 cs=1 l=1).process prev state is
> >> STATE_OPEN
> >> 2017-09-05 10:11:00.955483 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_HEADER pgs=7 cs=1 l=1).process begin MSG
> >> 2017-09-05 10:11:00.955488 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_HEADER pgs=7 cs=1 l=1).read_until len is 53
> >> state_offset is 0
> >> 2017-09-05 10:11:00.955494 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_HEADER pgs=7 cs=1 l=1).read_until got 53 in
> >> buffer  left is 0 buffer still has 4042
> >> 2017-09-05 10:11:00.955499 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_HEADER pgs=7 cs=1 l=1).process got MSG header
> >> 2017-09-05 10:11:00.955505 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_HEADER pgs=7 cs=1 l=1).process got envelope
> >> type=80 src osd.3 front=111623 data=0 off 0
> >> 2017-09-05 10:11:00.955522 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_THROTTLE_MESSAGE pgs=7 cs=1 l=1).process prev
> >> state is STATE_OPEN_MESSAGE_HEADER
> >> 2017-09-05 10:11:00.955528 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_THROTTLE_BYTES pgs=7 cs=1 l=1).process prev state
> >> is STATE_OPEN_MESSAGE_THROTTLE_MESSAGE
> >> 2017-09-05 10:11:00.955533 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_THROTTLE_DISPATCH_QUEUE pgs=7 cs=1 l=1).process
> >> prev state is STATE_OPEN_MESSAGE_THROTTLE_BYTES
> >> 2017-09-05 10:11:00.955540 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_READ_FRONT pgs=7 cs=1 l=1).process prev state is
> >> STATE_OPEN_MESSAGE_THROTTLE_DISPATCH_QUEUE
> >> 2017-09-05 10:11:00.955552 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_READ_FRONT pgs=7 cs=1 l=1).read_until len is
> >> 111623 state_offset is 0
> >> 2017-09-05 10:11:00.955558 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_READ_FRONT pgs=7 cs=1 l=1).read_until got 4042 in
> >> buffer  left is 107581 buffer still has 0
> >> 2017-09-05 10:11:00.955679 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_READ_FRONT pgs=7 cs=1 l=1).read_until read_bulk
> >> left is 107581 got 107581
> >> 2017-09-05 10:11:00.955696 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_READ_FRONT pgs=7 cs=1 l=1).process got front
> >> 111623
> >> 2017-09-05 10:11:00.955702 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_READ_FOOTER_AND_DISPATCH pgs=7 cs=1
> >> l=1).read_until len is 21 state_offset is 0
> >> 2017-09-05 10:11:00.955711 7f898c43d700 25 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_READ_FOOTER_AND_DISPATCH pgs=7 cs=1
> >> l=1).read_until read_bulk recv_end is 0 left is 21 got 21
> >> 2017-09-05 10:11:00.955717 7f898c43d700 10 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_READ_FOOTER_AND_DISPATCH pgs=7 cs=1 l=1).process
> >> aborted = 0
> >> 2017-09-05 10:11:00.955722 7f898c43d700 20 -- 192.168.2.1:6805/7391 >>
> >> 192.168.2.1:6811/7386 conn(0x55c5053b1800 :6805
> >> s=STATE_OPEN_MESSAGE_READ_FOOTER_AND_DISPATCH pgs=7 cs=1 l=1).process
> >> got 111623 + 0 + 0 byte message
> >> 2017-09-05 10:11:00.965585 7f898c43d700 -1
> >> /tmp/release/Ubuntu/WORKDIR/ceph-12.0.2-32-ge885403/src/auth/Crypto.h:
> >> In function 'int CryptoKey::encrypt(CephContext*, const bufferlist&,
> >> ceph::bufferlist&, std::__cxx11::string*) const' thread 7f898c43d700
> >> time 2017-09-05 10:11:00.957267
> >> /tmp/release/Ubuntu/WORKDIR/ceph-12.0.2-32-ge885403/src/auth/Crypto.h:
> >> 109: FAILED assert(ckh)
> >
> > There were several bugs in this area during the Luminous development
> > cycle that have been fixed for final release. Since it looks like
> > you're using a *very* old development release, you should update! :)
> >
> > (Why were you running that on a cluster anyway? I hope it's just for
> > development purposes!)
> > -Greg
> >
> >>
> >>  ceph version 12.0.2 (5a1b6b3269da99a18984c138c23935e5eb96f73e)
> >>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> >> const*)+0x102) [0x55c4f5cd84d2]
> >>  2: (CephxSessionHandler::_calc_signature(Message*, unsigned
> >> long*)+0x5d2) [0x55c4f5ef7932]
> >>  3: (CephxSessionHandler::check_message_signature(Message*)+0x7d)
> >> [0x55c4f5ef7cfd]
> >>  4: (AsyncConnection::process()+0x1dbc) [0x55c4f5edf82c]
> >>  5: (EventCenter::process_events(int)+0x9b1) [0x55c4f5d70f71]
> >>  6: (()+0xdb5e41) [0x55c4f5d74e41]
> >>  7: (()+0xb8c80) [0x7f898f0c2c80]
> >>  8: (()+0x76ba) [0x7f898f7b16ba]
> >>  9: (clone()+0x6d) [0x7f898e82882d]
> >>
> >> Thanks & Regards
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
