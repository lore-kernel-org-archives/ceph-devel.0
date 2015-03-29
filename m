From: Alistair Israel <aisrael@gmail.com>
Subject: Script to extract backports log
Date: Mon, 30 Mar 2015 01:27:18 +0800
Message-ID: <CAHJ4zokWQ0T5RTMvToTgS_YZxPgQV11XTxKGaUX+gnzj5u1B0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36686 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbbC2R1t convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Mar 2015 13:27:49 -0400
Received: by oicf142 with SMTP id f142so101527883oic.3
        for <ceph-devel@vger.kernel.org>; Sun, 29 Mar 2015 10:27:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, Lo=C3=AFc.

Well, got some 'quality' coding time in over the weekend and managed
to hack this out:
https://gist.github.com/aisrael/b2b78d9dfdd176a232b9

You'll need GitPython (pip install gitpython). I managed to get
hyperlinks to issues, to the commits themselves, and even snuck in the
names of the people who've signed off on the commit.

What I can't figure out is how to get the simple component or module
name. For example, from how to get from "common/buffer.cc" (#6003) to
"buffer".

Also, using a related issue and commit, how to combine two related
ones. For example, #6614 is related to #6003, and in the release notes
both are listed as a single item.

=46inally, do you think I should exclude commits starting with "qa:" or
"test/...:"?

Cheers!
Alistair
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
