Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444512;
	b=orw5Lk0Q2PuNRZOl+gJi3UpFcqeNi2Cj3JDuXc6eqbB0WGs2I/vQAZj4ZZHX8fzgXadV
	 wrQe8o1oqaNSYSyVRAiCDdhDRXrnR7FBmGdiHp/rM3IZuGg/KNEuUe9pd1isYMEtfRERj
	 o03E3KodQ+8uNVsKO4ISJk6i4ds3ROsxCwEoN6vmAPBQ7mr+1EbqNAgAH7K1Z17a5Vk01
	 mEkO2fDam7KBVn/K8ZiLbE2YXnRRW7hKELlJfnVoiC8Mx0OLDFQ9SvIUrkg0tAklPEENx
	 uqJAm7f2qnTkapDRE5USPe02/JaYDyLpQVgEofm0idW0jyIQLLxARhGushNe6NDCFHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444512;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=A29kYjsS1uYa3Ev60u9XnEV7WvOcqoS+1dOhNpZbyWc=;
	b=ozpByJa8kL7YS9gbOPB3DOGa1+w1LGhVDWLV56N/kpw20mOT0WUhCNoPSJ3TI9+QKHD+
	 gZimN93pE9TTxg5lBCOyHgDcHzErh/fbBu8uXB3pWphoJGGv75GdcGwWlfY+9hqq3RBg8
	 cr1s3/e2bP7kdceRSIwGB8+J+ZRmqAlzOjoZRccrOfVo4/uTgHUz5a8dAvOfBxDr3EtAw
	 rKncIykCv67lCQQs4MBXfxp48nXq1ydvoehRYsVcncb6IsX/RcRpNDeC/eMTWbT89SOKH
	 ZpkMjhXpuWYOUBP/9DDF2Dh1oIr0SFG+ukEP+qVDGg1lekHW3DIRiYS222Oz8brsNeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iS0u8i6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF4606A33C
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iS0u8i6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBB51F00A06
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 00:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444511;
	bh=A29kYjsS1uYa3Ev60u9XnEV7WvOcqoS+1dOhNpZbyWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iS0u8i6aJBVq0IpRVzvcp+6nkkJYg7H0piDz+z+m+sancuEStW98CJClMiik6WJuT
	 srHfB7RPvkWZSjIooTyHCXVsGdvpVcwhFKfBRZxfx+ZBXeWGTf6qmTWc3pTDEhve5k
	 IUW63YUwfbdO13CrM+7YKsVyq8xsNg2hNVVKeLPCpYXHtxtv3Ayp8+LK0ajuqpLW6B
	 vLK00L8t8pZyFB891L5Ig47i4yJylbu4dBp77NPVTMBG5CqsiJARCUzyNkdad3sRju
	 wo7A5o8XeyNcEZbK2XidGnKppqrYIbDWsj4BWggxOM41KzsUb33eThXqdZA/9P05+n
	 Q+rxyrJ5sRoAw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso2419301e87.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:48:31 -0800 (PST)
X-Gm-Message-State: APuU4Z+OvOJEUakqD85ts3JlRFxRllRAS/mNwAPpc1EOhJvkVDi9+xx6
	J8sxmi1GtLs7qMkR80tlqHniB+It8ciTWzXBJYBFGKxXYLcwqtNdplg0YJe85h2LoTRhNuH7hQZ
	y//vw72VSHLTaJ3CKZNFFGAFm9WSzuDo=
X-Received: by 2002:ac2:5695:0:b0:5c1:4aa7:1847 with SMTP id
 2adb3069b0e04-5c15d62c181mr1349115e87.10.1794444510270; Wed, 11 Nov 2026
 16:48:30 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110201025.255594-1-idryomov@gmail.com> <20261110201025.255594-3-idryomov@gmail.com>
In-Reply-To: <20261110201025.255594-3-idryomov@gmail.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Thu, 12 Nov 2026 01:48:18 +0100
X-Gmail-Original-Message-ID: <CAOuZWzxo5QyoJcVarhYwHYA0tyiRN+O=yUVFRKksSmd+TUcqCQ@mail.gmail.com>
X-Gm-Features: AclHuK_jnRwTXACZjS9VNcDD5LbfcZsXfVB356ExbG3utEG3rV8Ibb-T4Wzhep4
Message-ID: <CAOuZWzxo5QyoJcVarhYwHYA0tyiRN+O=yUVFRKksSmd+TUcqCQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] libceph: don't cancel in-flight ping in send_linger_ping()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Dongsheng Yang <dongsheng.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On 11/10/26 21:10, Ilya Dryomov wrote:
[...]
> @@ -3189,12 +3183,6 @@ static void linger_ping_cb(struct ceph_osd_request *req)
>       struct ceph_osd_linger_request *lreq = req->r_priv;
>
>       mutex_lock(&lreq->lock);
> -     if (req != lreq->ping_req) {
> -             dout("%s lreq %p linger_id %llu unknown req (%p != %p)\n",
> -                  __func__, lreq, lreq->linger_id, req, lreq->ping_req);
> -             goto out;
> -     }
> -
[...]
> -out:
> +     list_del_init(&req->r_private_item);
>       mutex_unlock(&lreq->lock);
> +
> +     ceph_osdc_put_request(req);
>       linger_put(lreq);
>  }

The callbacks now assume that the request is still on lreq->osd_reqs,
i.e. that they still own the list's reference, but that isn't
guaranteed.  handle_reply() calls finish_request() (which clears
req->r_osd) and drops osd->lock and osdc->lock before
__complete_request() runs the callback.  If send_linger() or
__linger_cancel() gets in between, it sees req->r_osd == NULL, skips
cancel_linger_request() and does:

        list_del_init(&req->r_private_item);
        ceph_osdc_put_request(req);

Then the callback does list_del_init() on an already empty entry and
puts the request a second time, and __complete_request() follows with
complete_all() and its own put on freed memory:

  handle_reply()                     send_linger() / __linger_cancel()
    finish_request(req)  /* r_osd = NULL */
    up_read(&osdc->lock)
                                       mutex_lock(&lreq->lock)
                                       req->r_osd == NULL, no cancel
                                       list_del_init(), put  /* 2 -> 1 */
                                       mutex_unlock(&lreq->lock)
    __complete_request(req)
      linger_ping_cb(req)
        list_del_init()  /* no-op */
        put                          /* 1 -> 0, freed */
      complete_all(&req->r_completion)  /* UAF */
      ceph_osdc_put_request(req)        /* underflow */

The same applies to linger_commit_cb() and linger_reconnect_cb().  The
old code was safe here because of the req != lreq->ping_req/reg_req
check and because the lreq held its own reference to the request.

The window is naturally small, but it does not have to be: the callback
can be waiting on lreq->lock while send_linger() holds it across a
GFP_NOIO allocation.  To show it deterministically I added a test-only
msleep() in __complete_request() for r_linger requests (before calling
r_callback) and ran rbd on a KASAN kernel against a vstart cluster.
Closing the window in two ways:

 1) rbd unmap (__linger_cancel()) while a ping callback is delayed
 2) "ceph osd down <primary of rbd_header>" while a ping callback is
    delayed (osdmap -> scan_requests() -> send_linger()); this is the
    case one would expect to see in the field, an OSD flapping while a
    ping reply is being handled

Without this series, both runs are clean (the callback sees a refcount
of 2).  With the series applied, both runs end with:

  libceph: lping: run cb req 000000000cb00fcd ref 1
  BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave+0x4d/0xa0
  Read of size 1 at addr ffff888258fa9f00 by task kworker/5:1/137
   complete_all+0x97/0x190
   __complete_request+0x9c/0x3b0 [libceph]
   handle_reply+0x995/0x1120 [libceph]
   osd_dispatch+0x9f/0x160 [libceph]
  Freed by task 137:
   mempool_free+0xd8/0x150
   linger_ping_cb+0x21b/0x6e0 [libceph]
   __complete_request+0x90/0x3b0 [libceph]
   handle_reply+0x995/0x1120 [libceph]
  ...
  refcount_t: underflow; use-after-free.
  kernel BUG at lib/refcount.c:37!

Treating a request that is no longer on lreq->osd_reqs as stale fixes
it for me, in all three callbacks:

        mutex_lock(&lreq->lock);
        if (list_empty(&req->r_private_item)) {
                dout("%s lreq %p linger_id %llu stale req %p\n", __func__,
                     lreq, lreq->linger_id, req);
                mutex_unlock(&lreq->lock);
                linger_put(lreq);
                return;
        }
        ...

Both tests above are clean with it (the callback then sees a refcount
of 1 and returns without a put).  Just making the put conditional
(put = !list_empty(&req->r_private_item)) is also enough for the UAF
and passes the same tests, but I think skipping the reply is better,
because the series also stopped filtering stale replies: with the
req != lreq->reg_req check gone, a reply to a superseded reg/reconnect
request is now processed as if it were current.  To check, I delayed a
reconnect callback, marked the primary down a second time inside that
window so that send_linger() replaced the reconnect request, and
enabled the douts:

  without the series:
    linger_reconnect_cb lreq ... unknown req (0000000040e0d613 !=
000000006664a4c9)
  series + conditional put:
    linger_reconnect_cb lreq ... result 0 last_error 0    <- stale request
    linger_reconnect_cb lreq ... result 0 last_error 0    <- current request
  series + skipping stale requests:
    linger_reconnect_cb lreq ... stale req 00000000433ad8d9
    linger_reconnect_cb lreq ... result 0 last_error 0

Here the stale reply was a success, so nothing visible happened.  But
an error in a stale reconnect reply would now set lreq->last_error and
queue a watch error, and in linger_commit_cb() a stale reply would
re-run linger_reg_commit_complete() and, for a notify, overwrite
lreq->notify_id.  I haven't tried to trigger those consequences.

One more observation, not a bug: there is now no limit on the number of
in-flight pings.  With the primary OSD SIGSTOPped, the number of
watch-ping requests in osdc grows by one every osd_keepalive_timeout:
11 after 39 seconds, while without the series it never goes above 1.
That is the point of the patch of course, but nothing bounds it for an
unresponsive OSD whose session stays up.  In my vstart setup the
stopped OSD was not marked down at all during a 90 second run.  An osdmap
change does drain the list through send_linger() (as in the test
above), and with osd_request_timeout=15 the count peaked at 3 before
the first ping timed out and the watch error (-110) stopped further
pings.  (The test kernel also carries a local patch that resets an OSD
session when it doesn't answer keepalives.  That patch is what cleared
the pings after ~40 seconds; the count was back at 14 another 48
seconds later.)  With lots of mapped images that could add up.

Would it make sense to stop sending new pings once the oldest one is
older than the watch timeout, given that the watch is going to be torn
down anyway at that point?

Thanks,
Xiubo
