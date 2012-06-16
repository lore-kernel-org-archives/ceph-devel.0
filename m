From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RBD layering design draft
Date: Fri, 15 Jun 2012 19:00:59 -0700
Message-ID: <CAC-hyiEGzAF=hAae6mZLjOd+5jckVZD6+WfvJHpCYuueDCCX7g@mail.gmail.com>
References: <4FDB9FBB.9000807@inktank.com>
	<Pine.LNX.4.64.1206151742380.28086@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63982 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab2FPCBB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 22:01:01 -0400
Received: by bkcji2 with SMTP id ji2so2844793bkc.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 19:01:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206151742380.28086@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 15, 2012 at 5:46 PM, Sage Weil <sage@inktank.com> wrote:
> Looks good! =A0Couple small things:
>
>> =A0 =A0 $ rbd unpreserve pool/image@snap
>
> Is 'preserve' and 'unpreserve' the verbiage we want to use here? =A0N=
ot sure
> I have a better suggestion, but preserve is unusual.
>

freeze, thaw/unfreeze?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
