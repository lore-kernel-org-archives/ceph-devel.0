From: Samuel Just <sam.just@inktank.com>
Subject: Re: ghobjects: assert in FileStore::lfn_open
Date: Mon, 7 Oct 2013 13:14:36 -0700
Message-ID: <CA+4uBUbv3Gn0BzrScfyujUkg6beZKeAYYAPt6cA37f-3gi4RfA@mail.gmail.com>
References: <52459234.9060609@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:64793 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab3JGUOh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Oct 2013 16:14:37 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so3554443eek.13
        for <ceph-devel@vger.kernel.org>; Mon, 07 Oct 2013 13:14:36 -0700 (PDT)
In-Reply-To: <52459234.9060609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: David Zafman <david.zafman@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

That sounds better to me, since the generation stuff triggers the same
format switch.
-Sam

On Fri, Sep 27, 2013 at 7:12 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi David,
>
> In
>
> int FileStore::lfn_open(coll_t cid,
>                         const ghobject_t& oid,
>                         bool create,
>                         FDRef *outfd,
>                         IndexedPath *path,
>                         Index *index)
> {
>   assert(get_allow_sharded_objects() || oid.shard_id =3D=3D ghobject_=
t::NO_SHARD);
>   assert(outfd);
>
> would it make sense to
>
> assert(get_allow_sharded_objects() || ( oid.shard_id =3D=3D ghobject_=
t::NO_SHARD) && oid.generation =3D=3D ghobject_t::NO_GEN) )
>
> instead ?
>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
