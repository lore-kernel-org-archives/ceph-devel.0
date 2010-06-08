From: Matthew Roy <imjustmatthew@gmail.com>
Subject: IPv6 Status
Date: Mon, 7 Jun 2010 22:24:58 -0400
Message-ID: <AANLkTikUFKCG8KEhbc3wqWRIbciPnIyNgJMSz5GucMj4@mail.gmail.com>
References: <AANLkTimTZSGxg-0LFo9BtSJpq74JV-I0V84m7I5DVxCB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61879 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0FHCZA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jun 2010 22:25:00 -0400
Received: by vws17 with SMTP id 17so818706vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jun 2010 19:24:59 -0700 (PDT)
In-Reply-To: <AANLkTimTZSGxg-0LFo9BtSJpq74JV-I0V84m7I5DVxCB@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On=A02009-10-02=A0there was a commit "use sockaddr_storage; and some=A0=
ipv6
support groundwork" but I can't find any references to IPv6 support
being completed. Did that commit actually complete IPv6 support or are
more changes still required?

Commit diff:
http://ceph.newdream.net/git/p=3Dceph.git;a=3Dcommitdiff;h=3Ddd732cbfc1=
c92f0d8dba2743a979baad6685a98c;hp=3D18b3bfc5650be6584c5c95fce447fa66fb9=
18a83

Thanks,
Matthew Roy
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
