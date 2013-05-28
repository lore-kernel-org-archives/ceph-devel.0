From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: Missing cluster   information
Date: Tue, 28 May 2013 11:32:39 -0700 (PDT)
Message-ID: <1369765959.34382.YahooMailNeo@web121905.mail.ne1.yahoo.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm37-vm7.bullet.mail.ne1.yahoo.com ([98.138.229.135]:27476 "EHLO
	nm37-vm7.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751851Ab3E1SiT convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 May 2013 14:38:19 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



When ceph-deploy creates a ceph.conf, it does not contain the hostname =
of the osd systems.=A0

1. in the even when the cluster goes down (due to a power outage or som=
e other reason), how can one get information about the system to help d=
ebug a problem or bring the cluster up?

2. Also, i noticed the command

=A0=A0=A0 /etc/init.d/ceph -a start/stop=A0=A0

=A0=A0=A0 or

=A0=A0=A0 service ceph start/stop


=A0=A0=A0 performs the action on the current host only but not to all h=
ost. We have seen this behavior on Centos. Also on Ubuntu it does not w=
ork.=A0 Therefore how=A0 does one start and stop the entire cluster wit=
hout running the command on every individual host?

Thank you

Isaac

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
