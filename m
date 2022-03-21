Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC72EC433EF
	for <ceph-devel@archiver.kernel.org>; Mon, 21 Mar 2022 10:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbiCUKDe (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 21 Mar 2022 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346119AbiCUKD3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2022 06:03:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B833147AF9
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2022 03:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30D0CB810C2
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2022 10:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9654BC340E8;
        Mon, 21 Mar 2022 10:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647856922;
        bh=69JLBMpZHmEUeYnm99tKkjooWcFKUa7kjf4VpoReqHo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HIEJHDTxHx7D5jR40r1jEr2Jnrox5iIenBMkdKihk+6m9XRkJr7iRyubSlGHW9y18
         ecypNjbFuic86c6ZyDiBMzpbm5UwrKshd9jpR1wrDY2pjOjp7rfSr9vMbaTDr5x3oX
         TKELL34Qpx1lzeOkQWbuHDpOTST3YPfld3oUA+M9NUsCcrPSZ65VqlfSTZK5vC/wkH
         PHN2DL54bF3UH2H1NdhFqLlaGUOSiQ6Apq7lxT+ff209WprqV8MAp+PfEX2pRzMx4e
         nRCYmKdwnfU5ta8W5o+V+OUCMC53LisUO4RlrOUoWfAKM9zhP1I/1ycEv8RdpMTFHp
         OdYM4B0cW3RnA==
Message-ID: <b50f3fb513fc4c38d0255179ae53b02a66778301.camel@kernel.org>
Subject: Re: [PATCH v3 2/5] libceph: define struct ceph_sparse_extent and
 add some helpers
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org
Date:   Mon, 21 Mar 2022 06:02:00 -0400
In-Reply-To: <6895739a-8d02-3d04-f5ac-e0c50cea5f06@redhat.com>
References: <20220318135013.43934-1-jlayton@kernel.org>
         <20220318135013.43934-3-jlayton@kernel.org>
         <6895739a-8d02-3d04-f5ac-e0c50cea5f06@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, 2022-03-21 at 15:57 +0800, Xiubo Li wrote:
> On 3/18/22 9:50 PM, Jeff Layton wrote:
> > When the OSD sends back a sparse read reply, it contains an array of
> > these structures. Define the structure and add a couple of helpers for
> > dealing with them.
> > 
> > Also add a place in struct ceph_osd_req_op to store the extent buffer,
> > and code to free it if it's populated when the req is torn down.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   include/linux/ceph/osd_client.h | 31 ++++++++++++++++++++++++++++++-
> >   net/ceph/osd_client.c           | 13 +++++++++++++
> >   2 files changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> > index 3122c1a3205f..00a5b53a6763 100644
> > --- a/include/linux/ceph/osd_client.h
> > +++ b/include/linux/ceph/osd_client.h
> > @@ -29,6 +29,17 @@ typedef void (*ceph_osdc_callback_t)(struct ceph_osd_request *);
> >   
> >   #define CEPH_HOMELESS_OSD	-1
> >   
> > +/*
> > + * A single extent in a SPARSE_READ reply.
> > + *
> > + * Note that these come from the OSD as little-endian values. On BE arches,
> > + * we convert them in-place after receipt.
> > + */
> > +struct ceph_sparse_extent {
> > +	u64	off;
> > +	u64	len;
> > +} __attribute__((packed));
> > +
> >   /*
> >    * A given osd we're communicating with.
> >    *
> > @@ -104,6 +115,8 @@ struct ceph_osd_req_op {
> >   			u64 offset, length;
> >   			u64 truncate_size;
> >   			u32 truncate_seq;
> > +			int sparse_ext_len;
> 
> To be more readable, how about
> 
> s/sparse_ext_len/sparse_ext_cnt/ ?
> 
> -- Xiubo
> 

Sure, I'll make that change.
-- 
Jeff Layton <jlayton@kernel.org>
