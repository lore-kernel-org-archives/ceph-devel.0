From: Florian Haas <florian@hastexo.com>
Subject: Re: "Radosgw installation and administration" docs
Date: Mon, 2 Jul 2012 09:06:49 +0200
Message-ID: <CAPUexz-BJwOc-2fF8WmkBQL10nvPx6F+uq9ncL5qa-VX7z1WJQ@mail.gmail.com>
References: <4FD71854.6060503@hastexo.com>
	<CAPUexz-nq-rs3CdougTBpiiur__W0royUcaMdYfpfamwkh7jNw@mail.gmail.com>
	<CAC-hyiEDLJTkDKXLgR64cPE5mcPvWUCs6kCCq+DiRaCtvDEEFQ@mail.gmail.com>
	<4FD78636.9080607@hastexo.com>
	<CAC-hyiF5PVR9nzjewG6VjPCGdjAeuio8Gqf9_juZKWRZZ1KpaQ@mail.gmail.com>
	<loom.20120701T222011-780@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:41505 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080Ab2GBHGu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 03:06:50 -0400
Received: by qaas11 with SMTP id s11so1716361qaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 00:06:50 -0700 (PDT)
In-Reply-To: <loom.20120701T222011-780@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chuanyu <chuanyu@cs.nctu.edu.tw>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 1, 2012 at 10:22 PM, Chuanyu <chuanyu@cs.nctu.edu.tw> wrote:
> Hi Yehuda, Florian,
>
> I follow the wiki, and steps which you discussed,
> construct my ceph system with rados gateway,
> and I can use libs3 to upload file via radosgw, (thanks a lot!)
> but got "405 Method Not Allowed" when I use swift,
>
> $ swift -v -A http://s3.paca.tw:80/auth -U paca:paca1 -K
> UoJO4nFgdAoX+9nEftElIY+AMmDIkcrUBkycNKPA stat
> Auth GET failed: http://s3.paca.tw:80/auth/tokens 405 Method Not Allowed
>
> ( Because there has no test step on wiki,
>  I follow the Florian's question, and guess the test command is above ?!)
>
> my radosgw-admin config:
> $ radosgw-admin user info --uid=paca
> { "user_id": "paca",
>   "rados_uid": 0,
>   "display_name": "chuanyu",
>   "email": "chuanyu@cs.nctu.edu.tw",
>   "suspended": 0,
>   "subusers": [
>         { "id": "paca:paca1",
>           "permissions": "<none>"}],

This is most likely your problem. You're being bitten by
http://tracker.newdream.net/issues/2650.

Try "radosgw-admin subuser modify --subuser=paca:paca1 --access=full"
and see if that improves things.

Cheers,
Florian
