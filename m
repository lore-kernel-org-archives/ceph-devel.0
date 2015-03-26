From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: seg fault in ceph-osd on aarch64
Date: Thu, 26 Mar 2015 18:05:18 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9166410970@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91664108DD@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1503261016240.31431@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0116.outbound.protection.outlook.com ([65.55.169.116]:42932
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751673AbbCZSTt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Mar 2015 14:19:49 -0400
In-Reply-To: <alpine.DEB.2.00.1503261016240.31431@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

any suggestions for stress tests, etc that might make this happen sooner?

-- Tom

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Thursday, March 26, 2015 12:17 PM
> To: Deneau, Tom
> Cc: ceph-devel
> Subject: Re: seg fault in ceph-osd on aarch64
> 
> On Thu, 26 Mar 2015, Deneau, Tom wrote:
> > I've been exercising the the 64-bit arm (aarch64) version of ceph.
> > This is from self-built rpms from the v0.93 snapshot.
> > The "cluster" is a single system with 6 hard drives, one osd each.
> > I've been letting it run with some rados bench and rados load-gen
> > loops and running bonnie++ on an rbd mount.
> >
> > Occasionally (in the latest case after 2 days) I've seen ceph-osd
> > crashes like the one shown below.  (showing last 10 events as well).
> > If I am reading the objdump correctly this is from the while loop in
> > the following code in Pipe::connect
> >
> > I assume this is not seen on ceph builds from other architectures?
> >
> > What is the recommended way to get more information on this osd crash?
> > (looks like osd log levels are 0/5)
> 
> In this case, debug ms = 20 should tell us what we need!
> 
> Thanks-
> sage
> 
> 
> >
> > -- Tom Deneau, AMD
> >
> >
> >
> >       if (reply.tag == CEPH_MSGR_TAG_SEQ) {
> >         ldout(msgr->cct,10) << "got CEPH_MSGR_TAG_SEQ, reading acked_seq
> and writing in_seq" << dendl;
> >         uint64_t newly_acked_seq = 0;
> >         if (tcp_read((char*)&newly_acked_seq, sizeof(newly_acked_seq)) < 0)
> {
> >           ldout(msgr->cct,2) << "connect read error on newly_acked_seq" <<
> dendl;
> >           goto fail_locked;
> >         }
> >         ldout(msgr->cct,2) << " got newly_acked_seq " << newly_acked_seq
> >                            << " vs out_seq " << out_seq << dendl;
> >         while (newly_acked_seq > out_seq) {
> >           Message *m = _get_next_outgoing();
> >           assert(m);
> >           ldout(msgr->cct,2) << " discarding previously sent " << m-
> >get_seq()
> >                              << " " << *m << dendl;
> >           assert(m->get_seq() <= newly_acked_seq);
> >           m->put();
> >           ++out_seq;
> >         }
> >         if (tcp_write((char*)&in_seq, sizeof(in_seq)) < 0) {
> >           ldout(msgr->cct,2) << "connect write error on in_seq" << dendl;
> >           goto fail_locked;
> >         }
> >       }
> >
> >
> >
> >
> >   -10> 2015-03-25 09:41:11.950684 3ff8f05f010  5 -- op tracker -- seq:
> > 3499479, time: 2015-03-25 09:41:11.950683, event: done, op: osd_op(c\
> > lient.8322.0:1640 benchmark_data_b0c-upstairs_5647_object343 [read
> 0~4194304] 1.5c587e9e ack+read+known_if_redirected e316)
> >     -9> 2015-03-25 09:41:11.951356 3ff8659f010  1 --
> > 10.236.136.224:6804/4928 <== client.8322 10.236.136.224:0/1020871 256
> > ==== osd_op(clien\
> > t.8322.0:1642 benchmark_data_b0c-upstairs_5647_object411 [read
> > 0~4194304] 1.f2b5749d ack+read+known_if_redirected e316) v5 ====
> > 201+0+0 (280\
> > 2495612 0 0) 0x1e67cd80 con 0x71f4c80
> >     -8> 2015-03-25 09:41:11.951397 3ff8659f010  5 -- op tracker --
> > seq: 3499480, time: 2015-03-25 09:41:11.951205, event: header_read,
> > op: o\
> > sd_op(client.8322.0:1642 benchmark_data_b0c-upstairs_5647_object411 [read
> 0~4194304] 1.f2b5749d ack+read+known_if_redirected e316)
> >     -7> 2015-03-25 09:41:11.951411 3ff8659f010  5 -- op tracker --
> > seq: 3499480, time: 2015-03-25 09:41:11.951214, event: throttled, op:
> > osd\
> > _op(client.8322.0:1642 benchmark_data_b0c-upstairs_5647_object411 [read
> 0~4194304] 1.f2b5749d ack+read+known_if_redirected e316)
> >     -6> 2015-03-25 09:41:11.951420 3ff8659f010  5 -- op tracker --
> > seq: 3499480, time: 2015-03-25 09:41:11.951351, event: all_read, op:
> > osd_\
> > op(client.8322.0:1642 benchmark_data_b0c-upstairs_5647_object411 [read
> 0~4194304] 1.f2b5749d ack+read+known_if_redirected e316)
> >     -5> 2015-03-25 09:41:11.951429 3ff8659f010  5 -- op tracker --
> > seq: 3499480, time: 0.000000, event: dispatched, op:
> > osd_op(client.8322.0\
> > :1642 benchmark_data_b0c-upstairs_5647_object411 [read 0~4194304]
> 1.f2b5749d ack+read+known_if_redirected e316)
> >     -4> 2015-03-25 09:41:11.951561 3ff9205f010  5 -- op tracker --
> > seq: 3499480, time: 2015-03-25 09:41:11.951560, event: reached_pg, op:
> > os\
> > d_op(client.8322.0:1642 benchmark_data_b0c-upstairs_5647_object411 [read
> 0~4194304] 1.f2b5749d ack+read+known_if_redirected e316)
> >     -3> 2015-03-25 09:41:11.951627 3ff9205f010  5 -- op tracker --
> > seq: 3499480, time: 2015-03-25 09:41:11.951627, event: started, op:
> > osd_o\
> > p(client.8322.0:1642 benchmark_data_b0c-upstairs_5647_object411 [read
> 0~4194304] 1.f2b5749d ack+read+known_if_redirected e316)
> >     -2> 2015-03-25 09:41:11.961959 3ff9205f010  1 --
> > 10.236.136.224:6804/4928 --> 10.236.136.224:0/1020871 --
> > osd_op_reply(1642 benchmark_da\
> > ta_b0c-upstairs_5647_object411 [read 0~4194304] v0'0 uv2 ondisk = 0) v6 --
> ?+0 0x3b39340 con 0x71f4c80
> >     -1> 2015-03-25 09:41:11.962043 3ff9205f010  5 -- op tracker --
> > seq: 3499480, time: 2015-03-25 09:41:11.962043, event: done, op:
> > osd_op(c\
> > lient.8322.0:1642 benchmark_data_b0c-upstairs_5647_object411 [read
> 0~4194304] 1.f2b5749d ack+read+known_if_redirected e316)
> >      0> 2015-03-25 09:41:12.030725 3ff8619f010 -1 *** Caught signal
> > (Segmentation fault) **  in thread 3ff8619f010
> >
> >  ceph version 0.93 (bebf8e9a830d998eeaab55f86bb256d4360dd3c4)
> >  1: /usr/bin/ceph-osd() [0xacf140]
> >  2: [0x3ffa9520510]
> >  3: (Pipe::connect()+0x301c) [0xc8c37c]
> >  4: (Pipe::Writer::entry()+0x10) [0xc96b9c]
> >  5: (Thread::entry_wrapper()+0x50) [0xba3bec]
> >  6: (()+0x6f30) [0x3ffa9116f30]
> >  7: (()+0xdd910) [0x3ffa8d8d910]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
> to interpret this.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> >
