From: Joshua Schmid <jschmid@suse.de>
Subject: Proposal: data-at-rest encryption
Date: Mon, 24 Aug 2015 11:16:39 +0200
Message-ID: <55DAE0F7.1070905@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59413 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbbHXJP0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Aug 2015 05:15:26 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 076F1AAF6
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2015 09:15:25 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,


just as a quick preface:

I'm fairly new to ceph, so forgive me any blunders :) But back to the t=
opic.

after following several discussions on how to implement data-at-rest
encryption in ceph i want to add my two cents.



What is used:

a dedicated FTPS server for key-handling


How it will work:

Specify your key-server in ceph.conf.
Preparing and activating an OSD as usual via --dmcrypt. The newly
created key will be uploaded and deleted locally. On the initial unlock
it will already be retrieved via network.


Why is this a good way:

Taking in consideration that MONs are not the best place to put the key=
s
imho, a dedicated machine is a good place to put them since you are abl=
e
to take care of additional security arrangements.


What needs attention:

- The dedicated server is a single point of failure.
- If you add more servers, is rsync enough?
- Prevent swapping on key retrieval. (mlockall)



This is what i did so far:

https://github.com/jschmid1/ceph/commit/fee26890c24bd3a7b8865295546297e=
3f144e6d0?diff=3Dunified


ANY feedback is welcome :)


--=20
=46reundliche Gr=C3=BC=C3=9Fe - Kind regards,
Joshua Schmid
Trainee - Storage
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 N=C3=BCrnberg
-----------------------------------------------------------------------=
---------------------------------------------
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Jennifer Guild, Dilip Upmanyu, Graham Norton, HRB 21284 (AG N=C3=BCrnbe=
rg)
-----------------------------------------------------------------------=
---------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
