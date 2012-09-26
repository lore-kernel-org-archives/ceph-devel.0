From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Hardware Requirements for RADOS Gateway Cluster
Date: Wed, 26 Sep 2012 09:02:09 -0700
Message-ID: <CADvuQREFXfwDGugdvXks2Uc0Fo2rqMHYUYdWF5TaDnAfQ4zmpA@mail.gmail.com>
References: <5060E5AE.10400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47643 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab2IZQCa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Sep 2012 12:02:30 -0400
Received: by qchd3 with SMTP id d3so249053qch.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Sep 2012 09:02:30 -0700 (PDT)
In-Reply-To: <5060E5AE.10400@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brice Burgess <briceburg@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 24, 2012 at 3:58 PM, Brice Burgess <briceburg@gmail.com> wrote:
> 1. Is it preferable to run the RADOS Gateway on a MDS machine [for latency
...
> My assumption is to provision a dedicated machine for the RADOS Gateway. I'd
> treat this machine as a "front end proxy/caching server" meaning it would
> have a lot of RAM for varnish/nginx and a low latency, high throughput
> network connection to the ODS/MDS machines as well as one to the public
> network.

Just to make sure you realize this: radosgw does not use MDS in any way.
