From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Computation in the storage
Date: Fri, 2 Dec 2016 11:40:16 +0000
Message-ID: <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de>
References: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53207 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbcLBLkU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Dec 2016 06:40:20 -0500
In-Reply-To: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nebil.benmabrouk@orange.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/02/2016 11:03 AM, nebil.benmabrouk@orange.com wrote:
> Hello,
>
> I  am interested in embedding some specific data processing in the storage close to the data.
> I read that, we can integrate some code (e.g., java classes) in Ceph, but I find no documentation about it.

What you are looking is actually 'rados object classes' (or ceph 
classes, according to the docs), and you may find a brief remark about 
that here

  http://docs.ceph.com/docs/master/architecture/#extending-ceph

which contains pointers to the code you should look into.

Somehow it feels like there should be some more information about this 
somewhere, but I can't really recall where.

   -Joao
