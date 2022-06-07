Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF193C43334
	for <ceph-devel@archiver.kernel.org>; Tue,  7 Jun 2022 01:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiFGBVP (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 6 Jun 2022 21:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiFGBVJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jun 2022 21:21:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10F8FD53
        for <ceph-devel@vger.kernel.org>; Mon,  6 Jun 2022 18:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0F72B81B30
        for <ceph-devel@vger.kernel.org>; Tue,  7 Jun 2022 01:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FC1C385A9;
        Tue,  7 Jun 2022 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654564864;
        bh=Bc3j247T+ClNKAOjMMKwEg/l/f2GWkfLhiH8yvU3XYI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B+22XTiqs1D4J4LJa9geyxWhkge7GOh4dWnWe8DnLtiIv7cQfoC/m+VsnPCFQyC8x
         Zkk1sjjJfrNbYcP8NYj0NmpCNV3V6ATpzGIUo8RPel4h4dtJRVBOkUpzvS34nm/oOz
         vTHi4XAx3SSNNZo5S7VjYJwpyuHU8JG/DC/sYM8g+3QiMx0B15XdPIZPB7vEfyoupz
         ADhAdr/OICas2XLf+aUwzfJ7NLr6/QNKBzBVB77t1/7A9f6xDUuvolv0hN0cjus306
         A7mjH8SQ4fJcgxF1GhVNwnkXs0y7ilOPoLaiuDDm5Dna2BK6S/3oQur2EFcMEvGKSt
         +PmE8Q80uCUZg==
Message-ID: <82bb2d6f8c890405a276e3ceffaa6550681f3b38.camel@kernel.org>
Subject: Re: [PATCH] ceph: wait on async create before checking caps for
 syncfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org
Date:   Mon, 06 Jun 2022 21:21:02 -0400
In-Reply-To: <e0dac29b-f6e6-84bd-c548-06106e345554@redhat.com>
References: <20220606233142.150457-1-jlayton@kernel.org>
         <e0dac29b-f6e6-84bd-c548-06106e345554@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Tue, 2022-06-07 at 09:11 +0800, Xiubo Li wrote:
> On 6/7/22 7:31 AM, Jeff Layton wrote:
> > Currently, we'll call ceph_check_caps, but if we're still waiting on th=
e
> > reply, we'll end up spinning around on the same inode in
> > flush_dirty_session_caps. Wait for the async create reply before
> > flushing caps.
> >=20
> > Fixes: fbed7045f552 (ceph: wait for async create reply before sending a=
ny cap messages)
> > URL: https://tracker.ceph.com/issues/55823
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ceph/caps.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > I don't know if this will fix the tx queue stalls completely, but I
> > haven't seen one with this patch in place. I think it makes sense on it=
s
> > own, either way.
> >=20
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index 0a48bf829671..5ecfff4b37c9 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -4389,6 +4389,7 @@ static void flush_dirty_session_caps(struct ceph_=
mds_session *s)
> >   		ihold(inode);
> >   		dout("flush_dirty_caps %llx.%llx\n", ceph_vinop(inode));
> >   		spin_unlock(&mdsc->cap_dirty_lock);
> > +		ceph_wait_on_async_create(inode);
> >   		ceph_check_caps(ci, CHECK_CAPS_FLUSH, NULL);
> >   		iput(inode);
> >   		spin_lock(&mdsc->cap_dirty_lock);
>=20
> This looks good.
>=20
> Possibly we can add one dedicated list to store the async creating=20
> inodes instead of getting stuck all the others ?
>=20

I'd be open to that. I think we ought to take this patch first to fix
the immediate bug though, before we add extra complexity.
--=20
Jeff Layton <jlayton@kernel.org>
