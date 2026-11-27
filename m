Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795776732;
	b=LICTPRCzvBHVtkv04TRKbws3qytEgq7hffIvCvbe1DC7GfBFdLoWnXhjU6VA1xfkICI6
	 H9g7cXbJnOYge5C07/Ls7HnXC/ZolzeXWvpHpPxrMk373ht0l45DcGjLXO3dFZZAu7R8C
	 gP3v4qre2HsgiCvZo8tbhDb05n6Wek0JCdcdmmkqctA7GQDT7zgnJHOp4Qva9ohF559SH
	 O4I8dCFk73D5VDdFdaUB0xleRVM8eYhJvffdtFzZoSpEpu101gFFMwraC+1NKaT+3kQZJ
	 4Doum2x+qzfj1kvouxjqlWBT75AbrMDNWr85f/SzigN0PiFT4iKFtSELbpIUdWoMicQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kIuj8YOwz9TzNr2XbCgli685swxjI1FrbpdlDyQONKE=;
	b=N2SXfSoDJcCWJ8Avn4OGlLCzeSpjqtge0EJULq0ykjpocUilstd4J3DMwuOkCM7OLt0W
	 mW9NJJkc7Lj3szOQfTMvC7VCJzgiyPLJALtwK0bZ5B+ct0BQglt3KepTGBUPfHTN/ueo1
	 UGBeZ0rQZHw53XS+xSzvozmB8MZRwmjvG32X/ob8pmEE9MPIiGWhHh37oJYgrSKGA86by
	 nI82T4RLY/mIr8A6m7T7lzlNEyBUxuoWiy/xmn24ZBpEmEesN9tr8v9M3ZP49P8vjsTIU
	 jAQAhIkZ49qyZai53/BhdSsJ4/aLTx/zkMg8XbRJGG+jUGPNCEFZILr8wHiIbAycuXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=Pqa3RdVh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF2606A323
	for <ceph-devel@vger.kernel.org>; Fri, 27 Nov 2026 10:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DF2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=Pqa3RdVh
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c5133831027so1106143766b.2
        for <ceph-devel@vger.kernel.org>; Fri, 27 Nov 2026 02:52:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795776730; cv=none;
        d=google.com; s=arc-20260327;
        b=BjuXSyqa6M7F0bacbHQ7+UDvF32E+gCFGv8UvWSM0oWNVPWqPHiArbslGMUSWkwMeb
         fttnvxjd8jeS/1tsvaP1l7i80KzEPDb/mauz+66YrDn6XucmkA/YfmZuqHGAvqvv4BCF
         CKVHQIfRqYRLF8kqKnpONquYBNPBM/dNYbEE15W4JjadMr65nU3i65RSkYMxUTb3+zBh
         WgHzufwro1x3TtEGb6dw6oThmixMTMv2B3xHpOlSTltDiFe4k45uvS3+eCqGYA6Tj2fZ
         PY/14KY27XjIQlfzLSxla/XdNbn7HX6gDHJrTd3v8mgVEN9/eI7AElFZ1xY6cEU3PZzW
         aYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kIuj8YOwz9TzNr2XbCgli685swxjI1FrbpdlDyQONKE=;
        fh=PoW5V+tWitBEIMl0OIbEstdOSvSlAGMAJl0CvlD/kAI=;
        b=o3UgCpSAUyINdvHKQ8T27pa5iwOlHO1+x08CYfsjpW4f+vW3sYotkUOSKIRAmNBnH9
         jnFIPvj5iP6tGt7/Ayrd1jlXxg9aje9i0GH/s/q0q+C6BTPmg3MPI8A9zciq0yEnQ/l4
         3itCHLnHWNEwogdw4q7HAjdtZGogq234zYytdLAKeo7V8S72UeM8unekog/iafxiKSS2
         HJpnO1nFXsfw6OU71hEnUjeA4xdg3WkCd0x94iIKWQU17dI4aguMSclJZqpt+Pb3scNb
         MILyZZ/f+4bxQMQgI2TqYN26uDvrHad4T6gZdtJGvWBbJEkQAxDmpfw7g+G2L2/0jNhA
         1tLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1795776730; x=1796381530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kIuj8YOwz9TzNr2XbCgli685swxjI1FrbpdlDyQONKE=;
        b=Pqa3RdVhxUjVVO7AaiQfqAZw2T1MAjkOphcrzYV2rT3DHbFHGWhZyomw/IoLLQ0Gbx
         3Kg7B1KSBv0iLH3ejVUEXFujtNA2494yFIU1n9gsbF61Ub0BAt+MXpIwZtxVG67Bg454
         Xv6R0apQ/o9YJ4GBoL5Os6+CWbV5wq4KlomhHvOFH53NgAnN3/U+vql7aGm0cmZVTYp8
         /DZ1G1pHD9afICGP++QphdOBh3C2bx7LqvlyvORJAKZ620jkDAo1xI54JwE6dC1LIeF1
         zq73G9FioOsUWMKFN8OO/i92Nw18jwZDbQLJQWq++SrSOAvr9lmMJEnF+bGs3OduIitG
         lUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776730; x=1796381530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIuj8YOwz9TzNr2XbCgli685swxjI1FrbpdlDyQONKE=;
        b=uXPNmHZcuPTmRPo8p3tGgmcJoKZJN9i+/QyfOcUGabktQwZhdh2bkAOajPZxTA1czo
         5iLW3vEMsZM8SL70ytp3RMj6q0Cy/ew620ziioYQOuEOZRff8723OqVFr/3GixX5U8Bb
         Je4O6SnKyVsfKQVR/pjub4FHojqCzPXgacF2nhqTRBs5BgiO0MxL0WguipnY6adTsSTI
         XwITGJlCUXGLCfvtNNWvpJeDjfeFjPeB37GLVNcjJPj8fY4hgSNC6E00Vd9kMlcA+UqQ
         pcnx1ko3nLP7mLmI1FRZLf8oG8PaqcLaLRlt3DahV2w4+O0wKDou+bOjj0/8XwUR1mEC
         e/hw==
X-Gm-Message-State: APuU4Z9O/sQdXhWLvUMaZxMIW4NzyoFagwZO3SYLHpOEplbqZ4cSaBQE
	g9KV3eIcH2AenrapA7GJDVwGi1MslesQw/W5GmyzOSgHa6wH7zVpIqUB0o2Ict0NDCWAH1e8qlO
	SSx4uIN4Z+8v7HmuaZx0lG/eKLc7a5Sed+S0cHka5LA==
X-Gm-Gg: AZFdTZeBig9WZtKtomjknHyH/R0FuWXput+CX+OM8SAyxqWH4ZTb73+t4JcGb3hFeD1
	Y4Dj0QsjONO2ffaLYq/FFE94WWMcXFiOrTcUD4Rw3DeLyJH8NWWu1CjTr+IoP8gU12GXyKQi2xF
	XDExF55CW/JeaXD8WDGNBxwVp9AoJp8bAOo9/lUVSvLs6at+u16lvdvF5BCYO3FAqNP1gjqB7JL
	bWiy6qvsmOOwpXzGaHarl2yYexKicXoPE/lIhAtfiIlaAE162qRLJDKRXsRrorjvPsEtyDH668o
	vwl3bhgVZvdL46ryhifYjkuq0O5BSZ/mZfrlH1Hs4+X8pqT+JFhgB29Wa0+/wJs7PjUgUeKrKHD
	iAvOxIFHT2cGfSfJE1nXticK8hA6w4+h2D6oci3NrHtcOWA==
X-Received: by 2002:a17:906:9e14:b0:c29:f5d5:5a97 with SMTP id
 a640c23a62f3a-c513a88015emr1447272866b.33.1795776729837; Fri, 27 Nov 2026
 02:52:09 -0800 (PST)
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
 <CAOJNxRJYBSnPc9Z-baNouF2v-6iADn0Q+CdpjYF7gGfLM4_Trg@mail.gmail.com> <GVUPR02MB11854B3BECB9F04A73142BCF0A5412@GVUPR02MB11854.eurprd02.prod.outlook.com>
In-Reply-To: <GVUPR02MB11854B3BECB9F04A73142BCF0A5412@GVUPR02MB11854.eurprd02.prod.outlook.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 27 Nov 2026 12:51:57 +0200
X-Gm-Features: Aa3M54p0WZp31ybO22xD5gZXvoHT6oVvIwVOc642ccxoCyjyVEBR0VBOkPMYId0
Message-ID: <CAOJNxRKL3nO_LgziffV5vpNhFmMNY5b-gM8u0Arf0kMq-c1f7A@mail.gmail.com>
Subject: Re: [BUG] libceph: OSD request never re-targeted after PG merge,
 CephFS read hangs forever
To: =?UTF-8?Q?Niclas_M=C3=BCller?= <n.mueller@mueller-it.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"amarkuze@redhat.com" <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niclas

No worries and thanks for your update.

BRs
Xiubo

On Fri, 27 Nov 2026 at 11:01, Niclas M=C3=BCller <n.mueller@mueller-it.de> =
wrote:
>
> Hi Xiubo,
>
> thanks a lot for reproducing this so quickly and for the fix. Your
> explanation of how the force resend gets lost matches what we saw:
> the idle mounts were still at e3222 and had to catch up to e4061 in
> one go.
>
> Unfortunately we cannot test the patch. This is our only Ceph
> cluster and it is in production, so there is no environment where
> we could run a patched kernel. All affected mounts were remounted on
> 25 Nov, so the hanging state is gone as well. I should also mention
> that we found and analysed this with the help of an AI assistant
> (Claude). Building and validating kernel patches ourselves is beyond
> what we can do reliably. We will pick up the fix once it reaches a
> regular Proxmox VE kernel.
>
> One small remark on the commit message: it says that
> ceph_is_new_interval() compares pg_num. As far as I can see it only
> checks for a split via ceph_pg_is_split(), which is also why the
> patch adds the merge checks there. That wording came from my report.
>
> Thanks again,
> Niclas
>
> M=C3=BCller IT GmbH & Co. KG
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Xiubo Li <xiubo.li@clyso.com>
> Gesendet: Freitag, 27. November 2026 10:17
> An: Niclas M=C3=BCller <n.mueller@mueller-it.de>
> Cc: ceph-devel@vger.kernel.org; idryomov@gmail.com; amarkuze@redhat.com
> Betreff: Re: [BUG] libceph: OSD request never re-targeted after PG merge,=
 CephFS read hangs forever
>
> Hi Niclas,
>
> Thanks for the detailed report, your analysis is right.
>
> I could reproduce it on a vstart cluster: mount CephFS, write some files,=
 leave the mount idle while the data pool goes from 128 to 32 PGs, then rea=
d.  A few reads hang with a non-existent spgid in osdc, exactly as in your =
dump.
>
> The force resend that normally covers a merge only fires on one exact map=
 epoch, and it gets lost either when the client jumps to a full map (your i=
dle case) or when one MOSDMap message carries many incrementals.
> calc_target() itself has no merge check, unlike the userspace Objecter.
>
> I have posted a fix that makes calc_target() treat a merge source or targ=
et like a split, as the Objecter does:
>
> https://lore.kernel.org/ceph-devel/20261127-libceph-pg-merge-retarget-v1-=
1-2427758cdd1c@clyso.com/
>
> With it all reads complete in both cases.  Testing on your side would be =
very welcome.
>
> Thanks,
> Xiubo
>
> On Wed, 25 Nov 2026 at 12:09, Niclas M=C3=BCller <n.mueller@mueller-it.de=
> wrote:
> >
> > Hi,
> >
> > we hit a permanent hang of kernel CephFS reads that, as far as we can
> > tell, is caused by libceph not re-targeting in-flight OSD requests
> > after a PG merge (pg_num decrease). The cluster itself stayed
> > HEALTH_OK the whole time. The issue was only visible in debugfs.
> >
> > Environment
> > -----------
> > - Proxmox VE 9.2.24, kernel 7.0.14-26-pve (kernel CephFS mount)
> > - Ceph 20.2.4 (tentacle), 3 nodes, 27 OSDs
> > - The same code paths are unchanged in current mainline
> >   (net/ceph/osd_client.c, net/ceph/osdmap.c).
> >
> > What happened
> > -------------
> > 1. A CephFS was created (data pool created with pg_num 128,
> >    pg_autoscale_mode on). All three nodes mounted it right away
> >    (osdmap e3222).
> > 2. Nine minutes later the autoscaler had merged the data pool down
> >    to 32 PGs (pool lfor 0/3669/3667, last_change 3669).
> > 3. The mounts then stayed idle for 18 days. The kernel client only
> >    requests osdmaps "onetime" (maybe_request_map()), so an idle
> >    client keeps the old map. One node still shows this today:
> >
> >      /sys/kernel/debug/ceph/<fsid>.client<id>/osdmap:
> >        epoch 3222 barrier 3222 flags 0x588000
> >        pool 5 '<fs>_data' ... pg_num 128 ...
> >      while the cluster is at e4061 with pg_num 32.
> >
> > 4. The first read after that (QEMU reading an ISO file on the
> >    CephFS) was mapped with the stale map to a PG that no longer
> >    exists. After the client received the current map, the request
> >    was never re-targeted:
> >
> >      osdc:
> >      REQUESTS 1 homeless 0
> >      4  osd4  5.aea7fea1  5.21  [4,14,23]/4  [4,14,23]/4  e4061
> >         100000001fc.00000803  0x40001c  13  read
> >
> >      # ceph pg map 5.21
> >      Error ENOENT: pgid '5.21' does not exist
> >      # ceph pg map 5.1
> >      osdmap e4061 pg 5.1 (5.1) -> up [4,14,23] acting [4,14,23]
> >
> >    The client's own map (debugfs) shows pg_num 32 for the pool, but
> >    the request still carries spgid 5.21. It has been resent 13 times
> >    to the same OSD. osd.4 reports no ops in flight
> >    (dump_ops_in_flight num_ops 0) and nothing for this object in
> >    historic ops. Reading the same object with librados (rados get)
> >    returns immediately.
> >
> >    A second node shows the same pattern: 22 requests stuck for
> >    object 10000000004.000000b6, spgid 5.23 (does not exist),
> >    [15,19,23]/15, which is also the acting set of the merge target
> >    5.3.
> >
> >    The QEMU io_uring workers were in D state in
> >    folio_wait_bit_common until the VM was killed.
> >
> > Analysis (current mainline)
> > ---------------------------
> > - scan_requests() calls calc_target(osdc, &req->r_t, false) for
> >   regular requests. With any_change =3D=3D false:
> >   - ceph_is_new_interval() is skipped. It is the only check that
> >     would notice the pg_num change.
> >   - ceph_osds_changed(..., false) only checks for a primary change.
> > - ceph_pg_is_split() returns false when new_pg_num <=3D old_pg_num.
> > - force_resend only fires when the current map epoch equals
> >   pi->last_force_request_resend.
> > - Neither osd_client.c nor osdmap.c contains any merge handling.
> >
> > So if the merge target PG has the same primary as the merged-away
> > source PG (which is what we observe in both cases), t->spgid is never
> > recomputed. The request is resent forever with an spgid the OSDs no
> > longer have, and the OSD drops it, expecting the client to re-target.
> > Userspace Objecter handles this via is_new_interval() (pg_num change),
> > which is why librbd/librados clients on the same hosts were
> > unaffected.
> >
> > A possible fix would be to also recompute the target when
> > pi->pg_num < t->pg_num (merge), analogous to the split check, or to
> > evaluate ceph_is_new_interval() for regular requests as well.
> >
> > Reproduction (not tested by us, derived from the above)
> > -------------------------------------------------------
> > 1. Create a pool with pg_num 128 as CephFS data pool, mount it with
> >    the kernel client and write a few large files.
> > 2. Leave the mount completely idle and reduce pg_num to 32. Wait
> >    until the merge is complete.
> > 3. Read the files from the idle mount. Reads of objects in
> >    merged-away PGs should hang, with entries in osdc as above.
> > krbd mappings that stay idle during a merge are presumably affected in
> > the same way.
> >
> > Workaround
> > ----------
> > umount -f + remount of the CephFS (fresh client with the current map),
> > and pg_num_min on pools used by kernel clients to prevent autoscaler
> > merges.
> >
> > Happy to provide more data from the affected nodes while they are
> > still in this state.
> >
> > Thanks,
> >
> > Mit freundlichen Gr=C3=BC=C3=9Fen
> > Niclas M=C3=BCller
