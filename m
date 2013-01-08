From: Amon Ott <ao@m-privacy.de>
Subject: Re: v0.56.1 released
Date: Tue, 08 Jan 2013 08:44:29 +0100
Message-ID: <50EBCE5D.3020601@m-privacy.de>
References: <alpine.DEB.2.00.1301072052180.20676@cobra.newdream.net> <50EBCB21.9090207@profihost.ag> <CABYiri_ECmQGPJDvZoGUybFKuc7HYgk4PJ193U+oTebNMD=O7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:38326 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab3AHHoj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Jan 2013 02:44:39 -0500
In-Reply-To: <CABYiri_ECmQGPJDvZoGUybFKuc7HYgk4PJ193U+oTebNMD=O7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Am 08.01.2013 08:40, schrieb Andrey Korolyov:
> On Tue, Jan 8, 2013 at 11:30 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> Hi,
>>
>> i cannot see any git tag or branch claming to be 0.56.1? Which commi=
t id is
>> this?
>>
>> Greets
>>   Stefan
>=20
> Same for me, github simply does not sent a new tag in the pull to
> local tree by some reason. Repository cloning from scratch resolved
> this :)

This is normal git behaviour. "git fetch -t" is your friend.

Amon Ott
--=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=C3=B6llnischen Park 1    Fax: +49 30 99296856
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=C3=A4ftsf=C3=BChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
