From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: qemu drive-mirror to rbd storage : no sparse rbd image
Date: Mon, 13 Oct 2014 09:06:01 +0200
Message-ID: <543B79D9.2000806@redhat.com>
References: <9fe0fedc-802d-4838-b738-c3d0932eeeda@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:62509 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbaJMHGs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 03:06:48 -0400
Received: by mail-wg0-f49.google.com with SMTP id x12so7951131wgg.20
        for <ceph-devel@vger.kernel.org>; Mon, 13 Oct 2014 00:06:47 -0700 (PDT)
In-Reply-To: <9fe0fedc-802d-4838-b738-c3d0932eeeda@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>

Il 13/10/2014 08:06, Alexandre DERUMIER ha scritto:
> 
> Also, about drive-mirror, I had tried with detect-zeroes with simple qcow2 file, 
> and It don't seem to help.
> I'm not sure that detect-zeroes is implement in drive-mirror.
> 
> also, the target mirrored volume don't seem to have the detect-zeroes option
> 
> 
> # info block
> drive-virtio1: /source.qcow2 (qcow2)
>     Detect zeroes:    on
> 
> #du -sh source.qcow2 : 2M
> 
> drive-mirror  source.qcow2 -> target.qcow2
> 
> # info block
> drive-virtio1: /target.qcow2 (qcow2)
> 
> #du -sh target.qcow2 : 11G
> 

Ah, you're right.  We need to add an options field, or use a new
blockdev-mirror command.

Paolo
