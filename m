Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DBA290DBB
	for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674898; cv=pass; b=p6GekAxmzRTGATOLhebzFb/9j7H7rZe8VYYVoE1vzI9PIvBKDzM74Lzr7PAM+UFM/8rH+kYNiKk66FW4r3vNboMp9qlfBZ8YrLIQSrmkRf5a2JrB9SQ9LeGHpRgwF/NJfiaDu7hiORPv6MEARLdfeLmhV9mtBzkrSJ0L+Apnpss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674898; c=relaxed/simple;
	bh=6Y3Ocfi3aFI+5qoBUkMChnK9MMprf2Q2tZ7QrGrPhyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1NvDYFH2QdbEIi+4TSZX7E9qJL58p3TzcSaermxx5EJ+RmabxUWYIVk84m3z3bBF29hozWqz+tKQ2P3Cqaomn2wPtxTNte8daTneK7B8uJsxYbmzYOfRj3eBT+ySgmghq/VlPpZd4RmUhDwQCEkz/8nv4TM0tynzKE62UYBT4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1akr2oB; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1akr2oB"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-128ebee22caso2306810c88.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 08:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674895; cv=none;
        d=google.com; s=arc-20240605;
        b=ADXfcpM7XmJb4BQaX7J5kyyrqD0Y3C5Jlrmr1Ggt6543cx46iTA19TmagHi2YFqkP4
         25LPZJF9T3knNa2zZ+lqZ76A5I6s2sg3+Ic19H9PIILKXAVATD9u8FC2bpb4MUmuFIpy
         iPHbVoIGdfK+F+WPuuB/ZNU05yViTfsmo9DA0DtClSW8Lvvm9AJJc/Xy0ogXSLOAvXM6
         ZWmNHiO/Sb7Q7wRqpesSJ1BU3TgLQzBkc01k4GFAQ4+IAbn9EW57n4myCTi1o25QZb1F
         5I+x9jAGB09RMvYPKk7VEwC6Ig6tVGmzAlbbUDno+p4iYtX6ignlwdUsLz4LRYNkhBYR
         g/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EvQAcxmqFLgzw1sjp3twnJxruWxSFSf3BC9/XVBhj6s=;
        fh=b4GPjcYzQh4CQ03wxSUd0cswHINRbuF6cdq/V3zj4tg=;
        b=VuhCZEXxSV915WuwxlWNGnJ+wVu8qO2GZrNAHcDMV+1v3SpKp1tZYiF+Q1D/hKmdrH
         CSoZKpybrq18XINSJCa3faROqAzRyFMZz+SmoBaXej21po3uNXNzZaMm0R20LEMM06dr
         qOzQ76qo2BzQab/WtIrRtKFE3HoCUMUYJ1SNRShR812Mp2nmd2DztVrfcnhHXn44Yys4
         2m2nnp0Ft8F3xLhWoCQW5awIaDO0gST/shZ7si9W8aftCwQvQtU/oal4qHR7Fu3kNhl6
         WKP2M9Rn5pS8tomfaOBXu+z5bKRFl2faU5kh/PMU0TYaYNWke0dz+1ioxOKDSZebAgrX
         09Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674895; x=1774279695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvQAcxmqFLgzw1sjp3twnJxruWxSFSf3BC9/XVBhj6s=;
        b=M1akr2oBu9OMSjBfQi0NjGIeXXHCFRZW6x4JoAy0QHQesD+yN9AzaBEBrZQHe1oPuJ
         7V0DubN8noFFGb0+qhr7x0EzwkiNxZmDcFjp9c+c0KFXkc+RVyUySZTC/nWkh6MibIaN
         wPQWNv7ijxKqDkhjFjWCY55F/P/YB2Ccaj7GDc6bszUPMHCG2tsu0dTjw8xsrdWdgUdV
         XI4pmTgBG1S9ILFeHqH103PQUxWUtd16NLjeS4OmsUJk4zvSW1Zqi6qGHEfa1Cz6xHCn
         Ms3vFsESD1OgR1JtSZ2kdr09se8u8DPrPo3N7djCcFzfpEt1t5+PgaBN6n+HFaFnZZkq
         Xb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674895; x=1774279695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvQAcxmqFLgzw1sjp3twnJxruWxSFSf3BC9/XVBhj6s=;
        b=s2uhks+qTJtUY2Th6+um7b+8duhhZrwzSP63MpSUzsB6N6UO8OsZmApx/P8NbFWwRL
         88PJTdOveDUe81b/6w97u7pq83NlKrrPKJ+vPokNu/k1DdwfIER+kcIN/lZmrttKpIXh
         xo+QXF4hPMie/zSfHCbkgwMgnSVftkkSGQGRVgY+xbbW3hxjLtyWWy64yTutsifRcbTR
         2i3V7OgsJ3kHBUNJ5XLgcnXyVLhDtp4pSDIIVskOWXIgixwcwba7uynba5MRiaxiF/OH
         ptrQxHLlgTL77pmTx3Ecd59Ow8dGPDwP/pkM9CxhkQxcFbwKuZob2rqJTU6mNyaRkLtZ
         g+8Q==
X-Gm-Message-State: AOJu0Yzoa0dLHIo5Jnx5Op2MaFdaGIOSiC28FyspFZoO/hZ+s7JG050s
	6vjSgNElCbe+wN0rqsrZ6KF0oXttGeSLrovOkj1xfPq8j7WgcOhWU7DcJ6gJFxwD2/tbB82Pvfp
	4zAnvpGVWx80e2x+IREz3MeazzqofiGNWlJQb
X-Gm-Gg: ATEYQzxO/odGSKZIFE4jf1lLOW0IAqDqe4HDMj2HWqgatvqVSwQ2r3k1xvyRHha6yBa
	dla+38iKetSUbRmysvrj2uToA1UnsVbDQ7lg2plPaqY7gewWxduD/+5penApwXVtBOMqvBRH3Cf
	xK52bawyR6hPKytIQYOF7w4SMGvvYE1O2do+rPy7OW3e1/7dMEFEtVBzzj+Sf4oqvuObiGPFl/l
	UAHrtwLFaqamHbUia+Ih3OngjWge/c88Ka2zO9vY1uvYYLD/cHT6v9t5qkA96AyyhuMahbHMuVC
	0NcCpS4=
X-Received: by 2002:a05:7022:4394:b0:119:e56b:958a with SMTP id
 a92af1059eb24-128f3d65964mr6491614c88.15.1773674894710; Mon, 16 Mar 2026
 08:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312081619.40854-1-ionut.nechita@windriver.com> <20260312081619.40854-14-ionut.nechita@windriver.com>
In-Reply-To: <20260312081619.40854-14-ionut.nechita@windriver.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 16 Mar 2026 16:28:03 +0100
X-Gm-Features: AaiRm52NqoyRuxYd-YVn5lM4dO9V-pzvp2X1rAqpG3Z3Q6xIAnjlBvyafX3UseU
Message-ID: <CAOi1vP_OYc2LKQV5PRRMM4G9C1-cxpq3Ts2p8Xbt0+hVwZXX6Q@mail.gmail.com>
Subject: Re: [PATCH v1 13/13] libceph: force host network namespace for kernel
 CephFS mounts
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: ceph-devel@vger.kernel.org, xiubli@redhat.com, 
	linux-kernel@vger.kernel.org, ionut_n2001@yahoo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:17=E2=80=AFAM Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> wrote:
>
> From: Ionut Nechita <ionut.nechita@windriver.com>
>
> In containerized environments (e.g., Rook-Ceph CSI with
> forcecephkernelclient=3Dtrue), the mount() syscall
> for kernel CephFS may be invoked from a pod's network namespace
> instead of the host namespace. This happens despite the CSI node
> plugin (csi-cephfsplugin) running with hostNetwork: true, due to
> race conditions during kubelet restart or pod scheduling.

Hi Ionut,

Can you elaborate on these race conditions?  It sounds like a bug or
a misconfiguration in the orchestration in userspace that this patch is
trying to work around in the kernel client.

>
> ceph_messenger_init() captures current->nsproxy->net_ns at mount
> time and uses it for all subsequent socket operations. When a pod
> NS is captured, all kernel ceph sockets (mon, mds, osd) are
> created in that namespace, which typically lacks routes to the
> Ceph monitors (e.g., fd04:: ClusterIP addresses).
> This causes permanent EADDRNOTAVAIL (-99) on every connection
> attempt at ip6_dst_lookup_flow(), with no possibility of recovery
> short of force-unmount and remount from the correct namespace.

What network provider (in the sense of [1]) are you using?

>
> Root cause confirmed via kprobe tracing on ip6_dst_lookup_flow:
> the net pointer passed to the routing lookup was the pod's
> net_ns (0xff367a0125dd5780) instead of init_net
> (0xffffffffbda76940). The pod NS had no route for fd04::/64
> (monitor ClusterIP range), while userspace python connect() from
> the same host succeeded because it ran in host NS.
>
> Fix this by always using init_net (the host network namespace)
> in ceph_messenger_init(). The kernel CephFS client inherently
> requires host-level network access to reach Ceph monitors, OSDs,
> and MDS daemons. Using the caller's namespace was inherited from
> generic socket patterns but is incorrect for a kernel filesystem

This behavior wasn't inherited but actually introduced as a feature in
commit [2] at someone's request.  Prior to that change attempting to
mount a CephFS filesytem or map an RBD image from anywhere but init_net
produced an error, see commit [3].

I'm going to challenge your "incorrect for a kernel filesystem" claim
because NFS, SMB/CIFS, AFS and likely other network filesystem clients
in the kernel behave the same way.  Mounts outside of init_net are
allowed with the mounting process network namespace getting captured
and used when creating sockets.

> client that must survive beyond the lifetime of the mounting
> process and its network namespace.

Network namespaces are reference counted and CephFS grabs a reference
for the namespace it's mounted in.  The namespace should persist for as
long as the CephFS mount persists even if the mounting process goes
away: another process should be able to enter that namespace, etc.  The
namespace can of course get wedged by the orchestration tearing down
the relevant virtual network devices prematurely, but it's a separate
issue.

>
> A warning is logged when a mount from a non-init namespace is
> detected, to aid debugging.
>
> Observed in production (kernel 6.12.0-1-rt-amd64, Ceph Reef
> 18.2.5, IPv6-only cluster, ceph-csi v3.13.1):
>   - Fresh boot of compute-0, ceph-csi mounts CephFS via kernel
>   - All monitor connections fail with EADDRNOTAVAIL immediately
>   - kprobe confirms wrong net_ns in ip6_dst_lookup_flow
>   - Workaround: umount -l + systemctl restart kubelet
>   - After restart: mount captures host NS, works immediately

[1] https://github.com/rook/rook/blob/master/Documentation/CRDs/Cluster/net=
work-providers.md
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D757856d2b9568a701df9ea6a4be68effbb9d6f44
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Deea553c21fbfa486978c82525ee8256239d4f921

Thanks,

                Ilya
