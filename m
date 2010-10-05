From: Leander Yu <leander.yu@gmail.com>
Subject: mds suicide
Date: Tue, 5 Oct 2010 12:48:14 +0800
Message-ID: <AANLkTikArjoBY7D6M5q3eKBH249hpd4BTVhgiVKE9RFn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151743fa106d1a1a0491d75e78
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37510 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab0JEEsQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 00:48:16 -0400
Received: by wwj40 with SMTP id 40so5118666wwj.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 Oct 2010 21:48:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--00151743fa106d1a1a0491d75e78
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I have a 46 machines cluster(44 osd/mon + 2 mds) running ceph now. MDS
is running in active/standby mode.
This morning one of the MDS suicide the log shows:

-------------------------------------------
2010-10-04 22:24:19.450022 7f2e5a1ee710 mds0.cache.ino(10000002b87)
pop_projected_snaprealm 0x7f2e50cd9f70 seq1
2010-10-04 22:26:12.180854 7f2debbfb710 -- 192.168.1.103:6800/2081 >>
192.168.1.106:0/2453428678 pipe(0x7f2e380013d0 sd=-1 pgs=2 cs=1
l=0).fault with nothing to send, going to standby
2010-10-04 22:26:12.181019 7f2e481dc710 -- 192.168.1.103:6800/2081 >>
192.168.1.111:0/18905730 pipe(0x7f2e38002250 sd=-1 pgs=2 cs=1
l=0).fault with nothing to send, going to standby
2010-10-04 22:26:12.181041 7f2dc3fff710 -- 192.168.1.103:6800/2081 >>
192.168.1.114:0/1945631186 pipe(0x7f2e38000f00 sd=-1 pgs=2 cs=1
l=0).fault with nothing to send, going to standby
2010-10-04 22:26:12.181149 7f2deaef6710 -- 192.168.1.103:6800/2081 >>
192.168.1.113:0/521184914 pipe(0x7f2e38002f90 sd=-1 pgs=2 cs=1
l=0).fault with nothing to send, going to standby
2010-10-04 22:26:12.181563 7f2deb5f5710 -- 192.168.1.103:6800/2081 >>
192.168.1.112:0/4272114728 pipe(0x7f2e38002ac0 sd=-1 pgs=2 cs=1
l=0).fault with nothing to send, going to standby
2010-10-04 22:26:13.777624 7f2e5a1ee710 mds-1.3 handle_mds_map i
(192.168.1.103:6800/2081) dne in the mdsmap, killing myself
2010-10-04 22:26:13.777649 7f2e5a1ee710 mds-1.3 suicide.  wanted
up:active, now down:dne
2010-10-04 22:26:13.777769 7f2e489e4710 -- 192.168.1.103:6800/2081 >>
192.168.1.101:0/15702 pipe(0x7f2e380008c0 sd=-1 pgs=1847 cs=1
l=0).fault with nothing to send, going to standby
------------------------------------------------------------------------------
Would you suggest how do I trouble shooting this issue? or should I
just restart the mds to recover it?

Thanks.

Regards,
Leander Yu.

--00151743fa106d1a1a0491d75e78
Content-Type: application/x-gzip; name="mds.1.log-20101005.gz"
Content-Disposition: attachment; filename="mds.1.log-20101005.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gewa6jlt0

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
--00151743fa106d1a1a0491d75e78--
