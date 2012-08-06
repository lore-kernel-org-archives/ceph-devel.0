From: Matthew Roy <imjustmatthew@gmail.com>
Subject: Re: "no key for auth" when running "auth export mon. -o /tmp/monkey"?
Date: Mon, 6 Aug 2012 17:07:40 -0400
Message-ID: <CADXA5U1eCkv+vrRz-YixBGiUVuQVksn-HwW9NDLG0spGx6Sfgg@mail.gmail.com>
References: <CADXA5U0m-PXRnZJhN83+HQ6uZXiM76A+ZD=q2JdrUD_8-q0Gmg@mail.gmail.com>
	<CADvuQRG=3bX0L2BfTpnQkv3S8OvnZ2qo8uf0ezvta0MYZmzSiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43831 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856Ab2HFVHk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 17:07:40 -0400
Received: by obbuo13 with SMTP id uo13so6424974obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 14:07:40 -0700 (PDT)
In-Reply-To: <CADvuQRG=3bX0L2BfTpnQkv3S8OvnZ2qo8uf0ezvta0MYZmzSiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: John Wilkins <john.wilkins@inktank.com>, ceph-devel@vger.kernel.org

On Mon, Aug 6, 2012 at 11:55 AM, Tommi Virtanen <tv@inktank.com> wrote:
> Do you have the file "keyring" in your
> mon data dir, and does it contain a [mon.] section? If so, that
> section is what you need in /tmp/monkey. If you're going by defaults,
> there should be no other section in the file, and you can use the file
> as-is.

Yes, and that worked to initialize the new monitor.

Thanks Tommi.

Matthew
