Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547433988FD
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898975; cv=none; b=C0l6lZmQEdRibvJDjxdIOEwFHmgXhLndloSCYdZY4pppoDtcJfKbbILEZGFd2wMWf8He9NgHWD7+wMnE7ChBdRD+qk4vze1WXmcHRH+6Y5rqYhGYyM9P/G0h8fydR7yUOs/5sC6g+eeykaohLTYZaoQBHC8xDXlL+QX14nkFw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898975; c=relaxed/simple;
	bh=X86a7N9ZpC9u6NXVCkcFZwesqPOJzoytuyIsGiuOQ+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHpvKKpULRhd0hhwHatXkVPxnXSD7mpsp0UYPWBXh3SoF6yvpBwQxh+SVaGM1a2o4kgqOZLXK4irx0byWx+TbbHxuEUno65gnEFwXIhlORit/VtdfVVWjDQZJEmo4RMeCD197Gd8o0kBG7UR7GhANxIcZLe7wytdKFzMsU8cykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUTsIPKx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nZdTbaTG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUTsIPKx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nZdTbaTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774898973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSbjPk4tV6YwISVAiI3NPdQ7cwRG2Qk80T6WiBS4eIs=;
	b=hUTsIPKxgFNpCIKRxFGm95D/JhUp5pIY8gKNKEuCm8e/9Xz/DmhIXPgPzek535u+Ibxg85
	NgFxzK+QV6x0YHmJgjhdy0RxpTJDqW2ay4+PHg47SzT5Sl4QTmkauCBYJyRGl/X0utZ9c7
	Mw//uD48XeE9rwQTP/BqGkTILTdmi9E=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-qxtXQkU5PLey8-t3EqkWEQ-1; Mon, 30 Mar 2026 15:29:31 -0400
X-MC-Unique: qxtXQkU5PLey8-t3EqkWEQ-1
X-Mimecast-MFC-AGG-ID: qxtXQkU5PLey8-t3EqkWEQ_1774898971
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6501528b1caso2468011d50.2
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774898971; x=1775503771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LSbjPk4tV6YwISVAiI3NPdQ7cwRG2Qk80T6WiBS4eIs=;
        b=nZdTbaTGNRDuFZOgkL1m4nrT/jXWpa5odeFpavzF5V3rBD6UwHfQ/w5GrmSLzP8yJu
         67O3OsoFKk/RHLfugdnE1OJdBaDr4OfaByhXcWhGHOZCfJQwHmn8Er/5hm8uwwiVq2Vx
         32nbDW2ww7UuEV7KGobuaVRzPAkUmv3iyCSp+HYBBNitcP66whFT170o9I9Elj5ujlGm
         Ub2WuPV5aXiDWd2tp6aWjvnkXDDwG05aTxI9T5o3VCk0gl+Rg6yq8qDor/LCQBAOvaRV
         4c3A2pENqKT2L/kZaY7BmHo2ginBlirILM6GE55KgeRtvw3EyLbcwG51eVBvyGycf+sQ
         as3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898971; x=1775503771;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSbjPk4tV6YwISVAiI3NPdQ7cwRG2Qk80T6WiBS4eIs=;
        b=Id1fx7BK/TMWnlhgoLrytdHkGq0+he+vpWVklu4SR1OEM2TSYXoJSZ4mWuZdxO+fhu
         0TTTGFLmnO9WQE54b9Zrr2ta+L5Hw1uwafny8YwrbP7J5OFnwJV4QnTfukbNy2ZqRvV3
         S5pFrE1XkqJyLtZXx13bjaZ+WSHJLQjjZtTLP7UZCDSD3b0DpCmYloKdWi091aJjJRQp
         kgUm91fAC3ThhqM8x49gKq9yGqKcAHHwYfo//lhkMJagZRoAQ5+uthx8slAy+ldoFIy9
         VpED3syjlDTAUO726ZfQsIqOO6Xgu8bJ283MXcqfxUtznkFxWC5ZOYa1bXx045QyAjre
         O0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMh0l1TPRqjmwx13n0D5dtnoRXhAX9GvTuSsfCzw+uTYMVHsEesRNhueybuRef+kIx8hiZ16b50Bt/@vger.kernel.org
X-Gm-Message-State: AOJu0YzegpGXbjckgo6Lcb7dnXpMU6M6VMYchzNkP74goSn2KNxtL4GP
	ijbFJby3SQ8RY9NWMmdEX3iE8V4LjpTZjTGSJdSSOYl2UuaIW+atvUxYl41Gc8J8+3WJNXWjzjR
	hF6lBx1THVGyUD/ANu4UmtfLw3TPz3kZYYh5a9HjMwx+5jp+My3AnRhHD0sdAcLI=
X-Gm-Gg: ATEYQzxe6Fsqkp4eBqhZu4R+nH+u74+mI++4g+URZ8BEVKA/nGFl84SSZdLTfnGVQVe
	+wK+nFgQhOeMTZmJUaGyNJUDyNcais5AEt+7k9ZDtaTi8+kZu43mrOIqgN9Kg+ci1Vl66ZOjlNp
	/Cb7wyNLEHQF/XcxjyC9F6sL0d0XWlI3cuw1mLvzoGodVJhBUz1xjw8on/km2RUDd/wuQCQR+CC
	Ko+pXxRRIa03gI4PWAus0M3nDCldG7aHeuUSVOqq+j09mtOpX1glANJ0c1FoAOT1P5f0vA7DVaI
	06h8t7tXS6IV2GJSxCuWd/F9cHTFL+Duj3hP1nVvt7ixrgoDC0wfYNuE286z0i+5F0/COV7JtZ+
	GhKaehyF91C4KTHwFDNd98ey66d3VfogkmsJkq7UkXE2xOExDfCJY
X-Received: by 2002:a05:690e:13cd:b0:650:1a14:b2e5 with SMTP id 956f58d0204a3-6501a14b8e8mr5673952d50.6.1774898970475;
        Mon, 30 Mar 2026 12:29:30 -0700 (PDT)
X-Received: by 2002:a05:690e:13cd:b0:650:1a14:b2e5 with SMTP id 956f58d0204a3-6501a14b8e8mr5673925d50.6.1774898969994;
        Mon, 30 Mar 2026 12:29:29 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6500934ce74sm4441184d50.16.2026.03.30.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:29:29 -0700 (PDT)
Message-ID: <80ced2fd4d2dbaeaf2142875cd9b61557bb45d8e.camel@redhat.com>
Subject: Re: [PATCH v1 0/10] ceph: add manual client reset and selftests
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Mon, 30 Mar 2026 12:29:28 -0700
In-Reply-To: <20260327143045.1393612-1-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 14:30 +0000, Alex Markuze wrote:
> Manual client reset gives operators a way to break client/MDS capability
> ownership stalemates without unmounting the client. The reset blocks new
> metadata work, gives dirty state a bounded chance to drain, asks each MDS
> to close the session, and then tears the local sessions down so the clien=
t
> can rebuild clean state.
>=20
> The debugfs interface in this series is only the control surface used to
> develop and validate the reset flow. It is not the core feature, and the
> long-term intent is to have the client trigger the reset automatically
> when it detects the stuck condition.
>=20
> A reconnect-only reset would require MDS support for accepting reconnects
> outside the normal MDS RECONNECT phase. Because that support does not
> exist today, the series first wires up the reconnect-based worker for
> validation and then switches the recovery path over to direct session
> teardown.
>=20
> I split the work into smaller reviewable steps so the preparatory cleanup
> lands first, then the reset framework and control path, then the initial
> worker, then the direct-teardown refinements, and finally the single-clie=
nt
> selftests and validation harness.
>=20
> Patch breakdown:
> - 1/10 converts the Ceph inode flags to named bit positions and keeps the
>   file-lock error bit ready for atomic bitops.
> - 2/10 adds a bounded wait and diagnostics to wait_caps_flush().
> - 3/10 adds reset state tracking and blocks new metadata requests and loc=
k
>   acquisition while reset is in progress.
> - 4/10 adds the manual reset debugfs control surface, status reporting
>   plumbing, scheduling hooks, and tracepoints.
> - 5/10 adds the initial reconnect-based reset worker and the reconnect
>   completion tracking needed by that worker.
> - 6/10 switches reset recovery from reconnect to direct session teardown.
> - 7/10 adds the explicit reset state machine, bounded drain phase, and
>   richer status reporting.
> - 8/10 removes reconnect bookkeeping left behind by the direct-teardown
>   design.
> - 9/10 queues CEPH_SESSION_REQUEST_CLOSE before the forced teardown so
>   the MDS can release state immediately.
> - 10/10 adds the single-client stress, corner-case, and validation tests
>   used to exercise the reset flow, and passes the configured debugfs root
>   through the validation wrapper so child scripts observe the same client
>   namespace.
>=20
> Alex Markuze (10):
>   ceph: convert inode flags to named bit positions
>   ceph: add bounded timeout and diagnostics to wait_caps_flush()
>   ceph: add client reset state and request gating
>   ceph: add manual reset debugfs control and trace plumbing
>   ceph: implement reconnect-based manual reset worker
>   ceph: replace reconnect with direct session teardown in manual reset
>   ceph: add reset state machine, drain phase, and status reporting
>   ceph: drop reset reconnect bookkeeping after direct teardown switch
>   ceph: send SESSION_REQUEST_CLOSE before forced teardown in manual
>     reset
>   ceph: add single-client reset selftests and validation harness
>=20
>  fs/ceph/caps.c                                |   7 +
>  fs/ceph/debugfs.c                             | 172 ++++-
>  fs/ceph/file.c                                |   2 +-
>  fs/ceph/locks.c                               |  24 +-
>  fs/ceph/mds_client.c                          | 630 +++++++++++++++-
>  fs/ceph/mds_client.h                          |  38 +-
>  fs/ceph/super.h                               |  60 +-
>  include/trace/events/ceph.h                   |  60 ++
>  tools/testing/selftests/filesystems/Makefile  |   1 +
>  .../selftests/filesystems/ceph/HOWTO.md       | 121 +++
>  .../selftests/filesystems/ceph/Makefile       |   6 +
>  .../selftests/filesystems/ceph/README.md      |  40 +
>  .../filesystems/ceph/reset_corner_cases.sh    | 707 ++++++++++++++++++
>  .../filesystems/ceph/reset_stress.sh          | 682 +++++++++++++++++
>  .../filesystems/ceph/run_validation.sh        | 317 ++++++++
>  .../filesystems/ceph/validate_consistency.py  | 291 +++++++

I don't see any selftests as part of the patchset. Is it some mistake?

Thanks,
Slava.

>  16 files changed, 3105 insertions(+), 53 deletions(-)
>  create mode 100644 tools/testing/selftests/filesystems/ceph/HOWTO.md
>  create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/ceph/README.md
>  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner=
_cases.sh
>  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stress=
.sh
>  create mode 100755 tools/testing/selftests/filesystems/ceph/run_validati=
on.sh
>  create mode 100755 tools/testing/selftests/filesystems/ceph/validate_con=
sistency.py

