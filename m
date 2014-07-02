From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: Reliability model for RADOS - effects during second failures
Date: Thu, 3 Jul 2014 00:33:53 +0200
Message-ID: <CACUN8h3wp31D=2s4v_wFh7_fc0jqykjsg4ZtSnoWK-ti9V5xqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35307 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbaGBWdy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jul 2014 18:33:54 -0400
Received: by mail-ig0-f182.google.com with SMTP id l13so822071iga.9
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jul 2014 15:33:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Kyle Bader <kyle@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Kyle, Loic,

The current code uses a =E2=80=9CFIT rate multiplier=E2=80=9D to includ=
e for instance
the effect of operations done in parallel. That multiplier (n) has an
effect on Pfail. In the initial failure, it is calculated using the
number of replicas and the stripe count as seen in
https://github.com/ceph/ceph-tools/blob/master/models/reliability/Rados=
Rely.py#L86.

The thing that doesn=E2=80=99t have sense to me is the way the multipli=
er is
calculated for the failure of the remaining copies in
https://github.com/ceph/ceph-tools/blob/master/models/reliability/Rados=
Rely.py#L92
Why the stripes are not taking into account? What is the purpose of
using the =E2=80=9Cdeclustering factor=E2=80=9D on that equation? Is th=
at equation
correct? I read this note by sage
https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg01650.html
trying to clarify the role of PGs but didn=E2=80=99t help me to underst=
and it.

Besides, I have a simple question related with the equation on L86 for
the initial failure. The stripping process splits user content in
#number of objects, which equivalent to the stripe count. That group
of objects constitutes an object set. Each object is composed by one
or more stripes units. All stripes units (stripe count) are written in
parallel. Typically each object is mapped to a different disk.  What
happen when the object set is full and a new object is started? Are
this new objects assigned to same disks used for the previous full
object set?

Best

koleosfuscus

________________________________________________________________
"My reply is: the software has no known bugs, therefore it has not
been updated."
Wietse Venema
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
