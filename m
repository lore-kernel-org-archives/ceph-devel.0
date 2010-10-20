From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: read/write on RADOS using external buffer
Date: Tue, 19 Oct 2010 22:55:34 -0700
Message-ID: <AANLkTin0+n+e6Cb_WJcz5JA7xR_XG_K=2k0_bhSDuDRh@mail.gmail.com>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
	<Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
	<20101019222727.GA1737@enoki.dokukino.com>
	<AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
	<Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55949 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab0JTFzf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 01:55:35 -0400
Received: by fxm4 with SMTP id 4so2397186fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Oct 2010 22:55:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Takuya ASADA <syuu@dokukino.com>, ceph-devel@vger.kernel.org

On Tue, Oct 19, 2010 at 9:26 PM, Sage Weil <sage@newdream.net> wrote:
> =A0- SimpleMessenger::read_message() just needs to call
> ms_deliver_get_data_buffer() if data_len > 0. =A0If it returns true, =
use the
> provided bufferptr.
>
> =A0- The existing Objecter::read() method returns the tid, which libr=
ados
> can then store in a private map of tid -> bufferptrs. =A0When it's
> ms_get_data_buffer() is called it can provide the bufferptr; no need =
to
> modify the Objecter at all! =A0Just make sure to verify that the entr=
y
> exists in the map before using the operator[] (use find()).

If we want thread-local data, we should at least use
pthread_setspecific / pthread_getspecific. No need for tids and STL
maps. gettid() is a syscall and it will be slow.

> The main corner case is this: if there is some osd cluster change, it=
's
> theoretically possible we could have two threads reading read replies=
 to
> the same request off the wire at the same time. =A0Even if we careful=
ly
> define which reply "wins", we need to make sure there isn't a stray t=
hread
> read/accessing the buffer after the read() call returns.

I just don't see why we have to care about threads at all. If we need
rados client-specific data, it should definitely be in class
RadosClient. Otherwise, we should just get rid of class RadosClient,
because it's useless.

> I'm not sure what the solution to that one is yet. =A0The kclient doe=
sn't
> have separate threads, and takes pains to yank the pages out from und=
er
> incoming message; that approach doesn't work well with the SimpleMess=
enger
> threading model. =A0:/

I think I can propose a patch which solves this problem without rados
client-specific data, threads, tids, maps, thread-local data, or
changes to SimpleMessenger. It will just involve modifying bufferlist
so that it can use a buffer that's passed to it, rather than
allocating its own. Then we need something like a freeze operation
that will stop it from trying to reallocate or resize the buffer. This
solution will have much more generality and probably will be useful
elsewhere too.

Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
