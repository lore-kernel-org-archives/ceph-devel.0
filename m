Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC42561AE
	for <ceph-devel@vger.kernel.org>; Wed,  4 Feb 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215399; cv=pass; b=egjUMg8RWOdS/X7KyCo46aKMUNvB7CoJwVWghj2DIYCVqQbuy8RO1YE6BPd7HHpCOYrotKjk1EkGFCef8Kmb2fKiVkQ+OdYtIP6zZOvPHqHx6i8r7olH3v2/+fCZC+aYqhAQdc7jLgnjjiG2g1l4HQuj0Q+kEwdecRYi2YGBFcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215399; c=relaxed/simple;
	bh=4bR1WQ//awwtY8UZFvYfjpupVm/Okq3XOKJK4LsOBUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8P6qJiNvZ5elTRh8rdwPD2WszVxc2OkrB/lui9TKPd0Ka6a2KvFLnLUAThx7fqZHwrrWh4GYNENbxLeXIpafu4xrSLz0VgeiBdp2m9KnxodeL3sMtrPKJTzX8qpldwbuB3rhvqxzdUwwptSKm1fI3KN7f5lhSXe9TqKdlkA2mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaEpGAsc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H94vAG1Q; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaEpGAsc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H94vAG1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770215397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CrlylOt7/ZLcZBe8+ZM6SmnzGXWVMDIrtWQVsJb+4g=;
	b=GaEpGAsc/tgTHm90ixzRTA9+lRBw8K8lgYpD6gEvZ8d7y2FCUaeLS28Y70Wy0InJI+Rsa2
	+3tZhfe7BVzGS39JaaSZhnC91amKGZY8+eMzFIESRbw6vlYi1Ld4cL0GXicycoJB6Yt33Z
	HTfcuHdcRUifXfgYEgv/o/Q9vi/DEgE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-jclF-7vQOXKhnVXec3-z7w-1; Wed, 04 Feb 2026 09:29:56 -0500
X-MC-Unique: jclF-7vQOXKhnVXec3-z7w-1
X-Mimecast-MFC-AGG-ID: jclF-7vQOXKhnVXec3-z7w_1770215395
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-59b6cbd5493so2296487e87.0
        for <ceph-devel@vger.kernel.org>; Wed, 04 Feb 2026 06:29:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215395; cv=none;
        d=google.com; s=arc-20240605;
        b=aJrPYibblC33+TgszvJMcqsFVWhtYgLXu9c6Zc9gVq6oyzRg+QMLnRgKPtq5xy3MjE
         TljQw6m7QjNkihUBXbEmsXIADOLsjIoEVq8swHx0p47WyPUVGDAGlpQZqEHMDCDe8trd
         qtG4j643GUk9H1x1sJYoQaib/waTPNWu6oaEr6Xpw8HEBwlHq0hJ1ngGCbZlgE3grgAF
         kwfrpWerbk3PRHtEo3h8NlF6OvQKksE/sfSH837+GtGZY3407xvz+bIsnsHZ8VGR8neM
         wSDs2w9IRzvHNzktprY3RHNYlek+0Rr5A4dmps0EFvK4SDzAARl1tcQcgd2cyH9Spffw
         Y+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1CrlylOt7/ZLcZBe8+ZM6SmnzGXWVMDIrtWQVsJb+4g=;
        fh=rGDJMGkirpIDueFind+JLGi14upyW8fuxL0wkUxUeQQ=;
        b=WrGErILTgXxqa8ZDVRncHQw/WVe7Dco1oRD90KFfemaB227aXAxK1ZECsBuLr3ekf7
         klO1gysIschP6qufd7WB/BQnSCZjWYRm4FuBh6pY4asUsI0JCmrr49xEXSMtYFmpnB1u
         h/I+mNyH5Xzrp4Q4G0suD7OL3eEzU49I3BHo+DEYVIstWJEpXpREFvF82QQtgzOGIq+n
         sMuetp/oNP9ceWQH4XCHdpxhnNiZIBW51AdWg6ztAB3auNsTFTrE2JU01dUxnyf276tH
         IDs6UI1nbvlxKJKmozXRjCrIYWDmMPaRGgmm+ZNgazNC9pfhHIr3uOkZXezAHq03xe5p
         jddg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770215395; x=1770820195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CrlylOt7/ZLcZBe8+ZM6SmnzGXWVMDIrtWQVsJb+4g=;
        b=H94vAG1Q8hWsJKRSiDeXnPxc1dCwsmv2oMtyw7QzIWF7k0bB+V0JDtnL1iwUujtQz9
         1KwHyn05z84UHQbqTkadYFfSBW7JzZpKRAeFO5/vrphTtl9/H39NbwxLyAjcUgAma8F4
         j9qnYNRibPRWZIWWtksEAbG5JpOsbZ3pB7qpJpVD5qcVrO6HavWtfQH2H7DtF+nwWvb/
         0cqtJo4LZYgss9WBno/rquxMJTSnI5Dvkn+anM/Tj6U8w/0a42Ae8MDXSRTLJx5DWzg+
         Xx+XvL/rR+vjwm3KnmJbLqnU+R7hO+UHE8RKOlt0wZJD6J1QNigXD2pDHdcfzGFB9yHP
         PQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215395; x=1770820195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1CrlylOt7/ZLcZBe8+ZM6SmnzGXWVMDIrtWQVsJb+4g=;
        b=Os9OabVoEcWh7zrpB4MzrjGjt8x3d4xjYnJbs92WJkcDYhb9adWigWdunXf3iZTW/I
         J5Bos7qKnlpQpED7/ZMDvcGn40fCzlkyyO7b3jnne0LFq7Y4s0MOgWvNH3vyO86GIyOh
         C52pENWBLi8YVoUDtyHVOxZTPh1plcuXsNiQNHLIqM3wrvbQHkOGKom9UF+ddhiqqi0F
         N06wB7raBQnmILkrgA8hl0rGjhaBRVqYhVtug9Gqr+45mcI/NIXMF2NrG4+T7v5/LjRk
         DukzU/ONdq3CwviqIUBg1ziYWYlshkH/uZ3S2pfEHtDsAeslq0gOBJtbkfVpHUSXy6vP
         zBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkDfEOAiG5KGw6gqPc0JZjjbH3HmUM1Oql2KnkpFmgADNE7o5dm8A0aNrVlj3xBXBC9WFbJClbnEFM@vger.kernel.org
X-Gm-Message-State: AOJu0YwB07g7FOrLgxRNC6ciMFPr3VSuBJ8pnwtRa/iyoWeYIeySxSNy
	+Air31VAXrdZH5meYUyO5o14kOjCnh9ZN81jxAToKPCbCRWkjFYCTJYYEJLOTKN2I91F75TnO+X
	X3oYGe/1GGS3s2VxyOciOxbOLkMIgbqrpPPndr+0i9TV3AAGdMIoDzafBePLaSI+kaeq2Y5yth9
	jPWeh6YEtXTbW1qmXKk114RX+EtbRznClldZDSvg==
X-Gm-Gg: AZuq6aKGOsNMfdAJkQVJ8/GDtDRX28NnoP7Y+3spvy4mne6l9T59UMzpdlK7QJqG0Ee
	4bQVLQPE1o/SraypIvUMPXsD1SuvDiCEh2dnqCZUuG29ctOFY+h+kLWKA3GzWRlaDD5F7NkdbP2
	AILX3lgJb43fxJ1cpxbrdmHYGuJEdc38HWQqZasxo4h9m0rppmqRYCs/wxVnfyHRXM2ZEjjm3AX
	MVoZtnHdO1jaCgBtWYRHptG5A==
X-Received: by 2002:a05:6512:b02:b0:59d:e306:c621 with SMTP id 2adb3069b0e04-59e38c4dbaemr1352532e87.48.1770215394509;
        Wed, 04 Feb 2026 06:29:54 -0800 (PST)
X-Received: by 2002:a05:6512:b02:b0:59d:e306:c621 with SMTP id
 2adb3069b0e04-59e38c4dbaemr1352517e87.48.1770215393965; Wed, 04 Feb 2026
 06:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203225445.1515933-2-slava@dubeyko.com> <CAOi1vP-xCUKhTqkEcy2-Hm586CJY=5eCE7gV8S34pO0R9ODYPQ@mail.gmail.com>
In-Reply-To: <CAOi1vP-xCUKhTqkEcy2-Hm586CJY=5eCE7gV8S34pO0R9ODYPQ@mail.gmail.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Wed, 4 Feb 2026 09:29:27 -0500
X-Gm-Features: AZwV_QjisY8Q7gX_rN2afCvb3KohgjLd3Mtho4B2VS1sPrCsfBS729zlKeiql-w
Message-ID: <CA+2bHPZriLYi9ecceVrhLFykqmk-sUNZtRxr99K7PJft3NYeQA@mail.gmail.com>
Subject: Re: [PATCH v6] ceph: fix kernel crash in ceph_open()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

On Wed, Feb 4, 2026 at 8:54=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> wr=
ote:
>
> On Tue, Feb 3, 2026 at 11:55=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > The CephFS kernel client has regression starting from 6.18-rc1.
> >
> > sudo ./check -g quick
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYN=
AMIC Fri
> > Nov 14 11:26:14 PST 2025
> > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch
> > /mnt/cephfs/scratch
> >
> > Killed
> >
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > (2)192.168.1.213:3300 session established
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL point=
er
> > dereference, address: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read a=
ccess in
> > kernel mode
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000=
) - not-
> > present page
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] =
SMP KASAN
> > NOPTI
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 345=
3 Comm:
> > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU St=
andard PC
> > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > ceph_mds_check_access+0x348/0x1760
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > __kasan_check_write+0x14/0x30
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x=
170
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > __pfx_apparmor_file_open+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > __ceph_caps_issued_mask_metric+0xd6/0x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/=
0x10e0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x=
50a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0=
x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > __pfx_stack_trace_save+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > stack_depot_save_flags+0x28/0x8f0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0x=
e/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x=
450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+=
0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d=
/0x2b0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > __check_object_size+0x453/0x600
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0x=
e/0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0=
x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > __pfx_do_sys_openat2+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x10=
8/0x240
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > __pfx___x64_sys_openat+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > __pfx___handle_mm_fault+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0=
x2350
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0x=
d50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/=
0xd50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > count_memcg_events+0x25b/0x400
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x3=
8b/0x6a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > irqentry_exit_to_user_mode+0x2e/0x2a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/=
0x50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95=
/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145=
ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3=
d 00 00
> > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c=
 ff ff ff
> > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 =
28 64 48
> > 2b 14 25
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d3=
16d0
> > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda =
RBX:
> > 0000000000000002 RCX: 000074a85bf145ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 =
RSI:
> > 00007ffc77d32789 RDI: 00000000ffffff9c
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 =
R08:
> > 00007ffc77d31980 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 =
R11:
> > 0000000000000246 R12: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff =
R14:
> > 0000000000000180 R15: 0000000000000001
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pm=
c_core
> > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_v=
sec
> > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesn=
i_intel
> > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgas=
tate
> > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc p=
pdev lp
> > parport efi_pstore
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000=
000000000
> > ]---
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> >
> > We have issue here [1] if fs_name =3D=3D NULL:
> >
> > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> >     ...
> >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
> >             / fsname mismatch, try next one */
> >             return 0;
> >     }
> >
> > v2
> > Patrick Donnelly suggested that: In summary, we should definitely start
> > decoding `fs_name` from the MDSMap and do strict authorizations checks
> > against it. Note that the `--mds_namespace` should only be used for
> > selecting the file system to mount and nothing else. It's possible
> > no mds_namespace is specified but the kernel will mount the only
> > file system that exists which may have name "foo".
> >
> > v3
> > The namespace_equals() logic has been generalized into
> > __namespace_equals() with the goal of using it in
> > ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> > The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
> >
> > v4
> > The __namespace_equals() now supports wildcard check.
> >
> > v5
> > Patrick Donnelly suggested to add the sanity check of
> > kstrdup() returned pointer in ceph_mdsmap_decode()
> > added logic. Also, he suggested much simpler logic of
> > namespace strings comparison in the form of
> > ceph_namespace_match() logic.
> >
> > v6
> > Only ceph_namespace_match() compares the names
> > with CEPH_NAMESPACE_WILDCARD.
> >
> > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > the goal of supporting the suggested concept. Now struct ceph_mdsmap
> > contains m_fs_name field that receives copy of extracted FS name
> > by ceph_extract_encoded_string(). For the case of "old" CephFS file sys=
tems,
> > it is used "cephfs" name. Also, namespace_equals() method has been
> > reworked with the goal of proper names comparison.
> >
> > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_clien=
t.c#L5666
> > [2] https://tracker.ceph.com/issues/73886
> >
> > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Patrick Donnelly <pdonnell@redhat.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/mds_client.c         | 11 +++++------
> >  fs/ceph/mdsmap.c             | 24 ++++++++++++++++++------
> >  fs/ceph/mdsmap.h             |  1 +
> >  fs/ceph/super.h              | 29 ++++++++++++++++++++++++-----
> >  include/linux/ceph/ceph_fs.h |  6 ++++++
> >  5 files changed, 54 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 7e4eab824dae..a4b9254b74a5 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
> >         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
> >         struct ceph_client *cl =3D mdsc->fsc->client;
> > -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespace=
;
> > +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
> >         const char *spath =3D mdsc->fsc->mount_options->server_path;
> >         bool gid_matched =3D false;
> >         u32 gid, tlen, len;
> > @@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >
> >         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
> >               fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)=
) {
> > +
> > +       if (!ceph_namespace_match(auth->match.fs_name, fs_name)) {
> >                 /* fsname mismatch, try next one */
> >                 return 0;
> >         }
> > @@ -6122,7 +6123,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_clien=
t *mdsc, struct ceph_msg *msg)
> >  {
> >         struct ceph_fs_client *fsc =3D mdsc->fsc;
> >         struct ceph_client *cl =3D fsc->client;
> > -       const char *mds_namespace =3D fsc->mount_options->mds_namespace=
;
> >         void *p =3D msg->front.iov_base;
> >         void *end =3D p + msg->front.iov_len;
> >         u32 epoch;
> > @@ -6157,9 +6157,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_clien=
t *mdsc, struct ceph_msg *msg)
> >                 namelen =3D ceph_decode_32(&info_p);
> >                 ceph_decode_need(&info_p, info_end, namelen, bad);
> >
> > -               if (mds_namespace &&
> > -                   strlen(mds_namespace) =3D=3D namelen &&
> > -                   !strncmp(mds_namespace, (char *)info_p, namelen)) {
> > +               if (namespace_equals(fsc->mount_options,
> > +                                    (char *)info_p, namelen)) {
> >                         mount_fscid =3D fscid;
> >                         break;
> >                 }
> > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > index 2c7b151a7c95..f0c0ed202184 100644
> > --- a/fs/ceph/mdsmap.c
> > +++ b/fs/ceph/mdsmap.c
> > @@ -353,22 +353,33 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct cep=
h_mds_client *mdsc, void **p,
> >                 __decode_and_drop_type(p, end, u8, bad_ext);
> >         }
> >         if (mdsmap_ev >=3D 8) {
> > -               u32 fsname_len;
> > +               size_t fsname_len;
> > +
> >                 /* enabled */
> >                 ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
> > +
> >                 /* fs_name */
> > -               ceph_decode_32_safe(p, end, fsname_len, bad_ext);
> > +               m->m_fs_name =3D ceph_extract_encoded_string(p, end,
> > +                                                          &fsname_len,
> > +                                                          GFP_NOFS);
> > +               if (IS_ERR(m->m_fs_name)) {
> > +                       m->m_fs_name =3D NULL;
> > +                       goto nomem;
> > +               }
> >
> >                 /* validate fsname against mds_namespace */
> > -               if (!namespace_equals(mdsc->fsc->mount_options, *p,
> > +               if (!namespace_equals(mdsc->fsc->mount_options, m->m_fs=
_name,
> >                                       fsname_len)) {
> >                         pr_warn_client(cl, "fsname %*pE doesn't match m=
ds_namespace %s\n",
> > -                                      (int)fsname_len, (char *)*p,
> > +                                      (int)fsname_len, m->m_fs_name,
>
> Hi Slava,
>
> Being returned from ceph_extract_encoded_string(), m->m_fs_name is
> guaranteed to be NULL-terminated, so it can be printed with %s just
> like mdsc->fsc->mount_options->mds_namespace.  The %*pE thing is
> redundant now.
>
> >                                        mdsc->fsc->mount_options->mds_na=
mespace);
> >                         goto bad;
> >                 }
> > -               /* skip fsname after validation */
> > -               ceph_decode_skip_n(p, end, fsname_len, bad);
> > +       } else {
> > +               m->m_enabled =3D false;
> > +               m->m_fs_name =3D kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);
> > +               if (!m->m_fs_name)
> > +                       goto nomem;
> >         }
> >         /* damaged */
> >         if (mdsmap_ev >=3D 9) {
> > @@ -430,6 +441,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
> >                 kfree(m->m_info);
> >         }
> >         kfree(m->m_data_pg_pools);
> > +       kfree(m->m_fs_name);
> >         kfree(m);
> >  }
> >
> > diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
> > index 1f2171dd01bf..d48d07c3516d 100644
> > --- a/fs/ceph/mdsmap.h
> > +++ b/fs/ceph/mdsmap.h
> > @@ -45,6 +45,7 @@ struct ceph_mdsmap {
> >         bool m_enabled;
> >         bool m_damaged;
> >         int m_num_laggy;
> > +       char *m_fs_name;
> >  };
> >
> >  static inline struct ceph_entity_addr *
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index a1f781c46b41..d2a586794226 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -104,18 +104,37 @@ struct ceph_mount_options {
> >         struct fscrypt_dummy_policy dummy_enc_policy;
> >  };
> >
> > +#define CEPH_NAMESPACE_WILDCARD                "*"
> > +
> > +static inline bool ceph_namespace_match(const char *pattern,
> > +                                       const char *target)
> > +{
> > +       if (!pattern || !pattern[0] ||
> > +           !strcmp(pattern, CEPH_NAMESPACE_WILDCARD))
> > +               return true;
> > +
> > +       if (strlen(pattern) !=3D strlen(target))
> > +               return false;
> > +
> > +       return !strncmp(pattern, target, strlen(pattern));
>
> What is the point of explicitly making sure that lengths match and then
> doing strncmp with the same/matching length (and on top of that running
> strlen the third time)?  Given that this is executed on every file open
> as well as in some other cases the overhead from these three strlen
> invocations, however negligible in isolation, may accumulate and become
> noticeable.  Can
>
>     if (strlen(pattern) !=3D strlen(target))
>             return false;
>
>     return !strncmp(pattern, target, strlen(pattern));
>
> be replaced with
>
>     return !strcmp(pattern, target);
>
> ?
>
> > +}
> > +
> >  /*
> >   * Check if the mds namespace in ceph_mount_options matches
> >   * the passed in namespace string. First time match (when
> >   * ->mds_namespace is NULL) is treated specially, since
> >   * ->mds_namespace needs to be initialized by the caller.
> >   */
> > -static inline int namespace_equals(struct ceph_mount_options *fsopt,
> > -                                  const char *namespace, size_t len)
> > +static inline bool namespace_equals(struct ceph_mount_options *fsopt,
> > +                                   const char *namespace, size_t len)
> >  {
> > -       return !(fsopt->mds_namespace &&
> > -                (strlen(fsopt->mds_namespace) !=3D len ||
> > -                 strncmp(fsopt->mds_namespace, namespace, len)));
> > +       if (!fsopt->mds_namespace || !fsopt->mds_namespace[0])
> > +               return true;
> > +
> > +       if (strlen(fsopt->mds_namespace) !=3D len)
> > +               return false;
> > +
> > +       return !strncmp(fsopt->mds_namespace, namespace, len);
>
> What is the rationale for changing the body of namespace_equals()?
> The existing code
>
>     return !(fsopt->mds_namespace &&
>              (strlen(fsopt->mds_namespace) !=3D len ||
>               strncmp(fsopt->mds_namespace, namespace, len)));
>
> doesn't treat any value specially -- the special provision is made only
> for the case of no value at all (i.e. mds_namespace =3D=3D NULL) as noted
> in the comment.
>
> This revision
>
>     if (!fsopt->mds_namespace || !fsopt->mds_namespace[0])
>             return true;
>
> treats the empty string value specially.  This changes the behavior of
> mount command when an empty string is passed for MDS namespace/fsname:
> previously it failed with ENOENT whereas now it would succeed and mount
> the filesystem that happens to be first on the list (similar to what was
> discussed for "mds_namespace=3D*" on the previous revisions).  Patrick
> should chime in, but I don't think this behavior is desired.

I think we can revert the change to namespace_equals, yes.


--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D

