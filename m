Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188340;
	b=SjayT1GetzkphwJfTRwUPZhkPZ6KwagrkkFpbr/+ezlz71CRnG3o4P+99+SClwbr97au
	 ND5s+zaQH0kQHaMTeodQbUY4SG+ikDJZ6+MyWP0sBX26F1mV4m56NN/oJV+HsVBeT+3Dc
	 5n2olIT6Co/HLiQ8SDxnexOZzpZMFIe6oFL+Maw6WOUH4dNQ/JrWDgMiwXfVtSEfwaEiR
	 W0vbXbXmmYFHVz8yatzKDwThDe3y6uDPG9EaSdOtJSvopNyMII6LLKGr4lgY1sj5q5EQR
	 TcRw5QJ0i296AElpGope1qf1SV7HFb+0zyb/h7Ng98lM02xB0E7E7gvXC4FmgzkF1UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188340;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-FangMail-Miltered:X-FangMail-Envelope:
	 X-FangMail-Bounce-Flag:X-FangMail-Outinfo:X-CLEAN:Message-Id:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=x1muTvUlf9SEhMdygrZyzxBP7L0PY5h9SJntq65AnLM=;
	b=twUL7sBPxQo46VOQIv4Wbvlwo/H4FuIR+pHe9dJtwXvqfVbxP6tAh+/15QqADNxyVmbW
	 tgdO5plDwOJcUI9HuBAc8EOBhWyF7RWB2u7848pY0Gl3bvGDRCsiPYsy7HDD4G+lkQC8c
	 vNMpcuTii11GAQuO31lQlvfvbxGLqBg7WAdFdWcn2HATcCq2Nk4B0j+zz3t+HWUnJcEk+
	 WfkfWjvT5ww8lUdjsRtYMigZNN4wvQq8IfQKhM29Rg2Ep3H+FLfQ3ZsQ3wlQ/mplujUdX
	 8BxEEcfJZxe9X4ALpqKQ6y1jdxgbqsxx9QyqdLFrezw3xNJbNKK45ak7+uq1ZqeLGsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406DA606A31C;
	Mon,  9 Nov 2026 01:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 406DA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jNC9j12vbz23pF;
	Mon, 09 Nov 2026 09:38:49 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Xiubo Li <xiubli@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlzhangak@isoftstone.com
Subject: Re: [PATCH] ceph: revalidate dentries under snapdir to drop stale snapshots
Date: Mon,  9 Nov 2026 09:38:48 +0800
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAOuZWzyZoQ9oAHKmxVg7B292Vx-QZ2E+QLt6xVnpfKpps+4Yfw@mail.gmail.com>
References: <20261106021310.777075-1-dlzhangak@isoftstone.com> <CAOuZWzyZoQ9oAHKmxVg7B292Vx-QZ2E+QLt6xVnpfKpps+4Yfw@mail.gmail.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Mon, 09 Nov 2026 09:38:49 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AF12428.004 by FangMail milter!
X-FangMail-Envelope: 1794188329/4jNC9j12vbz23pF/6AF12428.004/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794188329.6AF12428.004
X-FangMail-Outinfo: 1794188329/6AF12428.004/4jNC9j12vbz23pF/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794188329.6AF12428.004.4jNC9j12vbz23pF@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF12428.004/4jNC9j12vbz23pF

On Sat, Nov 7, 2026 at 12:17 PM Xiubo Li <xiubli@kernel.org> wrote:
>
> Hi Daolong,
>
> Thanks for the patch. I can reproduce this with two kernel clients, and
> it is a bit worse than described: after B removes .snap/s3 and creates a
> new .snap/s3, A still reads the file contents of the old snapshot. A
> removed ancestor snapshot also stays visible as .snap/_p1_<ino> in child
> directories. Your patch fixes all of these cases.
>
> [...]
>
> >         /* always trust cached snapped dentries, snapdir dentry */
> > -       if (ceph_in_snap(dir)) {
> > +       if (ceph_in_snap(dir) && ceph_snap(dir) != CEPH_SNAPDIR) {
>
> With this change nothing can validate a dentry under .snap anymore. The
> MDS issues no lease for it, the snapdir only has CEPH_CAP_PIN, and a
> snapped inode has no real caps. So every path walk through .snap/<name>
> does a synchronous LOOKUPSNAP. With 3000 stats of .snap/s3/f on a cached
> snapshot (in a VM, so only the order of magnitude matters):
>
>                  ops/s   LOOKUPSNAP   p50/p99 (us)
>   unpatched     257834        0         3.1/6.9
>   this patch     10065     3000        89.9/273.1
>   realm check   234741        0         3.4/7.5
>
> The "realm check" row is an alternative that avoids the round trip. The
> client already knows which snapshots exist: the directory's snap realm
> keeps the list in cached_context, and the MDS sends a snap update to
> every client with caps in the realm when a snapshot is created or
> removed. So d_revalidate can keep trusting a dentry under .snap while
> its snapid (ceph_snap(inode)) is still in the realm's snap context of
> the head directory, and only fall back to LOOKUPSNAP when it is not, or
> when we hold no caps on that directory.
>
> I tried this on 7.2.9. It fixes the same cases as your patch: recreating
> a snapshot, reading stale data, removed ancestor snapshots, and 50/50
> "B rmdir, A mkdir right away" rounds. It sends no LOOKUPSNAP on cache
> hits. I can send you the diff I tested if it helps.

Hi Xiubo,

Thank you very much for reproducing the issue, identifying the additional
stale read and removed ancestor snapshot cases, and benchmarking the
LOOKUPSNAP overhead.

Validating the dentry against the head directory's snap realm
cached_context (when holding caps on the head directory) before falling
back to LOOKUPSNAP makes total sense and avoids the unnecessary MDS round
trips on cache hits. Could you please share the diff you tested? I would
be glad to incorporate it and test it for v2.

> >                 if (!err && !req->r_reply_info.head->is_dentry)
> >                         d_delete(dentry);
> > +               else if (err == -ENOENT)
> > +                       d_drop(dentry);
>
> Please make this a separate patch. With the revalidate fix, rmdir of a
> stale snapshot already fails in the lookup and never sends RMSNAP. I
> checked the MDS counter with and without this hunk. Also, this hunk
> affects unlink() of regular files too.

Agreed. I will drop this hunk from v2 and send it as a separate patch.

> Nits: the "always trust cached snapped dentries, snapdir dentry" comment
> needs an update. Also, the trust-all check dates back to 2817b000b02c,
> while 200fd27c8fa2 only added the unreachable LOOKUPSNAP branch, so
> please explain the choice of Fixes: tag.

I originally chose 200fd27c8fa2 ("ceph: use lookup request to revalidate
dentry") because it explicitly added the CEPH_MDS_OP_LOOKUPSNAP branch in
ceph_d_revalidate() intending to revalidate dentries under CEPH_SNAPDIR,
but overlooked that the earlier check from 2817b000b02c ("ceph: directory
operations") made it unreachable. In v2, I will update the comment and
point Fixes: to 2817b000b02c (while also mentioning 200fd27c8fa2 in the
commit message).

Thanks,
Daolong
