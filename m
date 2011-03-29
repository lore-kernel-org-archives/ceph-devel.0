From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: librados compound operations
Date: Mon, 28 Mar 2011 18:29:30 -0700
Message-ID: <AANLkTin9P9UMSmKPmVwMCSBjPMQ6zGKVamzUbQaPmkVJ@mail.gmail.com>
References: <Pine.LNX.4.64.1103281539580.17288@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46967 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab1C2B3c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 21:29:32 -0400
Received: by fxm17 with SMTP id 17so3119737fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2011 18:29:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1103281539580.17288@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 28, 2011 at 3:46 PM, Sage Weil <sage@newdream.net> wrote:
> Below is a patch that wraps the internal Objecter compound ObjectOper=
ation
> so that we can send compound operations to the OSDs via librados.
>
> The internal ObjectOperationImpl ends up being unnecessary; I just ca=
st it
> to the internal type directly.
>
> One weird thing I noticed is with the constructor. =A0In Rados:: did
>
> + =A0 =A0static ObjectOperation *operation_create();
>
> and the user then deletes it when they're done (after using it for on=
e or
> more calls to operate() or aio_operate()). =A0Is that the the approac=
h we
> want? =A0Because right above that in the header is
>
> =A0 =A0 int ioctx_create(const char *name, IoCtx &pioctx);
>

I second TV's argument that returning a detailed error code is better
than returning NULL or not-NULL.

I also don't like calling conventions that always use dynamic memory
allocation. Even on a shiny new 16-core system, there is still a
global mutex around new()/free(). I also like putting stuff on the
stack and using RAII. (I haven't looked at this new code enough to see
whether RAII makes sense here though.)

If we do go with the new/free based approach, I guess we need another
function to call free() on it, because the library user might be using
a different libc.

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
