From: GuangYang <yguang11@outlook.com>
Subject: Bucket index op - lock contention hang op threads
Date: Thu, 5 Feb 2015 09:36:14 +0000
Message-ID: <BLU175-W313E35FB584EA01A9D258CDF3B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s22.hotmail.com ([65.55.111.161]:54479 "EHLO
	BLU004-OMC4S22.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756925AbbBEJgP convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 Feb 2015 04:36:15 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sweil@redhat.com>

Hi ceph-devel,
In our ceph cluster (with rgw), we came across a problem that all rgw p=
rocess are stuck (all worker threads wait for the response from OSD, an=
d start giving 500 to clients). objecter_requests dump showed the slow =
in flight requests were caused by one OSD, which has 2 PGs doing backfi=
lling and it has 2 bucket index objects.

At OSD side, we configure 8 threads, it turned out when this problem oc=
curred, several op threads took seconds (even tens of seconds) handling=
 bucket index op, with most of time waiting for the ondisk_read_lock. A=
s a result, the throughput of the op threads drop (qlen increasing).

I am wondering what options we can pursue to improve the situation, som=
e general ideas on my mind:
=A01> Similar to OpContext::rwstate, instead of make the op thread stuc=
k, put this op to a waiting list and notify upon lock available. I am n=
ot sure if this worth it or break anything.
=A02> Differentiate the service class at filestore level for such OP - =
somebody is waiting for its release of the lock. Does this break any as=
sumption at filestore layer?

As we are using EC (8+3), the fan out is more than replication pool, su=
ch kind of slow from one OSD could be cascading to more OSDs easier.

BTW, I created a tracker for this - http://tracker.ceph.com/issues/1073=
9

Look forward to your suggestions.

Thanks,
Guang 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
