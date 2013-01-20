From: Gregory Farnum <greg@inktank.com>
Subject: Re: osd max write size
Date: Sun, 20 Jan 2013 14:20:55 -0800
Message-ID: <F9430D5EBF0C4AF69B6294426724EAC0@inktank.com>
References: <50FC4034.4070906@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:57875 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab3ATWU5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 17:20:57 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so3017774pad.3
        for <ceph-devel@vger.kernel.org>; Sun, 20 Jan 2013 14:20:57 -0800 (PST)
In-Reply-To: <50FC4034.4070906@profihost.ag>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Sunday, January 20, 2013 at 11:06 AM, Stefan Priebe wrote:
> Hi,
> =20
> what is the purpose or idea behind this setting?
> =20
Couple different things:
1) The OSDs can't accept writes which won't fit inside their journal, a=
nd if you have a small journal you could conceivably attempt to write s=
omething which wouldn't fit. This doesn't happen so much any more, but =
it did sometimes in the past.
1b) The MDS uses this setting to limit the size of some of its operatio=
ns (mostly directory updates), which can (rarely) grow quite large.
2) The OSDs don't have any other strict limits on how large an op you s=
end around, but performance becomes a problem if they grow too large. T=
his setting caps the operation size it allows.

It defaults to 90MB and you can change it if you want to, but I'm not s=
ure why you would=E2=80=A6
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
