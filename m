From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH 1/2 v2] rbd: allow importing from stdin
Date: Wed, 16 May 2012 16:51:24 -0700
Message-ID: <CADvuQRH9KYM1KswDTBKsuMPKxqMdH0CBM=sGZq3BfMvWAG7sDQ@mail.gmail.com>
References: <20120516203233.GA32219@sir.fritz.box> <CAC-hyiGsyMU5TogJ7SA8tQDVFY4Z5ht_hTwFB9dTsZgihBZJWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39124 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933305Ab2EPXv5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 May 2012 19:51:57 -0400
Received: by dady13 with SMTP id y13so1645635dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 16:51:57 -0700 (PDT)
In-Reply-To: <CAC-hyiGsyMU5TogJ7SA8tQDVFY4Z5ht_hTwFB9dTsZgihBZJWw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Wed, May 16, 2012 at 3:25 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> I'd rather not pass size for stdin. We should instead make it so that
> we don't read size at all and just importing while !eof (or do that
> only when size is 0). We'd need to create the image with size=0 and
> update the header in the end.

Hopefully something there would prevent us from leaking objects if the
rbd import crashed half way through. Perhaps the header needs to
change before each object gets created?
