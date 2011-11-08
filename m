From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: Problem with radosgw in 0.37
Date: Tue, 8 Nov 2011 14:33:43 -0800
Message-ID: <CAC-hyiGE29Q+vQ6MoMDxL6xYrqLVW6oQBkM4AnpFEiV7aJP3tA@mail.gmail.com>
References: <CAMwB3ThOq=z9ELN+dQkg2pif_Q_CXsJoU2D7wR4MMrnbwSVDYA@mail.gmail.com>
	<CAC-hyiE5VYLzN6L5rkVCG7SeTJ4qPdRGvVCpZzCrPgiaD7zsDg@mail.gmail.com>
	<CAMwB3TiJPSzpSTP5LN5LQZm=7iNgXO8W3s33aXptKy8JaU6jTA@mail.gmail.com>
	<CAC-hyiG84ni-Pw-57pccXDS5jOUyOQ99G5BjQHE6UBj5i1ZCQA@mail.gmail.com>
	<CAMvP8PB08=6x56bnm1bnAdPAqj-QMk5RG3rvx4hS3u8Ni7Tuhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40156 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab1KHWdo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 17:33:44 -0500
Received: by bke11 with SMTP id 11so884789bke.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2011 14:33:43 -0800 (PST)
In-Reply-To: <CAMvP8PB08=6x56bnm1bnAdPAqj-QMk5RG3rvx4hS3u8Ni7Tuhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>, ceph-devel@vger.kernel.org

On Tue, Nov 8, 2011 at 2:26 PM, Tomasz Paszkowski <ss7pro@gmail.com> wrote:
> One more quick question. Is it possible to setup multiple hosts with
> radosgw operating on single bucket ?
>

Yes. Operations on objects are atomic. Also, any changes to buckets
metadata are synchronized between the different rgw instances (if you
have cache turned on, otherwise it's not an issue anyway).

Yehuda
