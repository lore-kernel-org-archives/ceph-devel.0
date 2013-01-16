From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph from poc to production
Date: Wed, 16 Jan 2013 19:41:53 +0100
Message-ID: <50F6F471.7030108@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:40132 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab3APSly (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 13:41:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello Sebastien,
   hello list,

first nice article sebastien ;-) thanks for contributing.

I've two question regarding the tips:

Can somebody explain me why i should do this?:
- Increase the osdmax value
- Set =E2=80=9Cfilestore flusher=E2=80=9D option to false, in your [osd=
] section

Greets,
Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
