From: Sage Weil <sage@inktank.com>
Subject: Re: mds.0 crashed with 0.61.7
Date: Mon, 29 Jul 2013 11:29:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307291129090.16497@cobra.newdream.net>
References: <20130729154432.GA24611@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1307290846270.7836@cobra.newdream.net> <20130729200037.19c00223@andylap>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52127 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab3G2S34 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 14:29:56 -0400
In-Reply-To: <20130729200037.19c00223@andylap>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 29 Jul 2013, Andreas Bluemle wrote:
> Hi Sage,
> 
> as this crash had been around for a while already: do you
> know whether this had happened in ceph version 0.61.4 as well?

Pretty sure, yeah. 

sage

> 
> 
> Best Regards
> 
> Andreas Bluemle
> 
> 
> On Mon, 29 Jul 2013 08:47:00 -0700 (PDT)
> Sage Weil <sage@inktank.com> wrote:
> 
> > Hi Andreas,
> > 
> > Can you reproduce this (from mkcephfs onward) with debug mds = 20 and 
> > debug ms = 1?  I've seen this crash several times but never been able
> > to get to the bottom of it.
> > 
> > Thanks!
> > sage
> > 
> > On Mon, 29 Jul 2013, Andreas Friedrich wrote:
> > 
> > > Hello,
> > > 
> > > my Ceph test cluster runs fine with 0.61.4.
> > > 
> > > I have removed all data and have setup a new cluster with 0.61.7
> > > using the same configuration (see ceph.conf).
> > > 
> > > After
> > >   mkcephfs -c /etc/ceph/ceph.conf -a
> > >   /etc/init.d/ceph -a start
> > > the mds.0 crashed:
> > > 
> > >     -1> 2013-07-29 17:02:57.626886 7fba2a8cd700  1 --
> > > 10.0.0.231:6800/806 <== osd.121 10.0.0.231:6834/5350 1 ====
> > > osd_op_reply(4 mds_snaptable [read 0~0] ack = -2 (No such file or
> > > directory)) v4 ==== 112+0+0 (2505332647 0 0) 0x13b7a30 con
> > > 0x7fba20010200
> > >      0> 2013-07-29 17:02:57.627838 7fba2a8cd700 -1 mds/MDSTable.cc:
> > >      0> In function 'void MDSTable::load_2(int, ceph::bufferlist&,
> > >      0> Context*)' thread 7fba2a8cd700 time 2013-07-29
> > >      0> 17:02:57.626907
> > > mds/MDSTable.cc: 150: FAILED assert(0)
> > > 
> > >  ceph version 0.61.7 (8f010aff684e820ecc837c25ac77c7a05d7191ff)
> > >  1: (MDSTable::load_2(int, ceph::buffer::list&, Context*)+0x4cf)
> > > [0x6e398f] 2: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0xe1e)
> > > [0x73c16e] 3: (MDS::handle_core_message(Message*)+0x93f) [0x4db2ff]
> > >  4: (MDS::_dispatch(Message*)+0x2f) [0x4db3df]
> > >  5: (MDS::ms_dispatch(Message*)+0x1a3) [0x4dd163]
> > >  6: (DispatchQueue::entry()+0x399) [0x7ddd69]
> > >  7: (DispatchQueue::DispatchThread::entry()+0xd) [0x7d343d]
> > >  8: (()+0x77b6) [0x7fba2f51e7b6]
> > >  9: (clone()+0x6d) [0x7fba2e15dd6d]
> > >  ...
> > > 
> > > At this point I have no rbd, no cephfs, no ceph-fuse configured.
> > > 
> > >   /etc/init.d/ceph -a stop
> > >   /etc/init.d/ceph -a start
> > > 
> > > doesn't help.
> > > 
> > > Any help would be appreciated.
> > > 
> > > Andreas Friedrich
> > > ----------------------------------------------------------------------
> > > FUJITSU
> > > Fujitsu Technology Solutions GmbH
> > > Heinz-Nixdorf-Ring 1, 33106 Paderborn, Germany
> > > Tel: +49 (5251) 525-1512
> > > Fax: +49 (5251) 525-321512
> > > Email: andreas.friedrich@ts.fujitsu.com
> > > Web: ts.fujitsu.com
> > > Company details: de.ts.fujitsu.com/imprint
> > > ----------------------------------------------------------------------
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 
> 
> -- 
> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
> Heinrich Boell Strasse 88           Phone: (+49) 89 4317582
> D-81829 Muenchen (Germany)          Mobil: (+49) 177 522 0151
> 
> 
