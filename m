From: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Subject: RE: Comments on Ceph distributed parity implementation
Date: Thu, 20 Jun 2013 18:23:16 -0700
Message-ID: <622F4407872BA447A16110F65453358C01A4D8066EE7@FMSAMAIL.fmsa.local>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org>
 <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local>
 <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org>
 <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local>
 <51C00FDB.6030803@polytech.univ-nantes.fr>
 <3E438C2F-0779-4824-9C05-ABE4B5803E05@cs.utk.edu>
 <51C34932.4080304@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fujitsu24.fnanic.fujitsu.com ([192.240.6.14]:38228 "EHLO
	fujitsu24.fnanic.fujitsu.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423019Ab3FUBUJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 Jun 2013 21:20:09 -0400
In-Reply-To: <51C34932.4080304@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On 06/20/2013 11:26 PM, Loic Dachary wrote:
> 
> I wrote down a short description of the read/write path I plan to
> implement in ceph :
https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasure-code.rst.
> A quick look at the drawings will hopefully give you an idea. Each OSD is > a disk connected to the others over the network. Although I chose K+M = 5 > I suspect the most common use case will be around K+M = 7+3 = 10

Hi Loic,

A couple questions regarding your proposal:

Where would encode/decode occur? Client or OSD? Previous discussions seemed to want it at the OSD level. Your proposal seems that it could be either.

What about partial reads? For example, if only 'H' was requested, would you decode the entire object first? Or, read from OSD1 and reconstruct on error?

Thanks,
Paul
