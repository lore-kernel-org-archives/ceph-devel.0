From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 00/11 linux-next] super magic values consolidation
Date: Sun, 28 May 2017 14:00:18 +0200 (CEST)
Message-ID: <958803264.435844.1495972818238.open-xchange@webmail.nmp.proximus.be>
References: <20170521153947.26281-1-fabf@skynet.be> <20170528093401.GD14519@infradead.org>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailsec108.isp.belgacom.be ([195.238.20.104]:50470 "EHLO
        mailsec108.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751116AbdE1MAU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 28 May 2017 08:00:20 -0400
In-Reply-To: <20170528093401.GD14519@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mtd@lists.infradead.org, pvfs2-developers@beowulf-underground.org, ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net



> On 28 May 2017 at 11:34 Christoph Hellwig <hch@infradead.org> wrote:
>
>
> On Sun, May 21, 2017 at 05:39:47PM +0200, Fabian Frederick wrote:
> > This small patchset reorganizes magic.h and fixes filesystems
> > which defined locally super magic values.
>
> And what's the point?

Current magic.h organization is strange for the less. Filesystems generally use
SUPER_MAGIC values from magic.h
instead of a local definition plus it looks easier for new subsystems to look at
just one file when
seeking for unique value.
