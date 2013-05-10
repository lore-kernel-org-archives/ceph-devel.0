From: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: Re: 0.56.6: MDS asserts on restart
Date: Fri, 10 May 2013 22:02:34 +0200
Message-ID: <518D525A.6020900@filoo.de>
References: <518CF45B.7010402@de-punkt.de> <alpine.DEB.2.00.1305100841001.25318@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-2.de-punkt.de ([93.190.64.238]:37338 "EHLO
	mail-2.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab3EJUM3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 May 2013 16:12:29 -0400
In-Reply-To: <alpine.DEB.2.00.1305100841001.25318@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Christopher Kunz <chrislist@de-punkt.de>, ceph-devel@vger.kernel.org

Am 10.05.2013 17:41, schrieb Sage Weil:
> On Fri, 10 May 2013, Christopher Kunz wrote:
>> Hi all,
>>
>> after our update to 0.56.6, all MDSes assert and crash on start. This is
>> not essential for our setup, but still not great. We assume this might
>> be due to a bug - see the nopaste below for a trace.
>>
>> http://nopaste.info/aa06c50a2f.html
> Do you have the stack trace from the mds log file?  There should be an
> assertion message and a line number.
>
> Thanks!
> sage
>

Hi Sage,

here is the assertion message:

2013-05-10 14:43:26.910355 7f97d7eff700  1 mds.0.15  waiting for osdmap 
54251 (which blacklists prior instance)
2013-05-10 14:43:26.910402 7f97d7eff700  1 mds.0.cache 
handle_mds_failure mds.0 : recovery peers are
2013-05-10 14:43:26.912222 7f97d66fc700 -1 mds/MDSTable.cc: In function 
'void MDSTable::load_2(int, ceph::bufferlist&, Context*)' thread 
7f97d66fc700 time 2013-05-10 14:43:26.911096
mds/MDSTable.cc: 150: FAILED assert(0)

  ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
  1: (MDSTable::load_2(int, ceph::buffer::list&, Context*)+0x421) [0x679b91]
  2: (Context::complete(int)+0xa) [0x4ab36a]
  3: (Objecter::check_op_pool_dne(Objecter::Op*)+0xdd) [0x6c6ccd]
  4: (Objecter::C_Op_Map_Latest::finish(int)+0x27a) [0x6c725a]
  5: (Finisher::finisher_thread_entry()+0x1c0) [0x7ed100]
  6: (()+0x7e9a) [0x7f97dcaede9a]
  7: (clone()+0x6d) [0x7f97db98eccd]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

Do you need something more ?

Jens


