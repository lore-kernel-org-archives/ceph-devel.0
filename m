From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] New Calamari server
Date: Tue, 12 May 2015 10:35:25 +0200 (CEST)
Message-ID: <1308156878.221639216.1431419724991.JavaMail.zimbra@oxygem.tv>
References: <D1766F6E.30C8E%mk7193@yp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:36668 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbbELIff convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 04:35:35 -0400
In-Reply-To: <D1766F6E.30C8E%mk7193@yp.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Kuriger <mk7193@yp.com>
Cc: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi, when you have remove salt from nodes,=20

do you have remove the old master key
/etc/salt/pki/minion/minion_master.pub

?

I have add the same behavior than you when reinstalling calamari server=
, and previously installed salt on ceph nodes
(with explicit error about the key in /var/log/salt/minion on ceph node=
s)

----- Mail original -----
De: "Michael Kuriger" <mk7193@yp.com>
=C3=80: "ceph-users" <ceph-users@ceph.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Lundi 11 Mai 2015 23:43:34
Objet: [ceph-users] New Calamari server

I had an issue with my calamari server, so I built a new one from scrat=
ch.=20
I=C2=B9ve been struggling trying to get the new server to start up and =
see my=20
ceph cluster. I went so far as to remove salt and diamond from my ceph=20
nodes and reinstalled again. On my calamari server, it sees the hosts=20
connected but doesn=C2=B9t detect a cluster. What am I missing? I=C2=B9=
ve set up=20
many calamari servers on different ceph clusters, but this is the first=
=20
time I=C2=B9ve tried to build a new calamari server.=20

Here=C2=B9s what I see on my calamari GUI:=20

New Calamari Installation=20

This appears to be the first time you have started Calamari and there a=
re=20
no clusters currently configured.=20

33 Ceph servers are connected to Calamari, but no Ceph cluster has been=
=20
created yet. Please use ceph-deploy to create a cluster; please see the=
=20
Inktank Ceph Enterprise documentation for more details.=20

Thanks!=20
Mike Kuriger=20




_______________________________________________=20
ceph-users mailing list=20
ceph-users@lists.ceph.com=20
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
