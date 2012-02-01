From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: Problem while reading the paper about CRUSH
Date: Wed, 1 Feb 2012 12:13:47 +0800
Message-ID: <CALwGbPKOTSD81-Gtg=uP7Et7prOv5Lp=NHrMbAz1-HHemaN2Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53183 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab2BAENt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 23:13:49 -0500
Received: by ghrr11 with SMTP id r11so391921ghr.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 20:13:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone.
I'm new here and interested in the CRUSH algorithm which is a part of
Ceph, so I'm just reading the paper from
http://ssrc.ucsc.edu/Papers/weil-sc06.pdf
Unfortunately I'm not native English speaker, so I do have some
problem understanding the content. I wish anybody here could help.

I encounter the word "decluster" which cannot be found in a
dictionary. I think it should have something to do with "cluster", but
I'm not able to tell the actual meaning of it.
Appearance: page 1
=46urther, existing randomized distribution schemes that decluster
replication by spreading each disk=92s replicas across many other
devices suffer from a high probability of data loss from coincident
device failures.
Appearance: page 2
We say that CRUSH generates a declustered distribution of replicas in
that the set of devices sharing replicas for one item also appears to
be independent of all other items.

2. I don't understand "per-device weight value"
Appearance: page 2
The CRUSH algorithm distributes data objects among storage devices
according to a per-device weight value, approximating a uniform
probability distribution.

3. What does the word "metric" mean?
Appearance: page 3
This results in a one-dimensional placement metric, weight, which
should be derived from the device=92s capabilities.

It seems slow that I can go through only 1 page per day averagely.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
