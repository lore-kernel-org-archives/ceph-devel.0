From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: dropping filestore+btrfs testing for luminous
Date: Fri, 30 Jun 2017 12:49:49 +0200
Message-ID: <20170630104949.cyaa4rlbwi5fqarq@suse.com>
References: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:52212 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdF3Ktx (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 30 Jun 2017 06:49:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2017-06-30T03:21:29, Sage Weil <sweil@redhat.com> wrote:

> The easiest thing is to
> 
> 1/ Stop testing filestore+btrfs for luminous onward.  We've recommended 
> against btrfs for a long time and are moving toward bluestore anyway.

+1. I believe all our users are on XFS, and I expect a rather
significant upconversion to BlueStore ASAP.

Regards,
    Lars

-- 
Architect SDS, Distinguished Engineer
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

