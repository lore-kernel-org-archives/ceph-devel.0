From: Sage Weil <sage@newdream.net>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Wed, 16 Dec 2015 14:33:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512161431530.10312@cobra.newdream.net>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com> <20151215142304.GI31644@suse.de> <CAHMeWhFeSTd8w9zjoN1E=3ks7EysziFa_MRxNV4_oua18omRNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50705 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914AbbLPWeA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 17:34:00 -0500
In-Reply-To: <CAHMeWhFeSTd8w9zjoN1E=3ks7EysziFa_MRxNV4_oua18omRNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Kupczyk <akupczyk@mirantis.com>
Cc: Lars Marowsky-Bree <lmb@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 16 Dec 2015, Adam Kupczyk wrote:
> On Tue, Dec 15, 2015 at 3:23 PM, Lars Marowsky-Bree <lmb@suse.com> wrote:
> > On 2015-12-14T14:17:08, Radoslaw Zarzynski <rzarzynski@mirantis.com> wrote:
> >
> > Hi all,
> >
> > great to see this revived.
> >
> > However, I have come to see some concerns with handling the encryption
> > within Ceph itself.
> >
> > The key part to any such approach is formulating the threat scenario.
> > For the use cases we have seen, the data-at-rest encryption matters so
> > they can confidently throw away disks without leaking data. It's not
> > meant as a defense against an online attacker. There usually is no
> > problem with "a few" disks being privileged, or one or two nodes that
> > need an admin intervention for booting (to enter some master encryption
> > key somehow, somewhere).
> >
> > However, that requires *all* data on the OSDs to be encrypted.
> >
> > Crucially, that includes not just the file system meta data (so not just
> > the data), but also the root and especially the swap partition. Those
> > potentially include swapped out data, coredumps, logs, etc.
> >
> > (As an optional feature, it'd be cool if an OSD could be moved to a
> > different chassis and continue operating there, to speed up recovery.
> > Another optional feature would be to eventually be able, for those
> > customers that trust them ;-), supply the key to the on-disk encryption
> > (OPAL et al).)
> >
> > The proposal that Joshua posted a while ago essentially remained based
> > on dm-crypt, but put in simple hooks to retrieve the keys from some
> > "secured" server via sftp/ftps instead of loading them from the root fs.
> > Similar to deo, that ties the key to being on the network and knowing
> > the OSD UUID.
> >
> > This would then also be somewhat easily extensible to utilize the same
> > key management server via initrd/dracut.
> >
> > Yes, this means that each OSD disk is separately encrypted, but given
> > modern CPUs, this is less of a problem. It does have the benefit of
> > being completely transparent to Ceph, and actually covering the whole
> > node.
> Agreed, if encryption is infinitely fast dm-crypt is best solution.
> Below is short analysis of encryption burden for dm-crypt and
> OSD-encryption when using replicated pools.
> 
> Summary:
> OSD encryption requires 2.6 times less crypto operations then dm-crypt.

Yeah, I believe that, but

> Crypto ops are bottleneck.

is this really true?  I don't think we've tried to measure performance 
with dm-crypt, but I also have never heard anyone complain about the 
additional CPU utilization or performance impact.  Have you observed this?

sage
