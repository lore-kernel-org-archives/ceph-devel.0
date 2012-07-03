From: Florian Haas <florian@hastexo.com>
Subject: Re: URL-safe base64 encoding for keys
Date: Tue, 3 Jul 2012 17:00:06 +0200
Message-ID: <CAPUexz8ThDn+pfqLT1azRMbHeQZP_q-_yD3O-10C=mZ5NnwYpw@mail.gmail.com>
References: <4FF2E40B.8090705@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50904 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab2GCPAH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 11:00:07 -0400
Received: by qcro28 with SMTP id o28so3657295qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 08:00:06 -0700 (PDT)
In-Reply-To: <4FF2E40B.8090705@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 3, 2012 at 2:22 PM, Wido den Hollander <wido@widodh.nl> wrote:
> Hi,
>
> With my CloudStack integration I'm running into a problem with the cephx
> keys due to '/' being possible in the cephx keys.
>
> CloudStack's API expects a URI to be passed when adding a storage pool,
> e.g.:
>
> addStoragePool?uri=rbd://user:cephxkey@monitor.addr/poolname
>
> If 'cephxkey' contains a / the URI parser in Java fails (java.net.URI) and
> splits the URI in the wrong place.
>
> For base64 there is a specification [0] that describes the usage of - and _
> instead of +  and /
>
> Is there a way that we change the bits in src/common/armor.c and replace the
> + and / for - and _?

FWIW (only semi-related), some S3 clients -- s3cmd from s3tools, for
example -- seem to choke on the forward slash in radosgw
auto-generated secret keys, as well.

Cheers,
Florian
