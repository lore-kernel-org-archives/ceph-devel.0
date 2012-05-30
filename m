From: Tommi Virtanen <tv@inktank.com>
Subject: Re: rbd command : is it possible to pass authkey in argument ?
Date: Wed, 30 May 2012 10:40:46 -0700
Message-ID: <CADvuQRFSCJH5yyuUMK_QpnTW60xBXaPtuYujARjyxD+8=NgjYA@mail.gmail.com>
References: <1612d6e1-fed0-4cda-bfc4-df0006875f75@mailpro> <0a37bcdb-3791-4255-b403-1ca147cf02c0@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52539 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214Ab2E3RlG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 13:41:06 -0400
Received: by pbbrp8 with SMTP id rp8so253335pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 10:41:06 -0700 (PDT)
In-Reply-To: <0a37bcdb-3791-4255-b403-1ca147cf02c0@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

On Wed, May 30, 2012 at 2:15 AM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> Is it possible to pass authkey as argument in rbd command line ? (I can do in with qemu-rbd drive option)

I see you got an answer for your actual question. I wanted to take a
different angle.

You should really avoid putting secrets on command lines, or in
process environment. Those are readable to all local users. This is
why I advocate keyring files.

Alternatively, with qemu, the monitor command mechanism they have
would let you add the drives, before starting up the vm, without the
secrets being visible to others.
