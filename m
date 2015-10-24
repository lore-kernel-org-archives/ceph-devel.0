From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Lock contention in do_rule
Date: Sat, 24 Oct 2015 00:41:20 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F31764194@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0075.outbound.protection.outlook.com ([157.56.110.75]:61289
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750869AbbJXAl0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 20:41:26 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
We are seeing the following mapper_lock is heavily contended and commenting out this lock is improving performance ~10 % (in the short circuit path).
This is called for every io from osd_is_valid_op_target().
I looked into the code ,but, couldn't understand the purpose of the lock , it seems redundant to me , could you please confirm ?


void do_rule(int rule, int x, vector<int>& out, int maxout,
               const vector<__u32>& weight) const {
    Mutex::Locker l(mapper_lock);
    int rawout[maxout];
    int scratch[maxout * 3];
    int numrep = crush_do_rule(crush, rule, x, rawout, maxout, &weight[0], weight.size(), scratch);
    if (numrep < 0)
      numrep = 0;
    out.resize(numrep);
    for (int i=0; i<numrep; i++)
      out[i] = rawout[i];
  }


Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

