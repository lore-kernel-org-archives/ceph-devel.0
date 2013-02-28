From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] snapshot, clone and mount a VM-Image
Date: Thu, 28 Feb 2013 15:42:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302281536130.4819@cobra.newdream.net>
References: <5118C6BF.70207@risc-software.at> <5118FA0D.606@42on.com> <5118FB31.6020902@risc-software.at> <alpine.DEB.2.00.1302110624370.5429@cobra.newdream.net> <511D3A35.7090702@mermaidconsulting.dk> <alpine.DEB.2.00.1302141241020.22023@cobra.newdream.net>
 <511F72D2.5020104@mermaidconsulting.dk> <512FE957.9040703@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47587 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab3B1Xm2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 18:42:28 -0500
In-Reply-To: <512FE957.9040703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

On Thu, 28 Feb 2013, Josh Durgin wrote:
> On 02/16/2013 03:51 AM, Jens Kristian S?gaard wrote:
> > We could opt for storing it inside a plain text file that accompanies
> > the QCOW2 file, or tarballing the qcow2 file and that plain text file.
> 
> qcow2 seems like a good initial format given the existing tools. We
> could always add another format later, or wrap it with extra
> information like you suggest.
> 
> Have you had a chance to start implementing this yet? It'd be great to
> get it working in the next month.

Just so you know, David has been working on the librados "list snaps" 
operation that you'll need to let the tool tell what blocks have changed 
or not.  The code is currently in the wip-4207 branch.  We expect it will 
be merged in the next few days, and should be part of v0.59.

I suspect the next step would be a function in the 'rbd' tool that would 
do the export.  Then a similar 'import' tool to go with it?

sage
