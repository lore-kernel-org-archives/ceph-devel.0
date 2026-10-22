Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792669607;
	b=0+FYTCRWQueamnYLE4P2P5lTETk2KpHIIW7OoTsDjwVJ6vSzsf9BVWlmzqvNrQTkNMqS
	 XpLKSS4VVLkQPBxPUGU7W9ES6gXZnKdPw0dFnxj5cNgJawjOkPjKITPdnqsCbNPuSGz3/
	 EEgljFms0gvL3Zx5H/lG8lTxqZC4F4OWTeIpymz8Tt1Dn5j+3jX0nlC7SetOxSMtzbayV
	 tmZY5kPjmTFAG3bAZlFgXss/C5QNrs1dBpR/63+brfB5uuAfRpqdt65vLVWsgPTEcY5zL
	 iT+8X3wnqeohZJ6YoVOJeC82GjF1E4Y63iHuyd6DqFcgZVt189IgQcv46ebXmHAh4dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LLnykIlX3tQxsJhW4ed3Vb1T8Uz/eQc5Sms7ukZf4eY=;
	b=YbvBMvqN2FMlfXRA7e4xv2hNtPG0m5bfWBOer4W6CD1PCwLpR49877pSgqytW2a5FflK
	 nu00n1gMs77k9oSQNCp1vSQiHmUfHBys4ptP+KiixMyzzIV1GJtik0cq4kxwi+O/tPfer
	 EDYuVSwNArN7OgQ4hlnr2MJtp/NBSUciIAiFrq4i6unFHrJbFPnjt3ROJWn1SwM1ujvOx
	 OTB5YKDsKArC/hqFwfdsa+pJJX8lOLPqtyn49WqA50udgruaAQxUm46kbGrYZ2YAGNpTm
	 2Bzbc1sS8oO6yfsNIv5gaUfu8SdemVQsvFGnpOvXJAAlTsY3e2ABD3xVGlO8Fn9gLoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b="iXX8nd/f";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBEB606A319
	for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 11:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EBEB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=iXX8nd/f
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2e8c710847so241943366b.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 04:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792669604; cv=none;
        d=google.com; s=arc-20260327;
        b=NGGH8G6GJMXe+xjno/WpF/5gydi5zv14UvD4E0fwAbwwAPRWFMJ9lhdkm47APCq2Js
         vWE+DMMQKsXxObgg4N2MuJCoIYrgO4pCTBSJC+FaG7LsbOnkLzOCIC/VJz1hlBSnFwWL
         Ff1E8hSUPMP9VBKG0iVkOJ3csNL0g/1RciJeUMIRTqhlUkR13h75A+DcKOZ8Bsfd2Nxx
         KROnFAVdjqo+rMXWw9+xVXO+/rop1B3JEVF7TZEFKEVAWEEP8Doe53sDfjVEWD2rVRQV
         UzWm+4jHK8f3sNuTH8cvLhLHhovDbP1EYI1Esq3NspqhwSmhdtC9YL8kEwXwPfyogmF7
         3avQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LLnykIlX3tQxsJhW4ed3Vb1T8Uz/eQc5Sms7ukZf4eY=;
        fh=c3f9avSLQ+8tif/CeFCBAi6tMYARr5F8KzW86XSrmCo=;
        b=MmSs8c+2zu8n+MPCXm4rKIKvEx9CGMgDo9gB31yq5tJLxepvtXoIWsVtl8eLfcOcT3
         hktgIHkrWof2zyAlHIPZQ0NL8fcXNDT4U5s2F2So8tAaIXHpvQLSWvfpqjf9fpWyab+J
         8h77j1CEQ8BjYNkZ3D7BQeWtz8ODVIIM+0ZgGypzH9k3Oxg1umrKjQyVar+xq5vukGdg
         XcP+3cJH30YW3uUc7DJY6T6JU3Kiud/ITHb8YIGUwrodrDOV+eSSIOAf5+++hl6EN2d/
         ZHE0sA/m9jk9/VSxjXFrqYpUzw8F/hL0dn7mDeMuCOpPPAquVJ3WJPWQ6kCMB0iQEBPQ
         edsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1792669604; x=1793274404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LLnykIlX3tQxsJhW4ed3Vb1T8Uz/eQc5Sms7ukZf4eY=;
        b=iXX8nd/fPI9mJCOO0M1wn87CI79N03DItH38pZV7ON3lW0V5rWS2wQDx5F0WZyZLDf
         fjb9tX05NdOmoYGjfqCj4iKNKYpfIrddTzyiqqhklQEnGXxPSyFkhBbhOP5lq0KsRT/J
         L9d390zfpfvu7d7ZB+dRG30JPDztWlA5suCQpKFKPaKvHy0EBd8aJXqt70Z7h4ZaDhOL
         yxiREEgVUGlZuhzeYuB82HZVvcqBZ61/UuAtRKWQRZdKkF2NVkbUtTBkcP8+Sf1m0CA7
         Vk2rwjQmvR6vhvV34oe5uMktHfNOcuIcdLwm0XBV3Efi2Bh+94afSl4TW4yIDQVnPEHy
         JaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792669604; x=1793274404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLnykIlX3tQxsJhW4ed3Vb1T8Uz/eQc5Sms7ukZf4eY=;
        b=rYwZLB6v/IIE2DJPwx6Xoq3Zt2fHzfMcM5SgqioPp8ERTmWnAKRmusyGcLMFkBaZGV
         nrz7cDSG2Qp6+p7HXmBc8smX490zXgG3zlnwSOQAngEtrgdfQblbiqFfwMCG/THhbYQ5
         3RpWfV/cZYRnDnE5FwaUXSpLz5RTtQLigf1IvXHG5KIbcsnqaod69GhlEeOSUTdWnM46
         7D2ITS0KHB5RmL1Jai8SjnunvokbFCWXqQuHb+vQi81FtGunCmF2nLOZWaWRREfCuCDo
         wQAB8wEwdxhMWphN99HqjM86jrBCSHJr12jpDTCOp1mYpVCH1rCMFAUKfJOGIpDio934
         ZqCQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5nNCECzz1FuQ7dEMUq3BClYRphm1YlyLSnkGvomu2qDc3274saJbM7LBIB5Ao2z8gfB5Oqw/tlG9h@vger.kernel.org
X-Gm-Message-State: AFq9FYLHbZFjELQGWMwfHYxeFp4I3DAbzgctQqEpuMkYt16oraCbQt2+
	kfpU5SEVRKI1GnBDJGNupio9X7g1PoE9rbMxDKi0tuu2EeliMs+ExXOtgZkOqvRH1pzqXp+GVJ8
	d2Cg1KoX2QwgHfqldJORJsB+IzGL2jHAiU5s3sffWGg==
X-Gm-Gg: AYBFou17VcrJh+DfRmfbqMrhrZkf/q4PpTKV2YHKYC38CcUu/EwhAWZJ/DqisY6iF/E
	jzoGN99HsiKCa95nRDjhqmUkL01MUVBWcAge9dlPbXyEaDzf46f1E5iXP/x6zP5PWj/02M1bzHH
	EtCXl8cnuAEJ8PIfNzObiR4/iHINlVeDKSOQXmGCyOXdJG9Uc4kXcu42wIn3kS/bSPRF8sdifnl
	aILZsI7vb/gLAfZbJivr39dX/G6Wx89J3Npa1gSUHVMHONzNMadqLzg0bTUn9mhESaUDA/WUcjq
	di2peHMKRGtjNbEjSEnLodTBofDt0Kw3P4iONUDWShW7PQjM/uJ9CaaH9BZNQyuNJxq1Rldkz9G
	VJ2BcoVL5gL5/gTJGGghImz0YH9DbWUevqSFju3Y=
X-Received: by 2002:a17:907:9446:b0:c2e:61e:f4fd with SMTP id
 a640c23a62f3a-c46791965c0mr507930166b.5.1792669604074; Thu, 22 Oct 2026
 04:46:44 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015064202.62886-2-vshankar@redhat.com> <20261015155808.140236-1-amarkuze@redhat.com>
 <CAOuZWzxd85AzOGGh_DQduVRbGLnDrfyQ0ZJXcWEDJmVEVZPdcg@mail.gmail.com>
 <20261022061630.1832692-1-amarkuze@redhat.com> <CACPzV1mpiUPPg-XN9_P-ZFmx3NYGP6ATK6RBPK6A-ZTXwT3Qgw@mail.gmail.com>
In-Reply-To: <CACPzV1mpiUPPg-XN9_P-ZFmx3NYGP6ATK6RBPK6A-ZTXwT3Qgw@mail.gmail.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 22 Oct 2026 13:46:31 +0200
X-Gm-Features: AclHuK9R08gkd4aXsFW6iF-Yf7LFFmI5S3BLgeoetcLLHo6GKvX4L4IV2lr7ZRg
Message-ID: <CAOJNxRLaDZaku6c6EoW9o_URM1VmrwOu06_kexQVR45T7_04+g@mail.gmail.com>
Subject: Re: [PATCH] ceph: unlock an abandoned file-lock grant from its reply
To: Venky Shankar <vshankar@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@kernel.org>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Vaishnavi Deshpande <vadeshpa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 10:48 AM Venky Shankar wrote:
> This also runs when the INTR request itself fails (say -ENOMEM, or
> -ERESTARTSYS from ceph_mdsc_wait_for_reset()) after a non-fatal
> signal.
>
> Suppose the task holds a read lock on a byte range and requests to
> upgrade it to a write lock, which waits on the MDS. A handled signal
> interrupts the wait and the INTR request fails, so the lock call
> (correctly) fails in user-space and the task still holds its read
> lock. If the MDS later grants the upgrade, it merges it with the read
> lock, and ceph_lock_orphan_cb() callback then sends an unlock for the
> range. That leaves the owner with no lock on the range on the MDS,
> while the task still thinks it holds the read lock. Consequently,
> another client can now acquire a conflicting write lock.
>
> The same happens if the call is restarted (SA_RESTART) or retried
> before the late grant: the new grant is recorded locally and then
> undone on the MDS by the callback's unlock.

I reproduced both on a test VM. I applied the patch on top of
testing (797fedea5c2b) and compared it against the unpatched
testing module. To make the INTR request fail, I used failslab on
the ceph_mds_request cache, limited to the waiting task. Client A
holds a read lock on [0,100) and blocks upgrading it to a write
lock. Client B also holds a read lock on [0,100).

Upgrade, INTR fails with -ENOMEM, then B unlocks:

  testing:  A local READ; MDS has A's WRITE.  B: F_GETLK -> conflict,
            F_SETLK(F_WRLCK) -> EAGAIN
  patched:  A local READ; MDS has nothing.   B: F_GETLK -> no conflict,
            F_SETLK(F_WRLCK) -> success, while A still holds its read
            lock

Same, but A retries the upgrade before B unlocks:

  testing:  A local WRITE, B gets EAGAIN
  patched:  A local WRITE, B gets the write lock as well

Note that before this patch, a failed INTR left the MDS with a
stronger lock than the one recorded locally. That lock is released
on unlock or close, so the only cost is blocking other clients for
longer. The unconditional unlock in ceph_lock_orphan_cb() turns
this into a weaker lock on the MDS than the one recorded locally,
which breaks the lock semantics. An unlock is sent by owner and
range, so it cannot tell the abandoned request apart from a lock
the same owner holds, or obtains later, on that range.

On the -ERESTARTSYS case: I had assumed that only a fatal signal
could make the INTR request fail with -ERESTARTSYS. You're right,
ceph_mdsc_wait_for_reset() returns it right away for any pending
signal while a reset is in progress. In my test, though, the reset
then tears the session down, so no late grant ever arrives. What
happens instead is the r_err problem below.

There are a few more problems, which I also reproduced:

1) ceph_lock_abandon() sets req->r_err but leaves the request
   registered.

> +       req->r_args.filelock_change.wait =3D 0;
> +       req->r_callback =3D ceph_lock_orphan_cb;
> +       req->r_err =3D err;
> +       set_bit(CEPH_MDS_R_ABANDONED, &req->r_req_flags);

   a) handle_forward() has BUG_ON(req->r_err) on the resend path.
      With two active ranks, I abandoned a queued SETFILELOCK and
      then pinned its directory to the other rank. The MDS forwards
      the queued request and the client crashes:

        kernel BUG at fs/ceph/mds_client.c:4457!
        RIP: 0010:handle_forward.isra.0+0x10f7/0x1520 [ceph]
        RAX: 00000000fffffff4    (-ENOMEM, i.e. req->r_err)
        Workqueue: ceph-msgr ceph_con_workfn [libceph]

      KASAN then reports a slab-use-after-free in
      mutex_can_spin_on_owner(), and the mount is wedged. Without
      the patch, the same sequence logs "forward tid N aborted,
      unregistering".

   b) __do_request() returns early when r_err is set, without
      sending or unregistering the request. After a session reset
      (debugfs reset/trigger), which zeroes r_attempts and kicks the
      requests, the abandoned SETFILELOCK stays in the mdsc request
      list forever, and umount waits for the whole mount_timeout
      (60.7s vs 0.8s without the patch).

   The error can come straight from the wait_func return value
   instead. ceph_mdsc_wait_request() only needs to return err in
   the ABANDONED case, and must not touch req->r_err.

2) ceph_lock_orphan_cb() runs in handle_reply(), in the ceph-msgr
   work for that session, and calls ceph_mdsc_submit_request(),
   which blocks in ceph_mdsc_wait_for_reset() while a reset is in
   progress. I let a late grant arrive during a reset drain. The
   worker sits here:

     ceph_mdsc_wait_for_reset+0x3aa/0xc50 [ceph]
     ceph_mdsc_submit_request+0x79/0x8c0 [ceph]
     ceph_lock_orphan_cb+0x325/0x490 [ceph]
     complete_request+0xaa/0x210 [ceph]
     handle_reply+0x1079/0x2d60 [ceph]
     mds_dispatch+0x242/0x490 [ceph]

   The drain waits for cap flush acks, which sit behind this
   blocked connection, so the drain runs into its 30s timeout and
   falls back to forced teardown ("dropping dirty+flushing AxFx
   state"). Without the patch, the same run drains normally. In
   my run the flush itself had already reached the MDS, so nothing
   was actually lost, but the callback should not submit requests
   from the reply path. Please defer the unlock to a work item.

3) ceph_lock_orphan_cb() checks r_reply_info.head. Checking
   CEPH_MDS_R_GOT_RESULT would be more robust, since head can be
   set when parse_reply_info() fails.

4) The changelog says the request is abandoned for -ENOMEM, -EIO,
   -ETIMEDOUT or -ERESTARTSYS, but the code abandons on any error
   from the INTR request, including errors that the MDS returns.

As for the direction: I think the request should be abandoned only
when the task has a fatal signal pending. In that case the task is
exiting and nobody can keep or retry a lock under that owner. When
the INTR request cannot be sent and there is no fatal signal, keep
the original request as it is and wait for its reply with
wait_for_completion_killable(), then return the real result (record
the grant if there is one). Abandon only if that wait is killed.
While a reset is in progress, the cost is that a signal cannot
interrupt the wait right away, which seems acceptable. That would
fix both of your cases and 1). The flock case (a struct file
shared across fork) still needs a separate look, even with a fatal
signal.

Thanks,
Xiubo

On Thu, 22 Oct 2026 at 10:48, Venky Shankar <vshankar@redhat.com> wrote:
>
> Hi Alex,
>
> On Thu, Oct 22, 2026 at 11:46=E2=80=AFAM Alex Markuze <amarkuze@redhat.co=
m> wrote:
> >
> > Venky Shankar's "ceph: don't drop a lock grant that races with an
> > interrupt" keeps a sent SETFILELOCK registered and waits for the MDS
> > reply, so a grant is not dropped. Xiubo Li pointed out that
> > wait_for_completion() leaves a killed task in D state, and that a
> > failed interrupt request still aborts a request the MDS may already
> > have granted.
> >
> > After the interrupt is sent, wait with wait_for_completion_killable().
> > If that wait is killed, or the interrupt request fails with -ENOMEM,
> > -EIO, -ETIMEDOUT, or -ERESTARTSYS, leave the original request
> > registered and mark it abandoned. ceph_mdsc_wait_request() returns
> > that error instead of aborting or reporting a late grant as success.
> > The reply callback sends an unlock when the result is a grant.
> >
> > Suggested-by: Xiubo Li <xiubli@kernel.org>
> > Cc: Venky Shankar <vshankar@redhat.com>
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> > Base: https://github.com/ceph/ceph-client.git testing
> > 797fedea5c2bc44fc6d92526999fd4242052a4ee ("ceph: fix uninitialized err =
in ceph_netfs_issue_read()")
> >
> >  fs/ceph/locks.c      | 119 +++++++++++++++++++++++++++++++++----------
> >  fs/ceph/mds_client.c |  11 +++-
> >  fs/ceph/mds_client.h |   1 +
> >  3 files changed, 102 insertions(+), 29 deletions(-)
> >
> > diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> > index 4bd96d0beba4..308de4c4f31a 100644
> > --- a/fs/ceph/locks.c
> > +++ b/fs/ceph/locks.c
> > @@ -163,6 +163,66 @@ static int ceph_lock_message(u8 lock_type, u16 ope=
ration, struct inode *inode,
> >         return err;
> >  }
> >
> > +/*
> > + * The waiter was killed, or the interrupt request failed, after the
> > + * original SETFILELOCK was sent. The MDS may still grant it. Unlock a
> > + * grant so the lock is not left held by a caller that already returne=
d
> > + * an error and did not record it locally.
> > + */
> > +static void ceph_lock_orphan_cb(struct ceph_mds_client *mdsc,
> > +                               struct ceph_mds_request *req)
> > +{
> > +       struct ceph_client *cl =3D mdsc->fsc->client;
> > +       struct ceph_mds_request *unlock;
> > +       struct inode *inode =3D req->r_inode;
> > +       int result, err;
> > +
> > +       if (!req->r_reply_info.head)
> > +               return;
> > +       result =3D le32_to_cpu(req->r_reply_info.head->result);
> > +       if (result)
> > +               return;
> > +
> > +       unlock =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETFILELO=
CK,
> > +                                         USE_AUTH_MDS);
> > +       if (IS_ERR(unlock)) {
> > +               pr_warn_ratelimited_client(cl,
> > +                       "abandoned lock grant on %llx.%llx could not be=
 unlocked: %ld\n",
> > +                       ceph_vinop(inode), PTR_ERR(unlock));
> > +               return;
> > +       }
> > +
> > +       unlock->r_inode =3D inode;
> > +       ihold(inode);
> > +       unlock->r_num_caps =3D 1;
> > +       unlock->r_args.filelock_change =3D req->r_args.filelock_change;
> > +       unlock->r_args.filelock_change.type =3D CEPH_LOCK_UNLOCK;
> > +       unlock->r_args.filelock_change.wait =3D 0;
> > +
> > +       err =3D ceph_mdsc_submit_request(mdsc, inode, unlock);
> > +       if (err)
> > +               pr_warn_ratelimited_client(cl,
> > +                       "abandoned lock grant on %llx.%llx could not be=
 unlocked: %d\n",
> > +                       ceph_vinop(inode), err);
> > +       ceph_mdsc_put_request(unlock);
> > +}
> > +
> > +/* mdsc->mutex held. The request has been sent and has no result yet. =
*/
> > +static int ceph_lock_abandon(struct ceph_mds_client *mdsc,
> > +                            struct ceph_mds_request *req, int err)
> > +{
> > +       lockdep_assert_held(&mdsc->mutex);
> > +
> > +       if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags))
> > +               return 0;
> > +
> > +       req->r_args.filelock_change.wait =3D 0;
> > +       req->r_callback =3D ceph_lock_orphan_cb;
> > +       req->r_err =3D err;
> > +       set_bit(CEPH_MDS_R_ABANDONED, &req->r_req_flags);
> > +       return err;
> > +}
> > +
> >  static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
> >                                           struct ceph_mds_request *req)
> >  {
> > @@ -191,12 +251,11 @@ static int ceph_lock_wait_for_completion(struct c=
eph_mds_client *mdsc,
> >                 err =3D 0;
> >         } else if (!req->r_session) {
> >                 /*
> > -                * haven't sent the request, so the MDS can't have gran=
ted
> > -                * the lock: abort it.
> > -                *
> > -                * ensure we aren't running concurrently with
> > -                * ceph_fill_trace or ceph_readdir_prepopulate, which
> > -                * rely on locks (dir mutex) held by our caller.
> > +                * Not sent, so the MDS cannot have granted the lock:
> > +                * abort it. Take r_fill_mutex so this does not run
> > +                * concurrently with ceph_fill_trace or
> > +                * ceph_readdir_prepopulate, which rely on locks held
> > +                * by our caller.
> >                  */
> >                 mutex_lock(&req->r_fill_mutex);
> >                 req->r_err =3D err;
> > @@ -223,32 +282,38 @@ static int ceph_lock_wait_for_completion(struct c=
eph_mds_client *mdsc,
> >
> >         intr_req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_SETFILE=
LOCK,
> >                                             USE_AUTH_MDS);
> > -       if (IS_ERR(intr_req))
> > -               return PTR_ERR(intr_req);
> > -
> > -       intr_req->r_inode =3D inode;
> > -       ihold(inode);
> > -       intr_req->r_num_caps =3D 1;
> > +       if (!IS_ERR(intr_req)) {
> > +               intr_req->r_inode =3D inode;
> > +               ihold(inode);
> > +               intr_req->r_num_caps =3D 1;
> >
> > -       intr_req->r_args.filelock_change =3D req->r_args.filelock_chang=
e;
> > -       intr_req->r_args.filelock_change.rule =3D lock_type;
> > -       intr_req->r_args.filelock_change.type =3D CEPH_LOCK_UNLOCK;
> > +               intr_req->r_args.filelock_change =3D req->r_args.filelo=
ck_change;
> > +               intr_req->r_args.filelock_change.rule =3D lock_type;
> > +               intr_req->r_args.filelock_change.type =3D CEPH_LOCK_UNL=
OCK;
> >
> > -       err =3D ceph_mdsc_do_request(mdsc, inode, intr_req);
> > -       ceph_mdsc_put_request(intr_req);
> > -
> > -       if (err && err !=3D -ERESTARTSYS)
> > -               return err;
> > +               err =3D ceph_mdsc_do_request(mdsc, inode, intr_req);
> > +               ceph_mdsc_put_request(intr_req);
> > +       } else {
> > +               err =3D PTR_ERR(intr_req);
> > +       }
> >
> >         /*
> > -        * Once it has handled the interrupt, the MDS replies to the
> > -        * original request: 0 if the lock was granted first, -EINTR if
> > -        * the wait was cancelled. Wait for that reply even with a fata=
l
> > -        * signal pending, so that the caller records a granted lock an=
d
> > -        * the lock gets released when the file is closed.
> > +        * The MDS replies to the original request after the interrupt:
> > +        * 0 if the lock was granted first, -EINTR if the wait was
> > +        * cancelled. A fatal signal must not turn this into an
> > +        * uninterruptible sleep. If this wait is killed, or the
> > +        * interrupt request never went out, leave the original request
> > +        * registered. Its reply callback unlocks a late grant.
> >          */
> > -       wait_for_completion(&req->r_completion);
> > -       return 0;
> > +       if (!err)
> > +               err =3D wait_for_completion_killable(&req->r_completion=
);
> > +       if (!err)
> > +               return 0;
> > +
> > +       mutex_lock(&mdsc->mutex);
> > +       err =3D ceph_lock_abandon(mdsc, req, err);
>
> This also runs when the INTR request itself fails (say -ENOMEM, or
> -ERESTARTSYS from ceph_mdsc_wait_for_reset()) after a non-fatal
> signal.
>
> Suppose the task holds a read lock on a byte range and requests to
> upgrade it to a write lock, which waits on the MDS. A handled signal
> interrupts the wait and the INTR request fails, so the lock call
> (correctly) fails in user-space and the task still holds its read
> lock. If the MDS later grants the upgrade, it merges it with the read
> lock, and ceph_lock_orphan_cb() callback then sends an unlock for the
> range. That leaves the owner with no lock on the range on the MDS,
> while the task still thinks it holds the read lock. Consequently,
> another client can now acquire a conflicting write lock.
>
> The same happens if the call is restarted (SA_RESTART) or retried
> before the late grant: the new grant is recorded locally and then
> undone on the MDS by the callback's unlock.
>
> > +       mutex_unlock(&mdsc->mutex);
> > +       return err;
> >  }
> >
> >  static int try_unlock_file(struct file *file, struct file_lock *fl)
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index d4ef8a355a48..f485beb3584b 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -4076,8 +4076,15 @@ int ceph_mdsc_wait_request(struct ceph_mds_clien=
t *mdsc,
> >         boutc(cl, "do_request waited, got %d\n", err);
> >         mutex_lock(&mdsc->mutex);
> >
> > -       /* only abort if we didn't race with a real reply */
> > -       if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
> > +       /*
> > +        * The caller was killed or the interrupt request failed after
> > +        * this request was sent. Leave it registered. A late grant is
> > +        * unlocked by r_callback; do not turn that grant into success
> > +        * for a caller that has already given up.
> > +        */
> > +       if (test_bit(CEPH_MDS_R_ABANDONED, &req->r_req_flags)) {
> > +               err =3D req->r_err;
> > +       } else if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) =
{
> >                 err =3D le32_to_cpu(req->r_reply_info.head->result);
> >                 if (err > 0 || err < -MAX_ERRNO) {
> >                         /*
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 863cdb8d588a..e198ede629fd 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -360,6 +360,7 @@ struct ceph_mds_request {
> >  #define CEPH_MDS_R_PARENT_LOCKED       (7) /* is r_parent->i_rwsem wlo=
cked? */
> >  #define CEPH_MDS_R_ASYNC               (8) /* async request */
> >  #define CEPH_MDS_R_FSCRYPT_FILE                (9) /* must marshal fsc=
rypt_file field */
> > +#define CEPH_MDS_R_ABANDONED           (10) /* caller left; reply unlo=
cks a grant */
> >         unsigned long   r_req_flags;
> >
> >         struct mutex r_fill_mutex;
> >
> > base-commit: 797fedea5c2bc44fc6d92526999fd4242052a4ee
> > --
> > 2.34.1
> >
>
>
> --
> Cheers,
> Venky
>
