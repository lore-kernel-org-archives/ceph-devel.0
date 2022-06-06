Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B7C433EF
	for <ceph-devel@archiver.kernel.org>; Mon,  6 Jun 2022 10:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiFFKgh (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiFFKgg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jun 2022 06:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574E62FE56
        for <ceph-devel@vger.kernel.org>; Mon,  6 Jun 2022 03:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E085C60E9E
        for <ceph-devel@vger.kernel.org>; Mon,  6 Jun 2022 10:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8798C3411D;
        Mon,  6 Jun 2022 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654511793;
        bh=3Swhf4lEY6Fwmh9KqcXgjvLDeJP1tn7ZKQ0GBhWBPvA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Kj6x1W3z8zxAzDMfhB9hzbdFLLKitMnOPXq1ZlRo/mG1Js9+qoViZ+XuN7snOvcJw
         iLStGRKuIX+S7jyeSogH/xc6mHWTtwRhWszrCJi1liQyTB5cDl+zrJog6vSM/zjM07
         qsUUSSOQVPx+3BwarFZkzsFnsgXiYBRDRd3NkPfnMFWvjM5YvEBBNH6YpyeJfgTfhm
         CZqNQs99vY4uwrAEN2XhwIAS0Cjs9XGMK7CUGLQ0Br7LOa2eniQ67KcgZaCA+CLPu+
         uk3GwUvVdVGGmoeOFooMTL1qe65vgWKqvvKoOLznPtfBdqBCTDgnkGi99ofARWfvpj
         KvZDbZNfzL4pA==
Message-ID: <9a484d2b73dc18b37da2ad2b770d15681057cb18.camel@kernel.org>
Subject: Re: [PATCH] ceph: don't leak snap_rwsem in handle_cap_grant
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org
Date:   Mon, 06 Jun 2022 06:36:31 -0400
In-Reply-To: <87fski2j89.fsf@brahms.olymp>
References: <20220603203957.55337-1-jlayton@kernel.org>
         <87fski2j89.fsf@brahms.olymp>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, 2022-06-06 at 11:12 +0100, Lu=EDs Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > When handle_cap_grant is called on an IMPORT op, then the snap_rwsem is
> > held and the function is expected to release it before returning. It
> > currently fails to do that in all cases which could lead to a deadlock.
> >=20
> > URL: https://tracker.ceph.com/issues/55857
>=20
> This looks good.  Maybe it could have here a 'Fixes: e8a4d26771547'.
> Otherwise:
>=20
> Reviewed-by: Lu=EDs Henriques <lhenriques@suse.de>
>=20
> Cheers,

Thanks,

Actually, I think this got broken in 6f05b30ea063a2 (ceph: reset
i_requested_max_size if file write is not wanted).

The problem is the && part of the condition. We need to release the
rwsem regardless of whether ci->i_auth_cap =3D=3D cap.
--=20
Jeff Layton <jlayton@kernel.org>
