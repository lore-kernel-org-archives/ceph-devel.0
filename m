Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795771034;
	b=eib8OBeflWRT1SmTJjJzR9xCzmS8SPtmqZIqTAwhejVUUMIex/4OgGR0LMOqNo5UGlC5
	 91WQjGNJMBh2xHXI7HT2NhzHPrZt9e5dsxhQm2zRIKBsMy9pyV21nUcwiTxTFbBnHJlny
	 RE5S/awaXvzgjQPYwDA88sTOUqprns7JgIS4EKTTqspHl61AsLIeqozyZm5rncTPy73G9
	 0hwBvLu/sNe3iwS4M8n6sa8nF56oKRKUqvRj+8D+HYhDa8DQMnzvm6GInGwtnUVEBa3kJ
	 l5o01iC3lqWoNStdzX0sov7PWsURVLAxwNogZ8CWYdceeT8w9U6Prad1bZmt5eVVb8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2Yl/cxqly5tYdNEVcKxaA4OzBpFv6bQpjdT/g7O0W28=;
	b=5PwXHJXGMbXfgDtMhzRsNepDpy7rL6agClYTX+3sqlOfT5bohkq/THXdSylZkI4vMBVt
	 dl09PQ3rXaxupCA1ZXeUeaGGPdTHHvU3WyEopMdIrxyf8VDWpCSYJ1hsJO2kQe+lWIb4G
	 vnCVR1FjOm/i8Fc+EcHTnuNa1I+OyZmAcRuPbzXTOVe4bzp0T89blBrRMnEHOvn4lg78j
	 OVn59MuvYMb23KnzEjr3r24rN29NE16bU4zP4zCFWPNriUuc2qYmXfM88zqS81SPS8ED9
	 M1I5PQRaTs1Ojpq92cZbMThNohyFLOrj7tdRuDThe6fWi2QxDLC8Af3RZlZ3QQmc8VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=JpFKhuBm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ADC606A31C
	for <ceph-devel@vger.kernel.org>; Fri, 27 Nov 2026 09:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3ADC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=JpFKhuBm
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d21051042so363234866b.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 Nov 2026 01:17:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795771032; cv=none;
        d=google.com; s=arc-20260327;
        b=KO6ALLkoDrDvou9f6c4+xYKsP7GZSWZKX0stVNGoEhxHYNScpPpWg6EAXzeMUOf8Q6
         YldRriPMHo7Qd/hJE4iIP9YRYF8OgwKHCSlXa7qXOO5jN7u3FqiJP0z+2VIv4nFhgBN6
         ugnin8IHXLccwzb3IbdtGMadSYpufCul2CS2v9FkUBoj20/Rc0bopun2b/2EwLq/bcru
         UTTF5cbFGFMd8lHv44RuewdlIFNn+yMFas4aBjzRJYkWq4WZgSFky5TC8Ch+iFk1wlZJ
         B1OOvJWgq2/umdwZA++N/npfLY8h+odrmZ/HzKLA5d8s4Xt19xHCJ63eXW3onwMd3FrI
         +30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Yl/cxqly5tYdNEVcKxaA4OzBpFv6bQpjdT/g7O0W28=;
        fh=PoW5V+tWitBEIMl0OIbEstdOSvSlAGMAJl0CvlD/kAI=;
        b=qogatdSaFvtReLcebLdQNMjdvJNuNTIIbmVsEkpOZdlwPxOg/O57Oipb/ikfcTLIjs
         F0NFMHgFw6Q+uW0NaFrn9IQ2qeqUAqKA/XNh1Likr129BrnCrOHAC8/htSOxea+yg23U
         /SPkmH+tLrn1ZalOCX+4jbh4jkn8E7S5QSCbHVZ0ieifs7oJ/hz3fVRi1cpqrribEcwI
         tn99ZHm02ObNraRweapyVVh+9A1/heNcb5Wv1Ot9+jzOeSN1WaTmTz6W6I8oYY2FNjAA
         1+yIah89dsACZEW3Z3a/AM9XE5Ol0Nc60outC70WUi2cqQRJ6Y9RS8k/TMwb/C/8YcE7
         PoYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1795771032; x=1796375832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Yl/cxqly5tYdNEVcKxaA4OzBpFv6bQpjdT/g7O0W28=;
        b=JpFKhuBm1FSFd3m6Cy+y+9r5qSNDSIwOgIERbXhKPVE70bJYPUUe6DDCKmbPX889x8
         NHJFzI115VoxtmogUWk68GoTv9aggkcP6E9o3GGx5p6SXMj9e8WvrdGvgkihngw5IuKI
         ABIxnyO/Z7cqoYER8Y59DzzfpSwHK+rzT1NiC3OzUo/NTlzdfzwr9tCtZPVj8DhyqF7G
         jJS+cXy3kUBbBbFz2l3pYBdXruS0lZD4TOWzzKgWAG+wG48Uq0Qn4mnNrxKBXYFNX8xS
         4p8rLXh20370Yhk/7RUM6RE0BH7xBjphKj+KHzBa2LcbEBX2hDXTo9LjefGbUBNE+Zs3
         YA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795771032; x=1796375832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Yl/cxqly5tYdNEVcKxaA4OzBpFv6bQpjdT/g7O0W28=;
        b=CHBPshBF3tf6/1b+46Fua+bYUltOXhPs/vD75BunROBikNaWxAMXLNnU3+rlpgorhg
         xqWcBahBWWSDPMReYXkNM4wOoWtlmnMb0odIHv3VjOBSJn8xb6q+S837iZ763M36hbAe
         YMOSpnCphgw0NdgpBlFdFy0Y0YqDUWR3Fg/dwdk5j7Iw/CvLDs6Ts35Dn4wStKrYYIik
         yCgXfCHAwFUJwUBldeBdVnh8HeF5Rt4TvpPfCnM/ybBeY8X4AlBsutlfyrpNr//QvAls
         heMzvcRzV7+ePbIrZlDKtE9ZDZs3OgIibms0vwXMYd/z6TMQFvOloOexos0o44nejTCa
         IGlw==
X-Gm-Message-State: APuU4Z/TAJoT/0YR0QRQTJ92EDgpwSFDFsfpyG0eRNg4fVpH3SRtPIoh
	DB44kOi6jpsV8B8GQpcK5vilskh/6kXDRGXuYZ+AKkABsAZtNGT+YRc8nkLIikOIubxlE0Ez9VX
	1C7X2/IMhPFHvkxpqYuKbbmtYt/oOovSwy+WL9qYyUA==
X-Gm-Gg: AZFdTZfB7+Ay3IvEgJUFJd6aelSByiM4rv5lAXexpD+0HLmrQel+2VHsX89MrtI1phc
	gX1rNQPb9rYJOX5kwXjrnkmkSMIA9f9aR4hPQGGuQx+6ykzrbyplbxhL6UJw6vRm3N7RlW+SXT9
	GgwTdyXjz5biaDTQrbQl9o88REGc91OqgF6MFnFrLEfVULAda5SxLOZE0rJ28Nmf4OPUL5x1sgT
	sWMxF32+C/BLdr3941trPe6/1rlSjHuIPj66AalE0dIH3YFZqWXLjY1uGnJWZZ1SFPCR+mM7Rwq
	o0DeOEHMaDhaUg/aEgytkrhZmO83BJQPA54oYZkFKEIQDqUy6V4L2g6hZlZug602mvbbkGN/yge
	vxlLQVEZi5AmlG7pVG4AncwT06EqE3ogdr0bHX4tzDXJvbg==
X-Received: by 2002:a17:907:2d13:b0:c50:ca93:19a0 with SMTP id
 a640c23a62f3a-c513aab9bcemr2046418966b.40.1795771031942; Fri, 27 Nov 2026
 01:17:11 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <AM6PR02MB522441DD8CECFA6C3BF2A2F8A5432@AM6PR02MB5224.eurprd02.prod.outlook.com>
 <AM6PR02MB522498A5600199DDE2296680A5432@AM6PR02MB5224.eurprd02.prod.outlook.com>
In-Reply-To: <AM6PR02MB522498A5600199DDE2296680A5432@AM6PR02MB5224.eurprd02.prod.outlook.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 27 Nov 2026 11:16:59 +0200
X-Gm-Features: Aa3M54qFU8DqolLi-DelE0NvXShCWak1b76RyQdIPZFdhluXgaVHC4wtqvKkuro
Message-ID: <CAOJNxRJYBSnPc9Z-baNouF2v-6iADn0Q+CdpjYF7gGfLM4_Trg@mail.gmail.com>
Subject: Re: [BUG] libceph: OSD request never re-targeted after PG merge,
 CephFS read hangs forever
To: =?UTF-8?Q?Niclas_M=C3=BCller?= <n.mueller@mueller-it.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"amarkuze@redhat.com" <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niclas,

Thanks for the detailed report, your analysis is right.

I could reproduce it on a vstart cluster: mount CephFS, write some
files, leave the mount idle while the data pool goes from 128 to 32
PGs, then read.  A few reads hang with a non-existent spgid in osdc,
exactly as in your dump.

The force resend that normally covers a merge only fires on one exact
map epoch, and it gets lost either when the client jumps to a full map
(your idle case) or when one MOSDMap message carries many incrementals.
calc_target() itself has no merge check, unlike the userspace Objecter.

I have posted a fix that makes calc_target() treat a merge source or
target like a split, as the Objecter does:

https://lore.kernel.org/ceph-devel/20261127-libceph-pg-merge-retarget-v1-1-=
2427758cdd1c@clyso.com/

With it all reads complete in both cases.  Testing on your side would
be very welcome.

Thanks,
Xiubo

On Wed, 25 Nov 2026 at 12:09, Niclas M=C3=BCller <n.mueller@mueller-it.de> =
wrote:
>
> Hi,
>
> we hit a permanent hang of kernel CephFS reads that, as far as we can
> tell, is caused by libceph not re-targeting in-flight OSD requests
> after a PG merge (pg_num decrease). The cluster itself stayed
> HEALTH_OK the whole time. The issue was only visible in debugfs.
>
> Environment
> -----------
> - Proxmox VE 9.2.24, kernel 7.0.14-26-pve (kernel CephFS mount)
> - Ceph 20.2.4 (tentacle), 3 nodes, 27 OSDs
> - The same code paths are unchanged in current mainline
>   (net/ceph/osd_client.c, net/ceph/osdmap.c).
>
> What happened
> -------------
> 1. A CephFS was created (data pool created with pg_num 128,
>    pg_autoscale_mode on). All three nodes mounted it right away
>    (osdmap e3222).
> 2. Nine minutes later the autoscaler had merged the data pool down
>    to 32 PGs (pool lfor 0/3669/3667, last_change 3669).
> 3. The mounts then stayed idle for 18 days. The kernel client only
>    requests osdmaps "onetime" (maybe_request_map()), so an idle
>    client keeps the old map. One node still shows this today:
>
>      /sys/kernel/debug/ceph/<fsid>.client<id>/osdmap:
>        epoch 3222 barrier 3222 flags 0x588000
>        pool 5 '<fs>_data' ... pg_num 128 ...
>      while the cluster is at e4061 with pg_num 32.
>
> 4. The first read after that (QEMU reading an ISO file on the
>    CephFS) was mapped with the stale map to a PG that no longer
>    exists. After the client received the current map, the request
>    was never re-targeted:
>
>      osdc:
>      REQUESTS 1 homeless 0
>      4  osd4  5.aea7fea1  5.21  [4,14,23]/4  [4,14,23]/4  e4061
>         100000001fc.00000803  0x40001c  13  read
>
>      # ceph pg map 5.21
>      Error ENOENT: pgid '5.21' does not exist
>      # ceph pg map 5.1
>      osdmap e4061 pg 5.1 (5.1) -> up [4,14,23] acting [4,14,23]
>
>    The client's own map (debugfs) shows pg_num 32 for the pool, but
>    the request still carries spgid 5.21. It has been resent 13 times
>    to the same OSD. osd.4 reports no ops in flight
>    (dump_ops_in_flight num_ops 0) and nothing for this object in
>    historic ops. Reading the same object with librados (rados get)
>    returns immediately.
>
>    A second node shows the same pattern: 22 requests stuck for
>    object 10000000004.000000b6, spgid 5.23 (does not exist),
>    [15,19,23]/15, which is also the acting set of the merge target
>    5.3.
>
>    The QEMU io_uring workers were in D state in
>    folio_wait_bit_common until the VM was killed.
>
> Analysis (current mainline)
> ---------------------------
> - scan_requests() calls calc_target(osdc, &req->r_t, false) for
>   regular requests. With any_change =3D=3D false:
>   - ceph_is_new_interval() is skipped. It is the only check that
>     would notice the pg_num change.
>   - ceph_osds_changed(..., false) only checks for a primary change.
> - ceph_pg_is_split() returns false when new_pg_num <=3D old_pg_num.
> - force_resend only fires when the current map epoch equals
>   pi->last_force_request_resend.
> - Neither osd_client.c nor osdmap.c contains any merge handling.
>
> So if the merge target PG has the same primary as the merged-away
> source PG (which is what we observe in both cases), t->spgid is never
> recomputed. The request is resent forever with an spgid the OSDs no
> longer have, and the OSD drops it, expecting the client to
> re-target. Userspace Objecter handles this via is_new_interval()
> (pg_num change), which is why librbd/librados clients on the same
> hosts were unaffected.
>
> A possible fix would be to also recompute the target when
> pi->pg_num < t->pg_num (merge), analogous to the split check, or to
> evaluate ceph_is_new_interval() for regular requests as well.
>
> Reproduction (not tested by us, derived from the above)
> -------------------------------------------------------
> 1. Create a pool with pg_num 128 as CephFS data pool, mount it with
>    the kernel client and write a few large files.
> 2. Leave the mount completely idle and reduce pg_num to 32. Wait
>    until the merge is complete.
> 3. Read the files from the idle mount. Reads of objects in
>    merged-away PGs should hang, with entries in osdc as above.
> krbd mappings that stay idle during a merge are presumably affected
> in the same way.
>
> Workaround
> ----------
> umount -f + remount of the CephFS (fresh client with the current
> map), and pg_num_min on pools used by kernel clients to prevent
> autoscaler merges.
>
> Happy to provide more data from the affected nodes while they are
> still in this state.
>
> Thanks,
>
> Mit freundlichen Gr=C3=BC=C3=9Fen
> Niclas M=C3=BCller
