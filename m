Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D540F8E0
	for <ceph-devel@vger.kernel.org>; Fri,  1 May 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659802; cv=none; b=Y/+sgaMZLtReW+bonmKOdS2mgKcDJu9IGAcbGl7v542M5KhhCDc7U0LUFZQ2CYQMVHgYiOIRbwhfLmajVO+lELzp4QvknOYyaebgTb8gH5DDcEETbHdEAdXN/WD1mbCbeSkjydFV6cnWonk5w5dR2xayhV0NixDctEUJmzgrKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659802; c=relaxed/simple;
	bh=yHhfi7MCaydzIsFpX5sjg4qeKk0xolze7enorVrylL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0ehKmuGea6aetmxBOLdlARqpSYZmsaelxU8LpL475W8NrswkxE+Je6vYw/LTr548BWMzvEJjEPqD1DfxCAxJnfsek+DvsiDA4iYBMpGnLz8lO53TJL1U5HkezJL5UAJB79yHcgK6XyjtsTNEpoBnkpL5YpCqg6hCmIB9Wi5FgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=i923vCPZ; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="i923vCPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1777659797; bh=LrkzG8/TGfKCERcjJxQ2MdL26X+f80kYN1qepiub4f8=;
	h=From:Message-ID:From;
	b=i923vCPZwVfpx8MHxftjWEyz5rKX6263DREDa+w8fAtaeSGOZjCkrV1nN21UkTmlC
	 wYvXMgV+J+ux5IooWQ05fNSj7/UBk8RUQdNL2jwOscOh/RGmZWrix9X91muZf3KIO9
	 rUGT7Rc3cTilytUowRJRkeQIXfyNWGcG8qC28qD8=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id A500EC0A2A;
	Fri, 01 May 2026 20:23:17 +0200 (CEST)
Date: Fri, 1 May 2026 20:23:17 +0200
From: Willy Tarreau <w@1wt.eu>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Dhiraj Mishra <mishra.dhiraj95@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, idryomov@gmail.com,
        amarkuze@redhat.com, security@kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [SECURITY] ceph: msgr2 monitor data_len mismatch can trigger
 client kernel panic
Message-ID: <afTvlWJ_P1PSyqAB@1wt.eu>
References: <CAG8b5tT0cqjS3D-q6Z=ufv73W69ZXfRA0FTm85uf9OEL34=-GQ@mail.gmail.com>
 <2026050111-comprised-unreal-7b2a@gregkh>
 <CAG8b5tSZX4OtkwLDgBCtWJPhWSoQgh9rHDzxW3bja9GkrciG0A@mail.gmail.com>
 <afRoFf4QVANv3i-T@1wt.eu>
 <2a70150e66ab67106ec9196eb7cd2ccbebe771a7.camel@dubeyko.com>
 <CAG8b5tTm6XMXOW3gycj13PU4=jRvsvYtNKYzMzg7mQO2h+E85g@mail.gmail.com>
 <c247520dd5bfe49e22b29d221967d0fd569c2e6a.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c247520dd5bfe49e22b29d221967d0fd569c2e6a.camel@dubeyko.com>

On Fri, May 01, 2026 at 11:11:44AM -0700, Viacheslav Dubeyko wrote:
> On Fri, 2026-05-01 at 21:53 +0400, Dhiraj Mishra wrote:
> > Sure noted, here is the patch.
> > 
> > From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00
> > 2001
> > From: Dhiraj Mishra
> > Date: Fri, 1 May 2026 12:45:00 +0400
> > Subject: [PATCH] libceph: reject monitor replies with oversized data
> > segment
> > 
> > Monitor messages can be allocated from preallocated reply messages or
> > with ceph_msg_new(), both of which may provide only front-buffer
> > storage
> > and no data items.  The messenger receive path copies the wire header
> > into the selected ceph_msg and later uses hdr.data_len to decide
> > whether
> > to initialize a data cursor.
> > 
> > If a malicious or compromised monitor advertises a non-zero data
> > segment
> > for one of these front-only replies, the receive path can call
> > ceph_msg_data_cursor_init() with length greater than msg->data_length
> > and
> > hit its BUG_ON() checks, crashing the client kernel.
> > 
> > I verified the issue against v7.1-rc1-123-ge75a43c7cec4.  The msgr2
> > trigger path is present since commit cd1a677cad99 ("libceph, ceph:
> > implement msgr2.1 protocol (crc and secure modes)"), which is
> > contained
> > in v5.11-rc1 and later.  The monitor allocator pattern is older, but
> > I
> > have not tested older msgr1-only kernels.
> > 
> > A concrete trigger is a monitor connection over msgr2 after
> > CEPH_CON_S_OPEN
> > where a FRAME_TAG_MESSAGE contains a monitor reply type handled by
> > mon_alloc_msg(), a valid front_len for that message type and data_len
> > = 1.
> > CEPH_MSG_MON_MAP is one such example: the message is allocated with
> > ceph_msg_new(), leaving msg->data_length and msg->num_data_items as
> > zero.
> > 
> > Reject monitor replies whose wire data segment is larger than the
> > data
> > backing allocated for the selected ceph_msg, mirroring the existing
> > OSD
> > reply hardening.
> > 
> > Signed-off-by: Dhiraj Mishra
> > ---
> >  net/ceph/mon_client.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > index d2cdc8ee3155..7f2293122bba 100644
> > --- a/net/ceph/mon_client.c
> > +++ b/net/ceph/mon_client.c
> > @@ -712,6 +712,7 @@ static struct ceph_msg *get_generic_reply(struct
> > ceph_connection *con,
> >   struct ceph_mon_client *monc = con->private;
> >   struct ceph_mon_generic_request *req;
> >   u64 tid = le64_to_cpu(hdr->tid);
> > + u32 data_len = le32_to_cpu(hdr->data_len);
> >   struct ceph_msg *m;
> >  
> >   mutex_lock(&monc->mutex);
> > @@ -720,6 +721,16 @@ static struct ceph_msg *get_generic_reply(struct
> > ceph_connection *con,
> >   dout("get_generic_reply %lld dne\n", tid);
> >   *skip = 1;
> >   m = NULL;
> > + } else if (!req->reply) {
> > + pr_warn("%s tid %llu missing reply buffer, skipping\n",
> > + __func__, tid);
> > + *skip = 1;
> > + m = NULL;
> > + } else if (data_len > req->reply->data_length) {
> > + pr_warn("%s tid %llu data %u > preallocated %zu, skipping\n",
> > + __func__, tid, data_len, req->reply->data_length);
> > + *skip = 1;
> > + m = NULL;
> >   } else {
> >   dout("get_generic_reply %lld got %p\n", tid, req->reply);
> >   *skip = 0;
> > @@ -1499,6 +1510,7 @@ static struct ceph_msg *mon_alloc_msg(struct
> > ceph_connection *con,
> >   struct ceph_mon_client *monc = con->private;
> >   int type = le16_to_cpu(hdr->type);
> >   int front_len = le32_to_cpu(hdr->front_len);
> > + u32 data_len = le32_to_cpu(hdr->data_len);
> >   struct ceph_msg *m = NULL;
> >  
> >   *skip = 0;
> > @@ -1544,6 +1556,15 @@ static struct ceph_msg *mon_alloc_msg(struct
> > ceph_connection *con,
> >   ceph_msg_put(m);
> >   m = ceph_msg_new(type, front_len, GFP_NOFS, false);
> >   }
> > + if (m && data_len > m->data_length) {
> > + pr_warn("%s data %u > prealloc %zu (%u#%llu), skipping\n",
> > + __func__, data_len, m->data_length,
> > + (unsigned int)con->peer_name.type,
> > + le64_to_cpu(con->peer_name.num));
> > + ceph_msg_put(m);
> > + m = NULL;
> > + *skip = 1;
> > + }
> >  
> >   return m;
> >  }
> 
> 
> I assume that the email has been sent not in plain text and
> ceph-devel@vger.kernel.org simply rejected the email. Could you please
> follow to the common practice of sending patches [1]?
> 
> Thanks,
> Slava.
> 
> [1] https://docs.kernel.org/process/submitting-patches.html

This one should help to fix your mail client's configuration:

   Documentation/process/email-clients.rst

Willy
