From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] ceph: re-enable rados_aio_set_callback
Date: Wed, 5 May 2010 13:22:07 -0700
Message-ID: <h2oa37615151005051322z8a2c781ajdfe4f31fef78a8a1@mail.gmail.com>
References: <20100505195053.GA50246@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33936 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab0EEUWI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 May 2010 16:22:08 -0400
Received: by vws12 with SMTP id 12so1357188vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 May 2010 13:22:07 -0700 (PDT)
In-Reply-To: <20100505195053.GA50246@ncolin.muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Wed, May 5, 2010 at 12:50 PM, Christian Brunner <chb@muc.de> wrote:
=2E..
>
> To work around this, I=92d suggest to re-enable rados_aio_set_callbac=
k.
> This way it would possible to clear (cb=3DNULL) or change the callbac=
k
> handler.


Although this would solve that specific problem I'd rather leave this
function out, as it is racy and could be misused. I think having a
solution in which we either set different callbacks for the complete
and for the safe replies, or just set a flag that specifies when to
use this callback would be better.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
