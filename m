From: Gregory Farnum <greg@gregs42.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 09:55:01 -0800
Message-ID: <CAC6JEv-r2a6UOWOd8XKsn4armJU4iR76eYtG3kR4eGmKW6k++w@mail.gmail.com>
References: <54B7D2D6.4020503@42on.com>
	<CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com>
	<alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
	<alpine.DEB.2.00.1501150942450.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45110 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbbAORzE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 12:55:04 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so16220950iec.8
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 09:55:02 -0800 (PST)
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com. [209.85.213.177])
        by mx.google.com with ESMTPSA id p137sm1360447ioe.29.2015.01.15.09.55.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 09:55:01 -0800 (PST)
Received: by mail-ig0-f177.google.com with SMTP id z20so15833205igj.4
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 09:55:01 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501150942450.26676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Yehuda Sadeh <yehuda@redhat.com>, Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 15, 2015 at 9:44 AM, Sage Weil <sweil@redhat.com> wrote:
> In addition (or instead of) making the API harder to fat-finger, we c=
ould
> also add a mon config option like
>
>  mon allow pool deletion =3D false
>
> that defaults off.  Then, to delete any pool, you need to update ceph=
=2Econf
> and restart mons or inject the config option change (ceph daemon
> mon.`hostname` conig set ... on the leader) or the API will give you
> EPERM.
>
> This offers some protection even for client.admin key users if we pre=
vent
> injectargs for that option (maybe feasible) and they don't have acces=
s to
> the actual mon machine.

What would that buy us? Preventing injectargs on it would require mon
restarts, which is unfortunate =E2=80=94 and makes it sounds more like =
a
security feature than a safety blanket.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
