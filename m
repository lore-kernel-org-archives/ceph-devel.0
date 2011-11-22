From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Metadata queries on Ceph/RADOS
Date: Tue, 22 Nov 2011 13:41:32 +0530
Message-ID: <CAMiHsJJN1UB++ijcorzBBi=YD9eawur62WF9L1QxtwwiH78HXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51415 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab1KVILz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2011 03:11:55 -0500
Received: by fagn18 with SMTP id n18so109046fag.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2011 00:11:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello

Does RADOS support metadata queries? I have gone through librados and
the "rados" command line tool, and there doesn't seem to be a way for
me to say, query the object store saying: "Give me all objects with
Xattr Video =3D 1". The only way I can think of is to write some of my
own code using librados.

Any pointers if the system has a metadata service or something that I
can query?

(I have seen few diagrams=A0showing a metadata cluster as part of Ceph
which supports metadata operations, how can I leverage that? reference
diagram: http://www.usenix.org/event/osdi06/tech/full_papers/weil/weil_=
html/fig/overview.png)

=A0Regards
Atish
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
