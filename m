From: Veronica Estrada Galinanes <veg@ucsc.edu>
Subject: Criteria behind disk scrubbing policy
Date: Wed, 9 Mar 2016 00:21:15 -0800
Message-ID: <CAKiXLjenBAB76AJ9qirL5Ff_GDz6E3sGXUie90xrsqydUqFVTw@mail.gmail.com>
Reply-To: veg@ucsc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:32903 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbcCIIVQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 03:21:16 -0500
Received: by mail-io0-f170.google.com with SMTP id n190so57533491iof.0
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 00:21:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

=46rom ceph website: "Deep scrubbing (weekly) reads the data and uses
checksums to ensure data integrity.=E2=80=9D

1. Why do you use "weekly" deep scrubbing? How many times a year one di=
sk
is scrubbed on average in a Ceph cluster? Schwartz* used three times pe=
r
year. =E2=80=9CInterestingly, we did not observe a further decrease in =
data loss as
we increased the scrubbing frequency from three to eleven times per yea=
r;
rather, a slight increase in data loss was noticed. This phenomenon com=
es
from the POH (power-on-hour) effect on drive reliability. Aggressive
scrubbing requires more power cycles, adversely affecting drive reliabi=
lity.
"

2. Do you have different scrubbing policies according to the redundancy
method? For example, more scrubs when using replication rather than era=
sure
coding?

*Schwarz, Thomas JE, et al. "Disk scrubbing in large archival storage
systems." *Modeling, Analysis, and Simulation of Computer and
Telecommunications Systems, 2004.(MASCOTS 2004). Proceedings. The IEEE
Computer Society's 12th Annual International Symposium on*. IEEE, 2004.

Thanks,

--=20

Vero EG
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
