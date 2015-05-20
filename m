From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: ceph-osd: microbenchmark for 4k read operations
Date: Wed, 20 May 2015 18:13:39 +0200
Message-ID: <20150520181339.0a630c07@doppio>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/w=58XcmZO/F3uDvtNOAzHsi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:30618 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbbETQnI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 May 2015 12:43:08 -0400
Received: from itxmail.itxperts.de (qgate_dmz.itxperts.de [192.168.160.1])
	by mail.itxperts.de (8.14.0/8.14.0) with ESMTP id t4KGDfWg025170
	for <ceph-devel@vger.kernel.org>; Wed, 20 May 2015 18:13:41 +0200
Received: from doppio (doppio.itxperts.de [192.168.140.7])
	by itxmail.itxperts.de (Postfix) with ESMTP id 3B79D13F02
	for <ceph-devel@vger.kernel.org>; Wed, 20 May 2015 18:05:05 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

--MP_/w=58XcmZO/F3uDvtNOAzHsi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

as discussed on todays performance meeting: find attached the
spreadsheet which I had shown during the meeting.

@Sam: your are right concerning the make_blist part: this
probably is expensive due to message signing being turned on.
For the osd daemon which I took the benchmarks, I see
    "cephx_sign_messages": "true"


Regards

Andreas

-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm

--MP_/w=58XcmZO/F3uDvtNOAzHsi
Content-Type: text/csv
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=summary-rr-transactions-32.csv


summary; samples; averages; min; max

PrimaryRead; 165889; 186; 103; 655
PrimaryRead-1.1 Pipe::reader:duration_0; 165889; 64; 29; 597
PrimaryRead-1.3 Pipe::read_message:duration_0; 165889; 9; 4; 171
PrimaryRead-1.4 Pipe::read_message:receive_0; 165889; 2; 1; 133
PrimaryRead-1.5 Pipe::read_message:decode_0; 165889; 5; 2; 166
PrimaryRead-1.6 Pipe::read_message:authenticate_0; 165889; 0; 0; 102
PrimaryRead-1.8 OSD::ms_fast_dispatch:duration_0; 165889; 33; 17; 482

PrimaryRead-2.2 ShardedOpWQ::_process:duration; 165889; 66; 25; 419
PrimaryRead-2.2.2 ReplicatedPG::do_op:duration; 165889; 49; 20; 397
PrimaryRead-2.2.3 ReplicatedPG::do_op:find_ctx; 165889; 2; 2; 140
PrimaryRead-2.2.4 ReplicatedPG::do_op:execute_ctx; 165889; 38; 13; 388

PrimaryRead-4.2 Pipe::writer:duration_4096; 165888; 52; 24; 322
PrimaryRead-4.3 Pipe::writer:encode_4096; 165888; 6; 3; 172
PrimaryRead-4.4 Pipe::writer:make blist_4096; 165888; 23; 14; 193
PrimaryRead-4.5 Pipe::writer:write_message_4096; 165888; 20; 6; 268

--MP_/w=58XcmZO/F3uDvtNOAzHsi--
