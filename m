From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Hard to debug problem with ceph_erasure_code
Date: Thu, 31 Mar 2016 19:10:45 +0200
Message-ID: <56FD5A15.1080507@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:14809 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbcCaRLU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 Mar 2016 13:11:20 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 31809153416
	for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 19:11:17 +0200 (CEST)
Received: from [IPv6:2001:4cb8:3:1:301d:d194:f8e3:4290] (unknown [IPv6:2001:4cb8:3:1:301d:d194:f8e3:4290])
	by smtp.digiware.nl (Postfix) with ESMTP id 19BAA1534C6
	for <ceph-devel@vger.kernel.org>; Thu, 31 Mar 2016 19:10:55 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I have this problem that testing ceph_erasure_code sometimes crashes in:

	ceph_erasure_code --debug-osd 20 --plugin_exists jerasure

If I just run this in a while loop on the command line then it crashes 
only once every few hundert runs.
Running it in the testset it crashes just about every time.

The crash from the core is an invalid point in the assertion code I 
added to log/Entry.h

#7  0x000000000077984d in ceph::log::Entry::hint_size (this=0x80405cf00) 
at log/Entry.h:70
70            assert( *m_exp_len != -1 );
(gdb) l
65        }
66
67        // function improves estimate for expected size of message
68        void hint_size() {
69          if (m_exp_len != NULL) {
70            assert( *m_exp_len != -1 );
71            assert( 0 <= *m_exp_len );
72            assert( *m_exp_len <= 100000 );
73            size_t size = m_streambuf.size();
74            if (size > __atomic_load_n(m_exp_len, __ATOMIC_RELAXED)) {
(gdb) p m_exp_len
$1 = (size_t *) 0x8045ec5c0
(gdb) p &m_exp_len
$2 = (size_t **) 0x80405cf90

the address in m_exp_len 0x8045ec5c0 is outside of the heap, and gives 
an illegal access.
And thus the program gets a SIGSEGV

Now my problem is that I can run this under gdb and watch the memory. 
But that rarely goes wrong.
Running it from 'make recheck' goes wrong just about every time but it 
will be hard to run that
trhu gdb and actually catch the code that is writting the illegal 
address into m_exp_len.

Does anybody have suggestions as how to track/debug this?

Thanx,
--WjW
