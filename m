From: =?UTF-8?B?5p2O5rKb5Lym?= <lpl6338236@gmail.com>
Subject: Will the number of objects that have ever existed be infinite?
Date: Sat, 23 May 2015 14:58:22 +0800
Message-ID: <CAPS90kgipTtHpamtsT6C3ZBugn4djmDW7jXrveEf9FjKY1yoUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33373 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbbEWG6W convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 May 2015 02:58:22 -0400
Received: by igbpi8 with SMTP id pi8so6988224igb.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 May 2015 23:58:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello!

I'm a GSoC student this year and my job is to introduce Missing Rate
Curve (or reuse distance exactly) of objects into OSD. Now I'm trying
to find a proper algorithm to implement but there is a problem: Should
I take the number of objects tracked in an OSD as infinite or
constant?

The point is that there is an algorithm that use hash to sample only
constant number of references to do the analysis and is proved to be
accurate, which makes it possible to do online MRC construction. That
accuracy is supported by the fact that the memory addresses is
bounded, while objects can be deleted and created again and again in
Ceph. Is is reasonable to think that an OSD only serves bounded number
of objects in its life time (or the time period that we want to
compute MRC)?

Any other comment about this project is also welcomed :)

--=20
Li Peilun (=E6=9D=8E=E6=B2=9B=E4=BC=A6)
Yao Class J10
Institute for Interdisciplinary Information Sciences
Tsinghua University
Beijing,100084
P.R.China
Tel:86-18810671857
E-mail: lpl6338236@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
