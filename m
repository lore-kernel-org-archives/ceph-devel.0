Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E26385D64
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783035438; cv=none; b=j1+8TbLaEe/cBtK/pG+rpQo8ynewe+M5AKEoM2lLalV4mGmhHoJ+MNw04aAm2zZzie8vzAQ/BbuDgggpiccXQuxI16G6b+jXo90SZEgSp9EBpVD9HtPx5WhX1t9Yrf5Q15LOq0LKU+t3nyAKyPWx46/JVbn/Xp6ZQVH/yFldaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783035438; c=relaxed/simple;
	bh=enXUQZo+pnS/NI2ch4URz6E5HAO9qS+k8PZJ8BEQhPQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=a3exvnejcsuOgLfDIItkk1JJHu7DXPQRj5T8C+I6kPVvmCHS6Or6WkIWdi494l70l0Z9BqtYu9tP6PL6h/2Tx5FBN5BPkDmJNBUqtk0BGiAdnkWsjXlM019dD81YNXy3qR2keJoZ7m+pi+YEEjs+wE3iw3A+/SAAUc1DkZaL2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZa2m/dq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZa2m/dq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c2a818fc4so122421cf.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783035435; x=1783640235; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNvhDNQ0w+AUdeHkJIYE5XXD0dbBsXthI+/qPurx47w=;
        b=CZa2m/dqUjixIPhp8+qt5VpUNXlPWF2fI9yzGJ/z18lL9xOgmFXI9hVQ19UYT4TC8+
         HUVdy8cppGgjHQiXta73WzliFX1QBnoGiDinJgVGhBfj6M021ty6u2J2aZGDea/JsCXI
         em2SnwHjn9OPtCqehTYo+Fj6PhiAkcwOlsZy+DnuIbSH9n8sVktNFpeQbgBshojZk6XU
         CRMzznBgo9S2tfZqQ0T/e9/9YbUG5KEfbNsCshT789ORYZKyIhEW+aVU4QRUjhcnOrIt
         3TWCk2PKyMZs+5AYh5IqqIHhJ9Tnmmt6qGCPaqYa9VCS0CYB3FXD3It9Q+I3c3gcaPGu
         Kumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783035435; x=1783640235;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNvhDNQ0w+AUdeHkJIYE5XXD0dbBsXthI+/qPurx47w=;
        b=oI2TucYDYbbnbdG65nvF8Qv9QTSRIcl831oDzmNDbJfBhD0Lq1YSdBarZkR6R53EIG
         +Gz2fi7rLLXzWXTt8geli9yffHOF4hG0BBFO3eHOe/7vM6TozdOye4QA+fuRKgdGa9wJ
         O8fA/xrGftVk7hpdpXF817xrh+7jSdWh2QOcDgVzs8aFgkRNAoj2Mzd63sii/Epea6no
         1szbfPWnho5HsoKwDXqZhc9KdMx4HYOwn1qCWamX0qRk56st8YXwiSK0VnG+Zg1nnBtm
         i4AwK8NEIKUY2Q7Mx8xhrrzVWaTGJckjS1WoiZzOHuzavvniGLgujUX2KegWo2I1Vi73
         +jtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cUbVdRj9LNXWovo2X3T1hoAIYwkMwhvX7wCBB+jMEGvGDyFfT+/69Qm6b72fQmKBYl7gYIdoLw2bG@vger.kernel.org
X-Gm-Message-State: AOJu0YzFElJK5aA901RM3LUISvehJ+2ira8bPEfzraoZbmsm4g5WHu2v
	V9RxPdQo3ulSk7velKlqYh6kIQygSN37Zkgt2mWHSa3KWCjNcVG95G9z
X-Gm-Gg: AfdE7cmRUXhp8dizMt0bqMiMrvn2GiBgVSVlzFPZZ86p0AEqSdPQwIgPtx0vZ8wDUWD
	2FwpPXZiKQB7EWLMDBBxUcNOxyAjgZSs7fsjJkwywEw8j6PSkOqUrVwLQo6e+BdZJFGAOrnYs1b
	JTs16e74rcBOmBWkjI1fAdtOBwcyKQWvZRwYMEib2QXVWVe00d7RL23lR6QtcapUuuu+p0syPqe
	JbkxTRzQh7qW0ame/3VrY/eWQ7YMqFigik4w9MU+7/AYVOBtPZDUP8ILPTxNJ9RKwsUdKHRo7ch
	bdM3EktmRD9Z51qW7MOixWdL2A7rjfEjeC/xOUBv1qp3/crkCJeOCGG2RlO61AV3vmGk6f7fEUZ
	SZvZ5qr/SyJ6ATErYgX8AQDfZOaKAJ6jfr3A3FVvXilFQOlMUeKWPkH6BUtSsSLJcO0MO8Bih8p
	39ib+51lJUvqeh1QtwtBYdnCCm8wDImrk6dVd88bxeWku4JsyZXuJraQ==
X-Received: by 2002:a05:622a:44:b0:51c:52a:8e70 with SMTP id d75a77b69052e-51c26a3c1f7mr124727411cf.2.1783035434798;
        Thu, 02 Jul 2026 16:37:14 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:b43e:3302:2fab:914e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d526sm41952426d6.4.2026.07.02.16.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2026 16:37:14 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [BUG] ceph: KASAN slab-use-after-free in
 ceph_put_wrbuffer_cap_refs
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <8371ae54da48303972868a674203a25517b91dbb.camel@ibm.com>
Date: Thu, 2 Jul 2026 19:36:43 -0400
Cc: "idryomov@gmail.com" <idryomov@gmail.com>,
 Alex Markuze <amarkuze@redhat.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7E6FA89-D3B2-4D8A-932F-D053139333F9@gmail.com>
References: <A8282F50-9D26-4DF3-8B86-D09252A5767A@gmail.com>
 <8371ae54da48303972868a674203a25517b91dbb.camel@ibm.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)



> On Jul 2, 2026, at 19:17, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> =
wrote:
>=20
> On Thu, 2026-07-02 at 19:04 -0400, Shuangpeng wrote:
>> Hi Kernel Maintainers,
>>=20
>> I hit the following KASAN report while testing current upstream =
kernel:
>>=20
>> KASAN: slab-use-after-free in ceph_put_wrbuffer_cap_refs
>>=20
>> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
>>=20
>> The reproducer and .config files are here.
>> =
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gist.github.com_shu=
angpengbai_c82cc2452f2fd3f31815efb83ad80b1d&d=3DDwIFAg&c=3DBSDicqBQBDjDI9R=
kVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3DbPfk3u50-mrnDs=
oQNdjCYDwvBNxK4JGRLVR2_NvKuibLdwpIju0JgsLu5wfnytku&s=3D9_IvpHlSSMJX1HjsdL9=
3p04TtX8z5-uuR3OBv6SgGmg&e=3D=20
>>=20
>> I'm happy to test debug patches or provide additional information.
>>=20
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>>=20
>> [  197.863252][  T795] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [  197.864328][  T795] BUG: KASAN: slab-use-after-free in =
ceph_put_wrbuffer_cap_refs (fs/ceph/caps.c:3404)
>> [  197.866347][  T795] Read of size 8 at addr ffff888117a93c38 by =
task kworker/1:2/795
>> [  197.867135][  T795]
>> [  197.867396][  T795] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX =
+ PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [  197.867399][  T795] Workqueue: ceph-msgr ceph_con_workfn
>> [  197.868513][  T795] Call Trace:
>> [  197.868518][  T795]  <TASK>
>> [  197.868521][  T795]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
>> [  197.868529][  T795]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
>> [  197.868548][  T795]  kasan_report (mm/kasan/report.c:595)
>> [  197.868555][  T795]  ceph_put_wrbuffer_cap_refs =
(fs/ceph/caps.c:3404)
>> [  197.868560][  T795]  writepages_finish (fs/ceph/addr.c:980)
>> [  197.868568][  T795]  osd_dispatch (net/ceph/osd_client.c:2524 =
net/ceph/osd_client.c:3870 net/ceph/osd_client.c:5370)
>> [  197.869699][  T795]  ceph_con_process_message =
(net/ceph/messenger.c:1425)
>> [  197.869718][  T795]  ceph_con_v1_try_read =
(net/ceph/messenger_v1.c:1430)
>> [  197.869727][  T795]  ceph_con_workfn (net/ceph/messenger.c:1577)
>> [  197.869731][  T795]  process_scheduled_works =
(kernel/workqueue.c:3314 kernel/workqueue.c:3397)
>> [  197.869739][  T795]  worker_thread (kernel/workqueue.c:3478)
>> [  197.869754][  T795]  kthread (kernel/kthread.c:436)
>> [  197.869765][  T795]  ret_from_fork (kernel/process.c:158)
>> [  197.869773][  T795]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
>> [  197.869780][  T795]  </TASK>
>> [  197.869782][  T795]
>> [  197.887591][  T795] Freed by task 795 on cpu 1 at 197.863249s:
>> [  197.888221][  T795]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
>> [  197.888728][  T795]  kasan_save_free_info (mm/kasan/generic.c:584)
>> [  197.889253][  T795]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
>> [  197.889758][  T795]  kmem_cache_free (include/linux/kasan.h:235 =
mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6378)
>> [  197.890256][  T795]  ceph_try_drop_cap_snap (fs/ceph/super.h:283 =
fs/ceph/caps.c:3213)
>> [  197.890820][  T795]  ceph_put_wrbuffer_cap_refs =
(fs/ceph/caps.c:3396)
>> [  197.891411][  T795]  writepages_finish (fs/ceph/addr.c:980)
>> [  197.891930][  T795]  osd_dispatch (net/ceph/osd_client.c:2524 =
net/ceph/osd_client.c:3870 net/ceph/osd_client.c:5370)
>> [  197.892422][  T795]  ceph_con_process_message =
(net/ceph/messenger.c:1425)
>> [  197.892999][  T795]  ceph_con_v1_try_read =
(net/ceph/messenger_v1.c:1430)
>> [  197.893552][  T795]  ceph_con_workfn (net/ceph/messenger.c:1577)
>> [  197.894053][  T795]  process_scheduled_works =
(kernel/workqueue.c:3314 kernel/workqueue.c:3397)
>> [  197.894614][  T795]  worker_thread (kernel/workqueue.c:3478)
>> [  197.895096][  T795]  kthread (kernel/kthread.c:436)
>> [  197.895519][  T795]  ret_from_fork (kernel/process.c:158)
>> [  197.896005][  T795]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
>> [  197.896498][  T795]
>> [  197.896754][  T795] The buggy address belongs to the object at =
ffff888117a93be0
>> [  197.896754][  T795]  which belongs to the cache ceph_cap_snap of =
size 240
>> [  197.898196][  T795] The buggy address is located 88 bytes inside =
of
>> [  197.898196][  T795]  freed 240-byte region [ffff888117a93be0, =
ffff888117a93cd0)
>>=20
>=20
> It will be great if you can create the ticket in Ceph tracker [1].
>=20

I created the Ceph tracker ticket here:
https://tracker.ceph.com/issues/77923

Thanks,
Shuangpeng

> Thanks,
> Slava.
>=20
> [1] https://tracker.ceph.com/

