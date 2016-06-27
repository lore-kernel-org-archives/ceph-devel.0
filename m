From: Jeff Layton <jlayton@redhat.com>
Subject: is the renewal in dentry_lease_is_valid necessary?
Date: Mon, 27 Jun 2016 15:07:21 -0400
Message-ID: <1467054441.25213.20.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33722 "EHLO
	mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcF0TPa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 15:15:30 -0400
Received: by mail-qt0-f179.google.com with SMTP id c34so27071972qte.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 12:15:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zheng Yan <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I'm eyeballing how to make ceph dentry revalidation occur in rcu-walk
mode in the kernel cephfs client. It looks fairly straightforward, but
for one thing:

dentry_lease_is_valid queues an asynchronous lease renewal if we're
halfway to the next lease renewal time:

=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (session) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ceph_mdsc_lease_send_msg(session, dir, dentry,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CEPH_MDS_LEASE_RENEW, seq);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ceph_put_mds_session(session);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

That can sleep, so we have to drop out of rcu walk mode in that case.

Is this lease renewal strictly necessary? I can make the code drop out
of rcuwalk mode and try again in that case, but if this is just an
opportunistic thing, then it may be better for performance to take a
pass on renewing the lease early if we're still in RCU walk mode.

--=20
Jeff Layton <jlayton@redhat.com>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
